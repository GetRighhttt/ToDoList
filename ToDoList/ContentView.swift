//
//  ContentView.swift
//  ToDoList
//
//  Created by Stefan Bayne on 11/13/22.
//

import SwiftUI

struct ContentView: View {
    
    /*
     Variable for todo items.
     */
    @State private var newTodo = ""
    @State private var listTodos: [TodoItem] = []
    
    /*
     Variable for user defaults.
     */
    private let userDefaultKey = ""
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        TextField("Add Something you Need to Do!", text: $newTodo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        //Buttons have actions and
                        Button(action: {
                            // if new todo is empty, return or add new item.
                            guard !self.newTodo.isEmpty else { return }
                            self.listTodos.append(TodoItem(todo: self.newTodo))
                            self.newTodo = ""
                            self.saveTodos()
                        }) {
                            // add plus sign at the end of Hstack
                            Image(systemName: "plus")
                                .font(.system(size: 20))
                        }.padding(.leading, 5)
                    }.padding()
                    
                    List {
                        ForEach(listTodos) { todoItem in
                            Text(todoItem.todo)
                            
                            /*
                             Left swipe actions for the list!
                             */
                                .swipeActions(edge: .leading) {
                                    Button {
                                        print("Saved")
                                    } label: {
                                        Label("Saved", systemImage: "square.and.arrow.down.on.square")
                                    }.tint(Color.green)
                                }
                            
                                .swipeActions {
                                    
                                    /*
                                     Here is how we add swipe actions, and customize them
                                     a little bit.
                                     */
                                    Button(role: .destructive) {
                                        print("Delete")
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    
                                    Button(role: .cancel){
                                        print("Cancel")
                                    } label: {
                                        Label("Cancel", systemImage: "x.circle")
                                    }.tint(Color.orange)
                                    
                                    Button{
                                        print("Present More")
                                    } label: {
                                        Label("More", systemImage: "ellipsis")
                                    }.tint(Color.yellow)

                                }
                                .padding(.bottom, 2)
                        }.onDelete(perform: deleteTodos)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                }
                .navigationBarTitle("Get It Done!")
            }
            .onAppear(perform: loadTodos)
        }
        
    }
    
    /*
     Method to save list of todo items so when the app closes, it saves.
     */
    private func saveTodos() {
        UserDefaults.standard.set( try?  PropertyListEncoder().encode(self.listTodos),
                                   forKey: userDefaultKey)
    }
    
    /*
     Methode to load todos, and read from user defaults.
     */
    private func loadTodos() {
        if let todosData = UserDefaults.standard.value(forKey: userDefaultKey) as? Data {
            if let todosList = try? PropertyListDecoder().decode(Array<TodoItem>.self, from: todosData) {
                self.listTodos = todosList
            }
        }
    }
    
    /*
     Method to delete todos at the proper index.
     */
    private func deleteTodos(at offsets: IndexSet) {
        self.listTodos.remove(atOffsets: offsets)
        saveTodos()
    }
}


/*
 This struct defines our todo item. We have an ID to
 sigvary which one is being selected, and a string to name
 the actual todo.
 */
struct TodoItem : Codable, Identifiable {
    var id = UUID()
    let todo: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

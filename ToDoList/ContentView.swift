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
            VStack {
                HStack {
                    TextField("Add Todo.", text: $newTodo)
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
                            .foregroundColor(Color.white)
                    }.padding(.leading, 5)
                }.padding()
                
                List {
                    ForEach(listTodos) { todoItem in
                        Text(todoItem.todo)
                            .padding(.bottom, 2)
                    }.onDelete(perform: deleteTodos)
                    .listRowBackground(Color.black)
                    .foregroundColor(Color.white)
                }
                .background(.cyan)
                .scrollContentBackground(.hidden)
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle("Todo List")
            .background(.cyan)
        }
        .onAppear(perform: loadTodos)
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

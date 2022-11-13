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
                    }) {
                        // add plus sign at the end of Hstack
                        Image(systemName: "plus")
                            .foregroundColor(Color.white)
                    }.padding(.leading, 5)
                }.padding()
                
                List {
                    ForEach(listTodos) { todoItem in
                        Text(todoItem.todo)
                    }
                    .listRowBackground(Color.black)
                    .foregroundColor(Color.yellow)
                }
                .background(.cyan)
                .scrollContentBackground(.hidden)
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle("Todo List")
            .background(.cyan)
        }
    }
    
    private saveTodos() {
        
    }
}


/*
 This struct defines our todo item. We have an ID to
 signify which one is being selected, and a string to name
 the actual todo.
 */
struct TodoItem : Codable, Identifiable {
    let id = UUID()
    let todo: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

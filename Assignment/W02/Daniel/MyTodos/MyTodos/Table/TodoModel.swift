//
//  TodoModel.swift
//  MyTodos
//
//  Created by 김성환 on 2021/02/28.
//

import Foundation

enum TodoModelError: Error {
    case idExistsFor(id: String)
    case idNotExistsFor(id: String)
}

class TodoModel {
    static let shared = TodoModel()
    var todoItems = Array<TodoItem>()
    
    var dateFormatter : DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormat
    }
    
    func addTodo(_ todoItem: TodoItem) throws {
        if isItemExists(for: todoItem) {
            throw TodoModelError.idExistsFor(id: todoItem.id)
        }
        
        todoItems.append(todoItem)
    }
    
    func removeTodo(for todoItem: TodoItem) throws {
        if !isItemExists(for: todoItem) {
            throw TodoModelError.idNotExistsFor(id: todoItem.id)
        }
        
        for i in 0...todoItems.count {
            if todoItems[i].id == todoItem.id {
                todoItems.remove(at: i)
                break
            }
        }
    }
    
    func addNoti(for todoItem: TodoItem) {
        
    }
    
    func removeNoti(for todoItem: TodoItem) {
        
    }
    
    func saveToJSON() {
        
    }
    
    func loadFromJSON() {
        todoItems.append(TodoItem(id: UUID().uuidString,
                                  title_text:"Memo1",
                                  memo:"TestMemo",
                                  isNotify: false,
                                  date: dateFormatter.string(from: Date())))
        todoItems.append(TodoItem(id: UUID().uuidString,
                                  title_text:"Memo2",
                                  memo:"Wow!",
                                  isNotify: false,
                                  date: dateFormatter.string(from: Date())))
        todoItems.append(TodoItem(id: UUID().uuidString,
                                  title_text:"Memo3",
                                  memo:"HaHa",
                                  isNotify: true,
                                  date: dateFormatter.string(from: Date())))
        
    
    }
    
    private func isItemExists(for todoItem: TodoItem) -> Bool {
        for item in todoItems {
            if item.id == todoItem.id {
                return true
            }
        }
        return false
    }
}

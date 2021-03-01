//
//  TodoModel.swift
//  MyTodos
//
//  Created by 김성환 on 2021/02/28.
//

import Foundation
import UserNotifications

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
        for i in 0..<todoItems.count {
            print(i)
            if todoItems[i].id == todoItem.id {
                todoItems[i] = todoItem
                return
            }
        }
        todoItems.append(todoItem)
        if todoItem.isNotify {
            addNoti(for: todoItem)
        }
    }
    
    func removeTodo(for todoItem: TodoItem) throws {
        if !isItemExists(for: todoItem) {
            throw TodoModelError.idNotExistsFor(id: todoItem.id)
        }
        
        for i in 0..<todoItems.count {
            if todoItems[i].id == todoItem.id {
                todoItems.remove(at: i)
                break
            }
        }
    }
    
    func addNoti(for todoItem: TodoItem) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if let error = error {
                print(error)
            } else {
                if granted {
                    let content = UNMutableNotificationContent()
                    content.title = todoItem.title_text
                    content.subtitle = todoItem.date
                    content.body = todoItem.memo
                    content.badge = 1
                    guard let date = TodoModel.shared.dateFormatter.date(from:todoItem.date) else {
                        print("FAILED")
                        return
                    }
                    let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    let trigger = UNCalendarNotificationTrigger(dateMatching:comps, repeats:false)
                    let request = UNNotificationRequest(identifier: todoItem.id, content: content, trigger: trigger)
                    notificationCenter.add(request, withCompletionHandler: nil)
                } else {
                    print("Not Granted")
                    
                }
                
            }
            
        }
        print("ADD NOTI SUCCESSFUL")
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

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
                delete(todoItems[i].id)
                deleteNoti(for:todoItems[i])
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
    
    func deleteNoti(for todoItem: TodoItem) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getPendingNotificationRequests { (notificationRequests) in
            var identifiers: [String] = []
            for notification:UNNotificationRequest in notificationRequests {
                if notification.identifier == todoItem.id {
                   identifiers.append(notification.identifier)
                }
            }
            notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }
    
    func saveToJSON() {
        for todo in todoItems {
            save(todo, with:todo.id)
            print("save: " + todo.title_text)
        }
    }
    
    func loadFromJSON() {
        todoItems.removeAll()
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path)
            for fileName in files {
                todoItems.append(load(fileName))
            }
        } catch {
            fatalError("Could not load any files")
        }
    }
    
    private func isItemExists(for todoItem: TodoItem) -> Bool {
        for item in todoItems {
            if item.id == todoItem.id {
                return true
            }
        }
        return false
    }
    
    private func save(_ object:TodoItem, with fileName:String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory:false)
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents:data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func load(_ fileName:String) -> TodoItem {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory:false)
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found at path \(url.path)")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let model = try JSONDecoder().decode(TodoItem.self, from:data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Data unavailable at path \(url.path)")
        }
    }
    
    private func delete(_ fileName:String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory:false)
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            }catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    private func getDocumentDirectory() -> URL {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to access document Directory")
        }
        return url
    }
}

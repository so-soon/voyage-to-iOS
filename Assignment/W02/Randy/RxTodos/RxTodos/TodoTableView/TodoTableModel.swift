//
//  TodoTableModel.swift
//  RxTodos
//
//  Created by Randy on 2021/02/27.
//

import Foundation
import UserNotifications

struct TodoData : Codable {
    var id : String
    var title : String
    var desc : String
    var date : Date
    var shouldNotify : Bool
    
    static let mockData = TodoData(id: "", title: "", desc: "", date: Date(), shouldNotify: true)
}

class TodoTableModel {
    var todoDataArray: [TodoData] = [TodoData(id: "asd", title: "asd", desc: "asd", date: Date(), shouldNotify: true)]
    
    private static var todoDataPathURL : URL {
        do{
            return try FileManager.default.url(for: FileManager.SearchPathDirectory.applicationSupportDirectory, in: FileManager.SearchPathDomainMask.userDomainMask,
                                                appropriateFor: nil,
                                                create: true).appendingPathComponent("todos.json")
        }catch{
            print(error.localizedDescription)
            return URL(string: "")!
        }
    }
    
    init() {
//        self.loadTodoDataFromJSON()
    }
    
    @discardableResult
    func loadTodoDataFromJSON() -> Bool{
        do{
            let jsonData : Data = try Data(contentsOf: TodoTableModel.todoDataPathURL)
            self.todoDataArray = try JSONDecoder().decode([TodoData].self, from: jsonData)
            return true
        }catch{
            print(error.localizedDescription)
            self.todoDataArray = []
            return false
        }
    }
    
    @discardableResult
    func saveTodoDataToJSON() -> Bool{
        do{
            let data : Data = try JSONEncoder().encode(self.todoDataArray)
            try data.write(to: TodoTableModel.todoDataPathURL, options: Data.WritingOptions.atomicWrite)
            return true
        }catch{
            print(error.localizedDescription)
            return false
        }
    }
    
    func addTodoData(to: TodoData){
        self.todoDataArray.append(to)
        if self.saveTodoDataToJSON(){
            if to.shouldNotify{ self.addNotification(to: to) }
        }
        
        
    }
    
    func removeTodoData(to: TodoData){
        self.todoDataArray = self.todoDataArray.filter({
            if($0.id == to.id){
                self.removeNotification(to: $0)
                return false
            }else{return true}
            
        })
        self.saveTodoDataToJSON()
    }
    
    
    func replaceTodoData(with: TodoData){
        self.todoDataArray = self.todoDataArray.map({
            todo in
            if todo.id == with.id{
                if todo.shouldNotify{
                    self.removeNotification(to: todo)
                }
                if with.shouldNotify{
                    self.addNotification(to: with)
                }
                return with
            }else {return todo}
        })
        self.saveTodoDataToJSON()
    }
    
    
    func addNotification(to: TodoData){
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "RxTodo"
        content.body = to.title
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let dateInfo = Calendar.current.dateComponents([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.hour, Calendar.Component.minute], from: to.date)
        
        let tirgger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        
        let request = UNNotificationRequest(identifier: to.id, content: content, trigger: tirgger)
        
        center.add(request){
            (error : Error?) in
            if let err = error {
                print(err.localizedDescription)
            }
        }
    }
    
    func removeNotification(to: TodoData){
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [to.id])
    }
}

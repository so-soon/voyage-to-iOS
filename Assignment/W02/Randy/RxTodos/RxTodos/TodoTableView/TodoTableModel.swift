//
//  TodoTableModel.swift
//  RxTodos
//
//  Created by Randy on 2021/02/27.
//

import Foundation

struct TodoData : Codable {
    var id : String
    var title : String
    var desc : String
    var date : Date
    var shouldNotify : Bool
}

class TodoTableModel {
    var todoDataArray = [TodoData]()
    
    func loadTodoDataFromJSON() -> Bool{
        
        return true
    }
    
    func saveTodoDataToJSON() -> Bool{
        return true
    }
    
    func removeTodoData(for: TodoData){
        
    }
    
    func replaceTodoData(with: TodoData){
        
    }
    
    func addNotification(for: TodoData){
        
    }
    
    func removeNotification(for: TodoData){
        
    }
}

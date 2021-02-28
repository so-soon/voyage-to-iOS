//
//  TodoItem.swift
//  MyTodos
//
//  Created by 김성환 on 2021/02/22.
//

import Foundation

struct TodoItem : Codable {
    var id:String
    var title_text:String
    var memo:String
    var isNotify:Bool
    var date:String
}

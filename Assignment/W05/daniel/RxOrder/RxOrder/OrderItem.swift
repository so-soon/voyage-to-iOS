//
//  OrderItem.swift
//  RxOrder
//
//  Created by 김성환 on 2021/04/04.
//

import Foundation

struct OrderItem : Decodable{
    var name:String
    var count:Int
    var price:Int
}
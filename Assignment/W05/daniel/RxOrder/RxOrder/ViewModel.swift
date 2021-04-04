//
//  ViewModel.swift
//  RxOrder
//
//  Created by 김성환 on 2021/04/04.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    let url = "https://firebasestorage.googleapis.com/v0/b/rxswiftin4hours.appspot.com/o/fried_menus.json?alt=media&token=42d5cb7e-8ec4-48f9-bf39-3049e796c936"
    
    lazy var items = BehaviorSubject<[OrderItem]>(value: [])
    lazy var itemCount = items.map{
        $0.map{$0.count}.reduce(0, +)
    }
    lazy var price = items.map{
        $0.map{$0.price * $0.count}.reduce(0, +)
    }
    
    init() {

    }
}

//
//  TodoDetailViewModel.swift
//  RxTodos
//
//  Created by Randy on 2021/02/27.
//

import Foundation
import RxCocoa
import RxSwift

class TodoDetailViewModel {
    //MARK:- Observable
    let cellDataFromTableView : PublishSubject<TodoData> = PublishSubject()
}

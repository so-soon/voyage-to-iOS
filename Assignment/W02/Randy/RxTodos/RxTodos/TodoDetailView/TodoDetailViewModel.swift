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
    //MARK:- Properties
    var bag = DisposeBag()
    
    //MARK:- Observable
    let dataUpdateOb : PublishSubject<TodoData> = PublishSubject()
    
    let titleTextOb : BehaviorRelay<String> = BehaviorRelay(value: "")
    let descTextOb : BehaviorRelay<String> = BehaviorRelay(value: "")
    let datePickerDateOb : BehaviorRelay<Date> = BehaviorRelay(value:Date())
    let shouldNotifyOb : BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    init(_ todoData: TodoData = TodoData.mockData) {
        let data = Observable.just(todoData).debug("data flow")
        
        data.map({$0.title})
            .debug("title")
            .bind(to: titleTextOb)
            .disposed(by: bag)
        
        data.map({$0.desc})
            .debug("desc")
            .bind(to: descTextOb)
            .disposed(by: bag)
        
        data.map({$0.date})
            .debug("date")
            .bind(to: datePickerDateOb)
            .disposed(by: bag)
        
        data.map({$0.shouldNotify})
            .debug("noti")
            .bind(to: shouldNotifyOb)
            .disposed(by: bag)
    }
}

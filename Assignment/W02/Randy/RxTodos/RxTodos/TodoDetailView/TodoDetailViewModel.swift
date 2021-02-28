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
    
    let titleTextOb : Observable<String>
    let descTextOb : Observable<String>
    let datePickerDateOb : Observable<Date>
    let shouldNotifyOb : Observable<Bool>
    
    
    init(_ todoData: TodoData = TodoData.mockData) {
        let data = Observable.just(todoData)
        
        titleTextOb = data.map({$0.title})
        
        descTextOb = data.map({$0.desc})
        
        datePickerDateOb = data.map({$0.date})
        
        shouldNotifyOb = data.map({$0.shouldNotify})
        
    }
}

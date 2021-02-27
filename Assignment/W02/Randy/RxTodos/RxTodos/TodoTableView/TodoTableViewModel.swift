//
//  TodoTableViewModel.swift
//  RxTodos
//
//  Created by Randy on 2021/02/27.
//

import Foundation
import RxCocoa
import RxSwift

class TodoTableViewModel {
    
    //MARK:- Properties
    private let dateFormmater: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        return formatter
    }()
    
    let model = TodoTableModel()
    var bag = DisposeBag()
    
    //MARK:- Observable
    let pressedCellIndexOb : PublishSubject<Int> = PublishSubject()
    let cellDataForTableViewOb : BehaviorRelay<[TodoData]> = BehaviorRelay(value: [])
    
    let cellDataForNextViewOb : PublishSubject<TodoData> = PublishSubject()

    init() {
        Observable.of(model.todoDataArray)
            .bind(to: cellDataForTableViewOb)
            .disposed(by: bag)
        
        pressedCellIndexOb
            .map(getCellData)
            .bind(to: cellDataForNextViewOb)
            .disposed(by: bag)
    }
    
    deinit {
        bag = DisposeBag()
    }
    
    func dateFormatting(from: Date) -> String{
        return self.dateFormmater.string(from: from)
    }
    
    func getCellData(_ index: Int)-> TodoData{
        return model.todoDataArray[index]
    }
    
}

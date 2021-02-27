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
    
    //MARK:- BehaviorSubject
    let pressedCellOb : PublishSubject<Int> = PublishSubject()
    let cellDataOb : BehaviorRelay<[TodoData]> = BehaviorRelay(value: [])
    

    init() {
        Observable.of(model.todoDataArray)
            .bind(to: cellDataOb)
            .disposed(by: bag)
        
    }
    
    deinit {
        
    }
    
    func dateFormatting(from: Date) -> String{
        return self.dateFormmater.string(from: from)
    }
    
    func getCellData(from index: Int)-> TodoData{
        return model.todoDataArray[index]
    }
    
}

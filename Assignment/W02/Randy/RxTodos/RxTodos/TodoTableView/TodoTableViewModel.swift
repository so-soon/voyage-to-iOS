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
    let preseedAddButtonOb : PublishSubject<Bool> = PublishSubject()
    let cellDataForTableViewOb : BehaviorRelay<[TodoData]> = BehaviorRelay(value: [])

    let showDetailViewOb : PublishSubject<TodoData> = PublishSubject()
    
    init() {
        cellDataForTableViewOb
            .accept(model.todoDataArray)
        
        pressedCellIndexOb
            .map({[weak self] in self!.model.todoDataArray[$0]})
            .bind(to: showDetailViewOb)
            .disposed(by: bag)
        
    }
    
    deinit {
    }
    
    func dateFormatting(from: Date) -> String{
        return self.dateFormmater.string(from: from)
    }
    
    func getCellData(_ index: Int)-> TodoData{
        return model.todoDataArray[index]
    }
    
}

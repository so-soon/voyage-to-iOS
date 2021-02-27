//
//  TodoTableViewController.swift
//  RxTodos
//
//  Created by Randy on 2021/02/27.
//

import UIKit
import RxSwift
import RxCocoa

class TodoTableViewController: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    //MARK:- Properties
    let viewModel : TodoTableViewModel = TodoTableViewModel()
    
    var bag = DisposeBag()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        bag = DisposeBag()
    }

    override func viewWillAppear(_ animated: Bool) {
        reactiveBindUI()
        todoTableView.reloadData()
    }
    
    private func reactiveBindUI(){
        todoTableView.rx.itemSelected
            .map({$0.row})
            .bind(to: viewModel.pressedCellOb)
            .disposed(by: bag)
        
        viewModel.cellDataOb
            .bind(to: todoTableView.rx.items(cellIdentifier: "TodoCell")){
                (index, model, cell) in
                cell.textLabel?.text = model.title
                cell.detailTextLabel?.text = model.desc
            }.disposed(by: bag)
        
    }
    
    

}

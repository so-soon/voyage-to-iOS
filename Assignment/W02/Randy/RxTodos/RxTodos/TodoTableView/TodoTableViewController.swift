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
        reactiveBindUI()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        bag = DisposeBag()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        reactiveBindUI()
        
        todoTableView.reloadSections(IndexSet(integer: 0), with: UITableView.RowAnimation.automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? TodoDetailViewController else {return}
        
        viewModel.cellDataForNextViewOb
            .bind(to: detailVC.viewModel.cellDataFromTableView)
            .disposed(by: bag)
    }
    
    private func reactiveBindUI(){
        todoTableView.rx.itemSelected
            .map({[weak self] in
                self?.todoTableView.deselectRow(at: $0, animated: true)
                return $0.row
            })
            .bind(to: viewModel.pressedCellOb)
            .disposed(by: bag)
        
        viewModel.cellDataForTableViewOb
            .bind(to: todoTableView.rx.items(cellIdentifier: "TodoCell")){
                (index, model, cell) in
                cell.textLabel?.text = model.title
                cell.detailTextLabel?.text = model.desc
                
            }.disposed(by: bag)
        
    }
    

}

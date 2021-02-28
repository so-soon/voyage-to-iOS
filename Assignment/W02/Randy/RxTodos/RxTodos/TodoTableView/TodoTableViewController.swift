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
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }

    override func viewWillAppear(_ animated: Bool) {
        todoTableView.reloadSections(IndexSet(integer: 0), with: UITableView.RowAnimation.automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        
        if identifier == TodoDetailViewController.identifier,
           let todoData = sender as? TodoData,
           let dest = segue.destination as? TodoDetailViewController{
            let detailViewModel = TodoDetailViewModel(todoData)
            dest.viewModel = detailViewModel
        }
    }
    
    private func reactiveBindUI(){
        
        // [INPUT]
        
        todoTableView.rx.itemSelected
            .debug("Rx - itemSelected")
            .map({$0.row})
            .bind(to: viewModel.pressedCellIndexOb)
            .disposed(by: bag)
        
        addButton.rx.tap
            .debug("Rx - addBUtton")
            .map({TodoData.mockData})
            .bind(to: viewModel.showDetailViewOb)
            .disposed(by: bag)
        
        // [NAVIGATION]
        
        viewModel.showDetailViewOb
            .debug("Rx - ShowDetail")
            .subscribe(onNext:{
                [weak self] data in
                self?.performSegue(withIdentifier: TodoDetailViewController.identifier, sender: data)
            }).disposed(by: bag)
        
        // [OUTPUT]
        
        viewModel.cellDataForTableViewOb
            .bind(to: todoTableView.rx.items(cellIdentifier: "TodoCell")){
                (index, model, cell) in
                cell.textLabel?.text = model.title
                cell.detailTextLabel?.text = model.desc
            }.disposed(by: bag)
        
    }
    
}

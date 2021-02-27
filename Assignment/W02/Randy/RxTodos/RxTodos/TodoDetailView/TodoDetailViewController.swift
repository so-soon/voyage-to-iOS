//
//  TodoDetailViewController.swift
//  RxTodos
//
//  Created by Randy on 2021/02/27.
//

import UIKit
import RxCocoa
import RxSwift

class TodoDetailViewController: UIViewController {
    //MARK:- IBOutlet
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    //MARK:- Properties
    let viewModel : TodoDetailViewModel = TodoDetailViewModel()
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactiveBindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        bag = DisposeBag()
    }
    
    private func reactiveBindUI(){
        viewModel.cellDataFromTableView
            .subscribe(onNext: {
                [weak self] data in
                self?.titleLabel.text = data.title
                self?.descTextView.text = data.desc
                self?.datePicker.date = data.date
                self?.alarmSwitch.isOn = data.shouldNotify
            })
            .disposed(by: bag)
    }

}

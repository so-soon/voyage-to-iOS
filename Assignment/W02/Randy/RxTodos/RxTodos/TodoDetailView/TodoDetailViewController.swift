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
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var viewButton: UIBarButtonItem!
    
    //MARK:- Properties
    static let identifier = "TodoDetailViewController"
    var viewModel : TodoDetailViewModel
    
    var bag = DisposeBag()
    
    
    //MARK:- Life Cycle
    
    init(){
        viewModel = TodoDetailViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = TodoDetailViewModel()
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactiveBindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    
    private func reactiveBindUI(){
        // [INPUT]
        
        
        // [NAVIGATION]
        
        // [OUTPUT]
        
        viewModel.titleTextOb
            .bind(to: titleLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.descTextOb
            .bind(to: descTextView.rx.text)
            .disposed(by: bag)
        
        viewModel.datePickerDateOb
            .bind(to: datePicker.rx.date)
            .disposed(by: bag)
        
        viewModel.shouldNotifyOb
            .bind(to: alarmSwitch.rx.isOn)
            .disposed(by: bag)
    }
    
    func setEnable(_ isEnable : Bool){
        self.titleLabel.isUserInteractionEnabled = isEnable
        self.descTextView.isEditable = isEnable
        self.datePicker.isUserInteractionEnabled = isEnable
        self.alarmSwitch.isEnabled = isEnable
    }
    
    func setTodoData(_ data : TodoData){
        self.titleLabel.text = data.title
        self.descTextView.text = data.desc
        self.datePicker.date = data.date
        self.alarmSwitch.isOn = data.shouldNotify
        
    }

}

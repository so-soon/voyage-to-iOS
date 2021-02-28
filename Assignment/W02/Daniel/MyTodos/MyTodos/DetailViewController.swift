//
//  DetailViewController.swift
//  MyTodos
//
//  Created by 김성환 on 2021/02/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var todoPassed: TodoItem?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let todo = todoPassed else {
            return
        }
        titleField.text = todo.title_text
        textView.text = todo.memo
        alarmSwitch.setOn(todo.isNotify, animated: true)
        datePicker.date = TodoModel.shared.dateFormatter.date(from: todo.date)!
        // Do any additional setup after loading the view.
    }


    @IBAction func saveBtnClicked(_ sender: Any) {
        
    }
}

//
//  DetailViewController.swift
//  MyTodos
//
//  Created by 김성환 on 2021/02/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var todoPassed: TodoItem?
    var editMode = true
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var editBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let todo = todoPassed else {
            todoPassed = TodoItem(id:UUID().uuidString,
                                  title_text:"",
                                  memo:"",
                                  isNotify:true,
                                  date:"")
            
            return
        }
        titleField.text = todo.title_text
        textView.text = todo.memo
        alarmSwitch.setOn(todo.isNotify, animated: true)
        datePicker.date = TodoModel.shared.dateFormatter.date(from: todo.date)!
        if editMode == true {
            setUserInteraction(true)
        } else {
            setUserInteraction(false)
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveRewind" {
            guard var todo = todoPassed else {
                return
            }
            todo.title_text  = self.titleField.text!
            todo.memo = self.textView.text
            todo.isNotify = self.alarmSwitch.isOn
            todo.date = TodoModel.shared.dateFormatter.string(from:self.datePicker.date)
            self.todoPassed = todo
        }
    }
    
    func setUserInteraction(_ flag: Bool) {
        self.titleField.isUserInteractionEnabled = flag
        self.textView.isUserInteractionEnabled = flag
        self.alarmSwitch.isEnabled = flag
        self.datePicker.isEnabled = flag
        self.editBtn.isEnabled = !flag
    }
}

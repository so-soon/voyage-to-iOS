//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Alan on 2021/02/21.
//

import UIKit

class TaskViewController: UIViewController {
    @IBOutlet weak var TaskViewNavigationBar: UINavigationBar!
    @IBOutlet weak var TaskViewNavigationBarLeftButton: UIBarButtonItem!
    @IBOutlet weak var TaskViewNavigationBarRightButton: UIBarButtonItem!
    
    var viewMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateView()
    }
    
    func updateView() -> Void {
        if(viewMode == true) { //edit
            self.TaskViewNavigationBar.topItem?.title = "항목 열람"
            self.TaskViewNavigationBarLeftButton.title = "Back"
            self.TaskViewNavigationBarRightButton.title = "Edit"
        } else { //add
            self.TaskViewNavigationBar.topItem?.title = "항목 수정"
            self.TaskViewNavigationBarLeftButton.title = "Cancel"
            self.TaskViewNavigationBarRightButton.title = "Done"
        }
    }
    
    func setViewMode(mode: Bool) -> Void {
        viewMode = mode
    }
    
    func changeMode(_ sender: Any) {
        viewMode = !viewMode
        setViewMode(mode: viewMode)
        viewWillAppear(true)
    }
    
    @IBAction func exitMode(_ sender: Any) {
        if(viewMode == true) {
            //cancel all elements
            changeMode(self)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func updateTask(_ sender: Any) {
        if(viewMode == true) { //Edit
            changeMode(self)
        } else { //Done
//            self.dismiss(animated: true, completion: nil)
            //add cell
        }
    }
    
}

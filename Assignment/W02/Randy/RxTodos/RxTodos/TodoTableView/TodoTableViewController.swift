//
//  TodoTableViewController.swift
//  RxTodos
//
//  Created by Randy on 2021/02/27.
//

import UIKit

class TodoTableViewController: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func reactiveBindUI(){
        
    }

}

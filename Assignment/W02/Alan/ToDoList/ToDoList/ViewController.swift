//
//  ViewController.swift
//  ToDoList
//
//  Created by Alan on 2021/02/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Test Cell"
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let taskView = segue.destination as! TaskViewController
        
        if(segue.identifier == "addTask") {
            taskView.viewMode = false
        } else if(segue.identifier == "editTask") {
            taskView.viewMode = true
        }
    }
}


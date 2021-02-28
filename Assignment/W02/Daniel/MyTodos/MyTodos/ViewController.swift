//
//  ViewController.swift
//  MyTodos
//
//  Created by 김성환 on 2021/02/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TodoModel.shared.loadFromJSON()
        tableview.dataSource = self
        tableview.delegate = self
    }


}

extension ViewController :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoModel.shared.todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        
        cell.title.text = TodoModel.shared.todoItems[indexPath.row].title_text
        cell.date.text = TodoModel.shared.todoItems[indexPath.row].date
        return cell
    }
}

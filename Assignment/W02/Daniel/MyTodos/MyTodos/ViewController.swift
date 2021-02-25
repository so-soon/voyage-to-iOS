//
//  ViewController.swift
//  MyTodos
//
//  Created by 김성환 on 2021/02/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    private var todoList = [TodoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        todoList.append(TodoItem(title_text:"Memo1", memo:"TestMemo", isNotify: false, date: Date()))
        todoList.append(TodoItem(title_text:"Memo2", memo:"TestMemo2", isNotify: false, date: Date()))
        todoList.append(TodoItem(title_text:"Memo3", memo:"TestMemo3", isNotify: false, date: Date()))
        todoList.append(TodoItem(title_text:"Memo4", memo:"TestMemo4", isNotify: false, date: Date()))
        todoList.append(TodoItem(title_text:"Memo5", memo:"TestMemo5", isNotify: false, date: Date()))
    }


}

extension ViewController :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        cell.title.text = todoList[indexPath.row].title_text
        cell.date.text = dateFormatter.string(from:todoList[indexPath.row].date)
        return cell
    }
}

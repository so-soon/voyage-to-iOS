//
//  ViewController.swift
//  MyTodos
//
//  Created by 김성환 on 2021/02/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var todoReceived: TodoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TodoModel.shared.loadFromJSON()
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewItemSegue" {
            let detailViewController = segue.destination as! DetailViewController
            
            if let senderCell = sender as? TableCell {
                detailViewController.todoPassed = senderCell.item
            }
            detailViewController.editMode = false
        }
        if segue.identifier == "ViewItemAddSegue" {
            let detailViewController = segue.destination as! DetailViewController
            
            if let senderVC = sender as? ViewController {
                detailViewController.todoPassed = senderVC.todoReceived
            }
            
            detailViewController.editMode = true
        }
    }
    
    @IBAction func rewindHere(sender: UIStoryboardSegue) {
        guard let vc = sender.source as? DetailViewController else {
            return
        }
        
        if sender.identifier == "SaveRewind" {
            guard let todo = vc.todoPassed else {
                return
            }
            do {
                try TodoModel.shared.addTodo(todo)
            } catch {
                print("Add Todo Failed")
            }
            tableview.reloadData()
        }
        
        else if sender.identifier == "EditRewind" {
            DispatchQueue.main.async {
                self.todoReceived = vc.todoPassed
                self.performSegue(withIdentifier:"ViewItemAddSegue", sender:self)
            }
        }
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
        cell.item = TodoModel.shared.todoItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier:"ViewItemSegue", sender:cell)
    }
}

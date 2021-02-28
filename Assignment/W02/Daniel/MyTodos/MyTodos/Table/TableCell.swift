//
//  TableCell.swift
//  MyTodos
//
//  Created by 김성환 on 2021/02/22.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    var item: TodoItem!
}


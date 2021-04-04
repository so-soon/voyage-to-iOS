//
//  OrderTableCell.swift
//  RxOrder
//
//  Created by 김성환 on 2021/04/04.
//

import UIKit

class OrderTableCell: UITableViewCell {
    static let identifier = "OrderTableCell"

    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
}

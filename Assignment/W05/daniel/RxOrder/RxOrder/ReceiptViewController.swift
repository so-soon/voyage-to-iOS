//
//  ReceiptViewController.swift
//  RxOrder
//
//  Created by 김성환 on 2021/04/04.
//

import UIKit

class ReceiptViewController: UIViewController {
    @IBOutlet weak var orderItemsText: UITextView!
    @IBOutlet weak var itemsPriceLabel: UILabel!
    @IBOutlet weak var vatPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

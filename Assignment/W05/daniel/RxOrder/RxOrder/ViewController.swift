//
//  ViewController.swift
//  RxOrder
//
//  Created by 김성환 on 2021/04/04.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var orderBtn: UIButton!
    
    let viewModel = ViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
    }
    
    func bindUI() {
        viewModel.itemCount
            .map{String($0)}
            .bind(to: self.itemCountLabel.rx.text)
            .disposed(by:bag)
        viewModel.price
            .map{String($0)}
            .bind(to: self.totalPriceLabel.rx.text)
            .disposed(by:bag)
        
        orderTableView.dataSource = nil
        viewModel.items
            .bind(to: orderTableView.rx.items(cellIdentifier: OrderTableCell.identifier, cellType: OrderTableCell.self)) { index, item, cell in
                cell.nameLabel.text = item.name
                cell.priceLabel.text = String(item.price)
                cell.countLabel.text = String(item.count)
                cell.plusBtn.
            }
            .disposed(by:bag)
        
        let itemArray : [OrderItem] = [
            OrderItem(name:"Test1", count: 0, price: 100),
            OrderItem(name:"Test2", count: 0, price: 200),
            OrderItem(name:"Test3", count: 0, price: 300),
        ]
        viewModel.items.onNext(itemArray)
    }

}

//
//  ViewController.swift
//  SimpleLoginView
//
//  Created by 김성환 on 2021/03/07.
//

import UIKit

class ViewController: UIViewController {
    
    var count:Int = 0
    @IBOutlet weak var timerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.updTimer()
    }
    
    func updTimer() {
        DispatchQueue.main.async {
            self.timerLabel.text = String(self.count)
        }
        count += 1
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
            self.updTimer()
        }
    }
}


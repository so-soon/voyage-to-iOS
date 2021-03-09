//
//  ViewController.swift
//  Login
//
//  Created by Alan on 2021/03/09.
//

import UIKit

class ViewController: UIViewController {

    var count: Int = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup counter
        self.count = 0
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            DispatchQueue.global().async {
                self.count+=1
                DispatchQueue.main.async {
                    self.labelCount.text=String(self.count)
                }
            }
        })
    }

    @IBOutlet weak var labelCount: UILabel!
    
}


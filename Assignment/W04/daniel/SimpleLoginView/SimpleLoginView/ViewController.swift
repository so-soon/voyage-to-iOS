//
//  ViewController.swift
//  SimpleLoginView
//
//  Created by 김성환 on 2021/03/07.
//

import UIKit

class ViewController: UIViewController {
    
    var count:Int = 0
    var idPass:Bool = false
    var pwPass:Bool = false
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var idPassImage: UIImageView!
    @IBOutlet weak var pwPassImage: UIImageView!
    
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
    @IBAction func idChangeEvent(_ sender: Any) {
        guard let text = self.idField.text else {
            return
        }
        if text.contains("@") &&
            self.idField.text!.contains(".") {
            idPassImage.image = UIImage(systemName: "checkmark.circle.fill")
            self.idPass = true
        }
        else {
            idPassImage.image = UIImage(systemName: "checkmark.circle")
            self.idPass = false
        }
    }
    @IBAction func pwChangeEvent(_ sender: Any) {
        guard let text = self.pwField.text else {
            return
        }
        
        if text.count >= 5 {
            pwPassImage.image = UIImage(systemName: "checkmark.circle.fill")
            self.pwPass = true
        }
        else {
            pwPassImage.image = UIImage(systemName: "checkmark.circle")
            self.pwPass = false
        }
    }
}


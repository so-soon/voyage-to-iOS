//
//  ViewController.swift
//  Login
//
//  Created by Alan on 2021/03/09.
//

import UIKit

class ViewController: UIViewController {

    var count: Int = 0
    var isIdValidated: Bool = false
    var isPasswordValidated: Bool = false
    let minimumPasswordLength = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.count = 0

        loginButton.isEnabled = false
        activityIndicator.hidesWhenStopped = true

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            DispatchQueue.global().async {
                self.count += 1
                DispatchQueue.main.async {
                    self.labelCount.text = String(self.count)
                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func validateLoginButton() {
        if(self.isIdValidated && self.isPasswordValidated) {
            loginButton.isEnabled = true
            return
        }
        loginButton.isEnabled = false
    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var tfId: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var downloadImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBAction func tfId(_ sender: Any) {
        if let characters: String = tfId.text {
            var isValidate: Bool = true;
            do {
                if characters.count == 0 {
                    self.tfId.layer.borderColor = UIColor.lightGray.cgColor
                    self.tfId.layer.borderWidth = 0.0
                    return
                }
                if !characters.contains("@") { isValidate = false }
                if !characters.contains(".") { isValidate = false }
            }

            self.isIdValidated = isValidate
            if(self.isIdValidated) {
                DispatchQueue.main.async {
                    self.tfId.layer.borderColor = UIColor.green.cgColor
                    self.tfId.layer.borderWidth = 2.0
                }
            } else {
                DispatchQueue.main.async {
                    self.tfId.layer.borderColor = UIColor.red.cgColor
                    self.tfId.layer.borderWidth = 2.0
                }
            }
            
            self.validateLoginButton()
            self.viewWillAppear(true)
        } else { return }
    }
    
    @IBAction func tfPassword(_ sender: Any) {
        if let characters: String = tfPassword.text {
            var isValidate: Bool = true;
            do {
                if characters.count == 0 {
                    self.tfPassword.layer.borderColor = UIColor.lightGray.cgColor
                    self.tfPassword.layer.borderWidth = 0.0
                    return
                }
                if characters.count < (minimumPasswordLength + 1) {
                    isValidate = false
                }
            }

            self.isPasswordValidated = isValidate
            if(self.isPasswordValidated == true) {
                DispatchQueue.main.async {
                    self.tfPassword.layer.borderColor = UIColor.green.cgColor
                    self.tfPassword.layer.borderWidth = 2.0
                }
            } else {
                DispatchQueue.main.async {
                    self.tfPassword.layer.borderColor = UIColor.red.cgColor
                    self.tfPassword.layer.borderWidth = 2.0
                }
            }
            
            self.validateLoginButton()
            self.viewWillAppear(true)
        } else { return }
    }
    
    @IBAction func login(_ sender: Any) {
        guard
            let url = URL(string: "https://picsum.photos/1280/720/?random")
        else { return }
       
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.downloadImage.image = image
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
}


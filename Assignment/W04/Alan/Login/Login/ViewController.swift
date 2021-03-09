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
        
        activityIndicator.hidesWhenStopped = true
        
        //setup counter
        self.count = 0
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
            DispatchQueue.global().async {
                self.count += 1
                DispatchQueue.main.async {
                    self.labelCount.text = String(self.count)
                }
            }
        })
    }

    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var downloadImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

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


//
//  ViewController.swift
//  RxLoginView
//
//  Created by Randy on 2021/03/04.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var TFemail: UITextField!
    @IBOutlet weak var TFpw: UITextField!
    

    @IBOutlet weak var imgEmailValid: UIButton!
    @IBOutlet weak var imgPWValid: UIButton!
    
    @IBOutlet weak var lbCounter: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var imgPic: UIImageView!
    
    var counter = 0
    
    let viewModel = ViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.bindUI()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.counter += 1
            self.lbCounter.text = "\(self.counter)"
        }
    }

    func bindUI(){
        
        // [INPUT]
        self.TFemail.rx.text.orEmpty
            .bind(to: viewModel.emailText)
            .disposed(by: bag)
        
        self.TFpw.rx.text.orEmpty
            .bind(to: viewModel.pwText)
            .disposed(by: bag)
        
        self.btnLogin.rx.tap
            .bind(to: viewModel.loginPressed)
            .disposed(by: bag)
        
        // [OUTPUT]
        
        viewModel.isEmailValid
            .distinctUntilChanged()
            .map{!$0}
            .bind(to: imgEmailValid.rx.isHidden)
            .disposed(by: bag)
        
        viewModel.isPwValid
            .distinctUntilChanged()
            .map{!$0}
            .bind(to: imgPWValid.rx.isHidden)
            .disposed(by: bag)
        
        
        Observable.combineLatest(viewModel.isEmailValid, viewModel.isPwValid)
            .map({$0 && $1})
            .bind(to: btnLogin.rx.isEnabled)
            .disposed(by: bag)
        
        viewModel.downloadImg
            .bind(to: imgPic.rx.image)
            .disposed(by: bag)
    }
}


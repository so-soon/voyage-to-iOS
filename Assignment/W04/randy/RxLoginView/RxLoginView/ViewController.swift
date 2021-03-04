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
            .bind(to: viewModel.emailTextObservable)
            .disposed(by: bag)
        
        self.TFpw.rx.text.orEmpty
            .bind(to: viewModel.pwTextObservable)
            .disposed(by: bag)
        
        self.btnLogin.rx.tap
            .bind(to: viewModel.downloadImgObservable)
            .disposed(by: bag)
        
        // [OUTPUT]
        
        viewModel.isEmailValidObservable
            .distinctUntilChanged()
            .subscribe(onNext:{
                [weak self] isEmailValid in
                
                self?.imgEmailValid.isHidden = !isEmailValid
            })
            .disposed(by: bag)
        
        viewModel.isPwValidObservable
            .distinctUntilChanged()
            .subscribe(onNext:{
                [weak self] isPWValid in
                
                self?.imgPWValid.isHidden = !isPWValid
            })
            .disposed(by: bag)
        
        
        Observable.combineLatest(viewModel.isEmailValidObservable, viewModel.isPwValidObservable)
            .map({$0 && $1})
            .subscribe(onNext: {
                [weak self] isValid in
                self?.btnLogin.isEnabled = isValid
            })
            .disposed(by: bag)
        
        viewModel
            .downloadedImgObservable
            .bind(to: imgPic.rx.image)
            .disposed(by: bag)
    }
}


//
//  ViewModel.swift
//  RxLoginView
//
//  Created by Randy on 2021/03/04.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    let url = "https://picsum.photos/1280/720/?random"
    
    let bag = DisposeBag()
    
    // [INPUT]
    let emailText : PublishSubject<String> = PublishSubject()
    let pwText : PublishSubject<String> = PublishSubject()
    let loginPressed : PublishSubject<Void> = PublishSubject()
    
    // [OUTPUT]
    let isEmailValid : BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let isPwValid : BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let downloadImg : PublishSubject<UIImage> = PublishSubject()
    
    
    init() {
        emailText
            .map({
                text in
                return text.contains("@") && text.contains(".")
            })
            .bind(to: isEmailValid)
            .disposed(by: bag)
        
        pwText
            .map({
                text in
                return text.count > 5
            })
            .bind(to: isPwValid)
            .disposed(by: bag)
        
        loginPressed
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .compactMap({[weak self] in return URL(string: self?.url ?? "")})
            .map({ try Data(contentsOf: $0) })
            .compactMap({ UIImage(data: $0) })
            .bind(to: downloadImg)
            .disposed(by: bag)
        
        
    }
    
}

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
    
    let emailTextObservable : PublishSubject<String> = PublishSubject()
    let pwTextObservable : PublishSubject<String> = PublishSubject()
    let downloadImgObservable : PublishSubject<Void> = PublishSubject()
    
    
    
    let isEmailValidObservable : BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let isPwValidObservable : BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let downloadedImgObservable : PublishSubject<UIImage> = PublishSubject()
    
    
    init() {
        emailTextObservable
            .map({
                text in
                
                return text.contains("@") && text.contains(".")
            })
            .bind(to: isEmailValidObservable)
            .disposed(by: bag)
        
        pwTextObservable
            .map({
                text in
                
                return text.count > 5
            })
            .bind(to: isPwValidObservable)
            .disposed(by: bag)
        
        downloadImgObservable
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .compactMap({[weak self] in return URL(string: self?.url ?? "")})
            .map({ try Data(contentsOf: $0) })
            .compactMap({ UIImage(data: $0) })
            .bind(to: downloadedImgObservable)
            .disposed(by: bag)
        
        
    }
    
}

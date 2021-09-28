
//  ReactiveExtensiones.swift.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/17/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation


import UIKit
import RxSwift
import RxCocoa
import ProgressHUD


extension Reactive where Base: UIViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                //vc.startAnimating()
                 ProgressHUD.show()
                ProgressHUD.animationType = .circleStrokeSpin
                ProgressHUD.colorAnimation = .systemBlue
            } else {
               // vc.stopAnimating()
                ProgressHUD.dismiss()
            }
        })
    }
    
}



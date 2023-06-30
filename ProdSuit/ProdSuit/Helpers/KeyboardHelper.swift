//
//  KeyboardHelper.swift
//  ProdSuit
//
//  Created by MacBook on 21/02/23.
//

import Foundation
import UIKit
import Combine

var KeyboardHeightPublisher:AnyPublisher<CGFloat,Never>{
    let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification).map{ ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0 }
    
    let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
    
    return Publishers.MergeMany(willShow,willHide)
        .eraseToAnyPublisher()
}

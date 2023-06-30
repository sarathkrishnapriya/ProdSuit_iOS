//
//  ChangeMPINValidationViewModels.swift
//  ProdSuit
//
//  Created by MacBook on 21/03/23.
//

import Foundation
import UIKit
import Combine


protocol ChangeMPINValidationVM{
    
    var brockenRules:[BrockenRule] { get set }
    var isValid : Bool { mutating get }
    
}


struct ChangeMPINValidateVM:ChangeMPINValidationVM{
    
    var currentMPIN = ""
    var newMPIN = ""
    var confirmMPIN = ""
    
    var brockenRules: [BrockenRule]
    
    var isValid: Bool{
        mutating get{
            self.brockenRules = [BrockenRule]()
            self.changeMPINValidate()
            return brockenRules.count > 0 ? true : false
        }
    }
    
    
}

extension ChangeMPINValidateVM{
    
    mutating func changeMPINValidate(){
        if currentMPIN.count < mpinCount{
            self.brockenRules.append(BrockenRule.init(propertyName: "Current ", message: changeMPINErrorMessage))
        }
        if newMPIN.count < mpinCount{
            self.brockenRules.append(BrockenRule.init(propertyName: "New ", message: changeMPINErrorMessage))
        }
        if confirmMPIN.count < mpinCount{
            self.brockenRules.append(BrockenRule.init(propertyName: "Confirm ", message: changeMPINErrorMessage))
        }
    }
    
}


class ChangeMpinValidateViewModel{
    
    @Published var currentMpin = ""
    @Published var newMpin = ""
    @Published var confirmMpin = ""
    var isMatched = Bool()
    lazy var matchPasswordCancellable = Set<AnyCancellable>()
    
    func checkMpinMatched(){
        passwordMatchesPublisher.sink { isMatched in
            print("Match: \(isMatched)")
            self.isMatched = isMatched
        }.store(in: &matchPasswordCancellable)
    }
}

extension ChangeMpinValidateViewModel{
    
    var passwordMatchesPublisher:AnyPublisher<Bool,Never>{
        Publishers.CombineLatest($newMpin,$confirmMpin).map{ (new, latest) in
            return new == latest
        }
        
        
            
        .eraseToAnyPublisher()
    }
    
    
}

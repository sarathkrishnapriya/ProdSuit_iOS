//
//  WalkInCustomerValidation.swift
//  ProdSuit
//
//  Created by MacBook on 14/06/23.
//

import Foundation

struct WCValidationViewModel:CommonValidateVM {
    var brockenRules: [BrockenRule]
    
    var customername : String = ""
    var selectedAssinedToID:NSNumber = -1
    
    var assignedDateString = ""
    
    
    var isValid: Bool{
        mutating get{
            self.brockenRules = [BrockenRule]()
            self.validateFields()
            return self.brockenRules.count > 0 ? false : true
        }
    }
    
    
}


extension WCValidationViewModel{
    mutating func validateFields() {
        if self.customername.count == 0{
            self.brockenRules.append(BrockenRule.init(propertyName: "Customer Name", message: "Customer name cannot be blank"))
        }else if selectedAssinedToID == -1{
            self.brockenRules.append(BrockenRule.init(propertyName: "Assigned To", message: "Assigned To cannot be blank"))
        }else if assignedDateString.count == 0{
            self.brockenRules.append(BrockenRule.init(propertyName: "Assigned Date", message: "Assigned Date cannot be blank"))
        }
    }
}

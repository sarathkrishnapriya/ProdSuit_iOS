//
//  LeadManageMentValidationModel.swift
//  ProdSuit
//
//  Created by MacBook on 24/05/23.
//

import Foundation

protocol CommonValidateVM{
    
    var brockenRules:[BrockenRule] { get set }
    var isValid : Bool { mutating get }
}

struct LMCUpLoadDocuMentValidationModel:CommonValidateVM{
    
    
    var subject:String = ""
    var description:String = ""
    var attachment:String = ""

    var brockenRules: [BrockenRule]
    
    var isValid: Bool{
        mutating get{
            
            
            self.brockenRules = [BrockenRule]()
            self.validate()
            return self.brockenRules.count > 0 ? true : false
        }
    }
    
}

extension LMCUpLoadDocuMentValidationModel{
   mutating private func validate(){
       if subject.isEmpty{
           self.brockenRules.append(BrockenRule(propertyName: "Subject TF", message: "Subject cannot be blank"))
       }else if description.isEmpty{
           self.brockenRules.append(BrockenRule(propertyName: "Description TV", message: "Description cannot be blank"))
       }else if attachment.isEmpty{
           self.brockenRules.append(BrockenRule(propertyName: "Attachment TV", message: "Select Document"))
       }
    }
}

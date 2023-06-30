//
//  LoginValidationViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 17/02/23.
//

import Foundation
import UIKit

struct BrockenRule{
    var propertyName : String
    var message : String
}

protocol LoginValidateVM{
    
    var brockenRules:[BrockenRule] { get set }
    var isValid : Bool { mutating get }
}


struct LoginValidationModel:LoginValidateVM{
    
    
    var mobileNumber = ""
    var brockenRules: [BrockenRule]
    
    var isValid: Bool{
        mutating get{
            
            
            self.brockenRules = [BrockenRule]()
            self.validate()
            return self.brockenRules.count > 0 ? true : false
        }
    }
    
}

extension LoginValidationModel{
    
    mutating private func validate(){
        if mobileNumber.count < 10 {
            self.brockenRules.append(BrockenRule(propertyName: "mobileTF", message: mobileNumberErrorMessage))
            
        }
    }
    
    
}

struct LeadGenerationValidationModel:LoginValidateVM{
    
    var leadDateString:String = ""
    var customerHonerString : String = ""
    var customerNameString: String = ""
    var categoryString : String = ""
    var priorityString : String = ""
    var enquiry : String = ""
    var actionType : String = ""
    var subActionType : String = ""
    var project_dateString : String = ""
    
    var brockenRules: [BrockenRule]
    
    var isValid: Bool{
        mutating get{
            self.brockenRules = [BrockenRule]()
            self.validate()
            return self.brockenRules.count > 0 ? true : false
        }
    }
    
    
}

extension LeadGenerationValidationModel{
    mutating private func validate(){
        if leadDateString == ""{
            self.brockenRules.append(BrockenRule(propertyName: "Date", message: leadDetailsDateMessage))

        }else if customerHonerString == ""{
            
            self.brockenRules.append(BrockenRule(propertyName: "honor", message: "Select Title Name"))
            
        }else if customerNameString == ""{
            
            self.brockenRules.append(BrockenRule(propertyName: "customer name", message: "Customer name cannot be blank"))
            
        }else if categoryString == ""{
            
            self.brockenRules.append(BrockenRule(propertyName: "Category", message: "Select Category"))
            
        }else if priorityString == ""{
            
            self.brockenRules.append(BrockenRule(propertyName: "Priority", message: "Select Priority"))
            
        }else if enquiry == ""{
            
            self.brockenRules.append(BrockenRule(propertyName: "enquiry", message: "Add enquiry note"))
            
        }else if actionType == ""{
            
            self.brockenRules.append(BrockenRule(propertyName: "action", message: "Select Action"))
            
        }else if subActionType == "" && self.actionType == "1"{
            
            self.brockenRules.append(BrockenRule(propertyName: "action_type", message: "Select Action Type"))
            
        }else if project_dateString == "" && self.actionType == "1"{
            
            self.brockenRules.append(BrockenRule(propertyName: "project_date", message: "Select follow up date"))
            
        }
    }
}



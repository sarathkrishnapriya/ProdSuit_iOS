//
//  FollowUpViewModelValidation.swift
//  ProdSuit
//
//  Created by MacBook on 02/06/23.
//

import Foundation
import UIKit


struct FollowUpValidationViewModel:CommonValidateVM{
    var brockenRules: [BrockenRule]
    
    var actionTypeValue:NSNumber=0
    var selectedSegment : Int=0
    var followUpParamValidation:FollowUpParamValidation?
    
    var isValid: Bool{
        mutating get{
            self.brockenRules = [BrockenRule]()
            selectedSegment == 0 ? validateFollowUpsection() : validateActionSection()
            return self.brockenRules.count > 0 ? true : false
        }
    }
    
    
}

extension FollowUpValidationViewModel{
    mutating func validateFollowUpsection(){
        
        switch actionTypeValue{
        case 1:
            
            if followUpParamValidation?.followUPby == ""{
                self.brockenRules.append(BrockenRule(propertyName: "Follow Up By", message: "Select follow up by"))
            }else if followUpParamValidation?.statusId == "0"{
                self.brockenRules.append(BrockenRule(propertyName: "Status", message: "Select status"))
            }else if followUpParamValidation?.date == ""{
                self.brockenRules.append(BrockenRule(propertyName: "date", message: "Select date"))
            }else if followUpParamValidation?.callStatusId == "0"{
                self.brockenRules.append(BrockenRule(propertyName: "Call status", message: "Select call status"))
            }
            
        case 2:
            if followUpParamValidation?.followUPby == ""{
                self.brockenRules.append(BrockenRule(propertyName: "Follow Up By", message: "Select follow up by"))
            }else if followUpParamValidation?.statusId == "0"{
                self.brockenRules.append(BrockenRule(propertyName: "Status", message: "Select status"))
            }else if followUpParamValidation?.date == ""{
                self.brockenRules.append(BrockenRule(propertyName: "date", message: "Select date"))
            }else if followUpParamValidation?.coordinates.lon == 0{
                self.brockenRules.append(BrockenRule(propertyName: "Location", message: "Select current location"))
            }
        
        default:
            
            if actionTypeValue == 0{
                self.brockenRules.append(BrockenRule(propertyName: "Action Type", message: "Select action type"))
            }else if followUpParamValidation?.followUPby == ""{
                self.brockenRules.append(BrockenRule(propertyName: "Follow Up By", message: "Select follow up by"))
            }else if followUpParamValidation?.statusId == "0"{
                self.brockenRules.append(BrockenRule(propertyName: "Status", message: "Select status"))
            }else if followUpParamValidation?.date == ""{
                self.brockenRules.append(BrockenRule(propertyName: "date", message: "Select date"))
            }
        }
        
    }
    
    func validateActionSection(){
        
    }
}

struct FollowUpParamValidation{
    var siteActionType:String
    var followUPby:String
    var statusId:String
    var date:String
    var customerRemark:String
    var employeeRemark:String
    var coordinates:(lat: Double, lon: Double)=(lat: 0, lon: 0)
    var uploadImageOne:String=""
    var uploadImageTwo:String=""
    var callStatusId:String=""
    var nextActionID:String=""
    var nextActionTypeID:String = ""
    var nextActionFollowUpdate:String=""
    var nextActionPriorityID:String = ""
    var departMentID:String=""
    var employee_ID:String=""
    var id_LeadGenerateProduct:String=""
    var id_LeadGenerate:String=""
}

//
//  CollectionValidation.swift
//  ProdSuit
//
//  Created by MacBook on 23/06/23.
//

import Foundation
import UIKit

struct PaymentMethodValidationModel:CommonValidateVM{
    var brockenRules: [BrockenRule]
    
    var balanceString : String = "0.00"
    var amountString:String = "0.00"
    var id_PaymentMethod : NSNumber = 0
    
  
    
    var isValid: Bool{
        mutating get{
            self.brockenRules = [BrockenRule]()
            self.validateFields()
            return self.brockenRules.count > 0 ? false : true
        }
    }
    
    
}



extension PaymentMethodValidationModel{
    
   
    
   mutating func validateFields(){
       if id_PaymentMethod == 0{
           self.brockenRules.append(BrockenRule(propertyName: "Payment Method", message: "Select payment method"))
       }else if self.amountString == ""{
           self.brockenRules.append(BrockenRule(propertyName: "Amount", message: "Amount cannot be blank"))
       }else if self.amountString == "0.00"{
           self.brockenRules.append(BrockenRule(propertyName: "Amount", message: "Amount cannot be zero"))
       }else if Int(balanceString) == 0{
           self.brockenRules.append(BrockenRule(propertyName: "balance", message: "Insufficient balance"))
       }else if (Double.init(amountString) ?? 0.00) > (Double.init(balanceString) ?? 0.00){
           self.brockenRules.append(BrockenRule(propertyName: "balance", message: "Insufficient balance"))
       }
    }
    
   
}

struct PaymentApplyValidationModel:CommonValidateVM {
    var brockenRules: [BrockenRule]
    var netAmoutString:String = "0.00"
    var paymentArryCount = 0
    var payableAmount = "0.00"
    
    
    var isValid: Bool{
        mutating get{
            self.brockenRules = []
            self.validatePaymentDetails()
            return self.brockenRules.count > 0 ? false : true
        }
    }
    
    
}

extension PaymentApplyValidationModel{
    mutating func validatePaymentDetails(){
        if paymentArryCount == 0{
            self.brockenRules.append(BrockenRule.init(propertyName: "Payment List", message: "Add payment"))
        }else if Double(self.netAmoutString) == 0{
            self.brockenRules.append(BrockenRule(propertyName: "Net amount", message: "Net amount cannot be zero"))
        }else if Double(payableAmount) != 0 {
            self.brockenRules.append(BrockenRule(propertyName: "Balance", message: "Balance should be zero"))
        }
    }
}


func convertToJsonArray(list:[Any]) -> String {
    do {
                let jsonData: Data = try JSONSerialization.data(withJSONObject: list, options: [])
                if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                    return jsonString as String
                }
                
            } catch let error as NSError {
                print("Array convertIntoJSON - \(error.description)")
            }
            return ""
}

extension Collection where Iterator.Element == [String:AnyObject] {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? [[String:AnyObject]],
            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
            let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
}


struct PaymentSubmitAPIDetailsVM:CommonValidateVM {
    var brockenRules: [BrockenRule]
    
    
    
    var paymentListCount = 0
    var fineAmountString : String = "0.00"
    var installMentString : String = "0.00"
    var closing:Bool = false
    
    var isValid: Bool{
        mutating get{
            self.brockenRules = []
            validateEMIDetails()
            return self.brockenRules.count > 0 ? false : true
        }
    }
    
}

extension PaymentSubmitAPIDetailsVM{
    mutating func validateEMIDetails(){
        
        if paymentListCount == 0{
            self.brockenRules.append(BrockenRule(propertyName: "Payment", message: "Add payment method"))
        }
        else if closing == true{
            if fineAmountString == ""{
                self.brockenRules.append(BrockenRule(propertyName: "fine amount", message: "Fine cannot be blank"))
            }
        }else{
            if installMentString == ""{
                self.brockenRules.append(BrockenRule(propertyName: "Installment", message: "Installment amount cannot be blank"))
            }
            else if fineAmountString == ""{
                self.brockenRules.append(BrockenRule(propertyName: "fine amount", message: "Fine cannot be blank"))
            }
        }
    }
}

//
//  EMICollectionHelper.swift
//  ProdSuit
//
//  Created by MacBook on 21/06/23.
//

import Foundation
import UIKit


struct CollectionCalculator{
    
    
    var openigBalance : String   // *
    
    var installment_amount:String // *
    var fine_amount : String // *
    
    var closing = false // *
    
    var netAmountDouble:Double?{
        return closing == false ? Double(installment_amount)! + Double(fine_amount)! : Double(fine_amount)! + Double(openigBalance)!
    }
  
    
   
    
    
    func calculateBalance() -> String{
        return closing == false ? (Double(openigBalance)! - Double(installment_amount)!).format(f: ".2") : "0.00"
    }
    
    func calculateNetAmount() -> String{
         return  netAmountDouble!.format(f: ".2")
    }
    
    func toWords<N>(number: N) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut

        switch number {
        case is Int, is UInt, is Float, is Double:
            return formatter.string(from: number as! NSNumber)
        case is String:
            if let number = Double(number as! String) {
                return formatter.string(from: NSNumber(floatLiteral: number))?.capitalized
            }
        default:
            break
        }
        return nil
    }
    
    
}


struct PaymentCalculateViewmodel{
    
    var currentBalance : String = "0.00"
    var balance:String
    var amount:String
    
    mutating func calculateBalance(completion:(String,String,Int)->Void){
        
        let balanceIndouble = Double.init(balance) ?? 0.00
        let amountIndouble = Double.init(amount) ?? 0.00
        
        if amountIndouble > balanceIndouble{
            completion("","Amount should be less than or equal to balance amount",1)
        }else if Int(amountIndouble) == 0{
            completion("","Amount cannot be zero",1)
        }else if Int(balanceIndouble) == 0{
            completion("","Balance amount cannot be zero",1)
        }else{
            
            let getBalance = balanceIndouble - amountIndouble
            currentBalance = (getBalance).format(f: ".2")
            completion(currentBalance,"",0)
        }
        
    }
}

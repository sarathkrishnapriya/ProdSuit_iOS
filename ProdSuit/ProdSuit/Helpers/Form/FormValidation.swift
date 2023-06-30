//
//  FormValidation.swift
//  ProdSuit
//
//  Created by MacBook on 02/05/23.
//

import Foundation
import UIKit
import Combine


class LeadGenerationForm:ObservableObject{
    @Published var leadDetailsDate:String = ""
    @Published var honorsString : String = ""
    @Published var customerNameString : String = ""
    @Published var categoryString :String = ""
    @Published var priorityString : String = ""
    @Published var noteString : String = ""
    @Published var actionTypeString : String = ""
    @Published var actionSubTypeString : String = ""
    @Published var actionDateString : String = ""
    
    var isValidDate:AnyPublisher<Bool,Never>{
        $leadDetailsDate
            .map{ lead_add_date in
                return lead_add_date != ""
            }
            .eraseToAnyPublisher()
    }
    
    var isValidHonors:AnyPublisher<Bool,Never>{
        $honorsString
            .map{ honor in
                return honor != ""
        }
            .eraseToAnyPublisher()
    }
    
    var isValidCustomer:AnyPublisher<Bool,Never>{
        $customerNameString
            .map{ customer in
                return customer != ""
            }
            .eraseToAnyPublisher()
    }
    
    var isValidCategory:AnyPublisher<Bool,Never>{
        $categoryString
            .map{ category_text in
                return category_text != ""
            }
            .eraseToAnyPublisher()
    }
    
    var getPriority:AnyPublisher<Bool,Never>{
        $priorityString
            .map{ priorityValue in
               return priorityValue != ""
            }
            .eraseToAnyPublisher()
    }
    
    var getNote:AnyPublisher<Bool,Never>{
        $noteString
            .map{ note_text in
               return note_text != ""
            }
            .eraseToAnyPublisher()
    }
    
    
    
    var getActionSubType:AnyPublisher<Bool,Never>{
        $actionSubTypeString
            .map{ sub_type in
               return sub_type != ""
            }
            .eraseToAnyPublisher()
    }
    
    var getActionDateType:AnyPublisher<Bool,Never>{
        $actionDateString
            .map{ action_date in
               return action_date != ""
            }
            .eraseToAnyPublisher()
    }
    
    
    var getActionType:AnyPublisher<Bool,Never>{
        $actionTypeString
            .map{ action_type in
               return action_type != ""
            }
            .eraseToAnyPublisher()
    }
    
    
    var getAction:AnyPublisher<Bool,Never>{
        
        return isValidActionType()
        
    }
    
    
    public func isValidActionType() -> AnyPublisher<Bool,Never>{
        return Publishers.CombineLatest3(getActionType.print("Action Cannot be blank"),getActionSubType.print("Action Type Cannot be blank"),getActionDateType.print("Action Date Cannot be blank"))
            .map { isValidAction,isValidSubType,isValidDate in
            return isValidAction && isValidSubType && isValidDate
        }
            .print("isValidForm")
            .eraseToAnyPublisher()
    }
    
    
   
    
   
    
}

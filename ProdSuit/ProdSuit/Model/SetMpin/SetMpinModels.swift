//
//  SetMpinModels.swift
//  ProdSuit
//
//  Created by MacBook on 06/03/23.
//

import Foundation
import UIKit

//"MPINDetails": {
//        "MPIN": "123456",
//        "ResponseCode": "0",
//        "ResponseMessage": "MPIN Updated Successfully"
//    }

struct SetMpinModel{
    var mpin : String
    var responseCode : String
    var responseMessage : String
    init(datas:NSDictionary){
        self.mpin = datas.value(forKey: "MPIN") as? String ?? ""
        self.responseCode = datas.value(forKey: "ResponseCode") as? String ?? ""
        self.responseMessage = datas.value(forKey: "ResponseMessage") as? String ?? ""
    }
}

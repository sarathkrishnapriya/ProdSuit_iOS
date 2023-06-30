//
//  ChartDashBoardModels.swift
//  ProdSuit
//
//  Created by MacBook on 27/03/23.
//

import Foundation
import UIKit

struct LeadDashBoardDetailsModel{
    
    var Count:Double
    var Fileds:String
    
    init(datas:NSDictionary) {
        
        self.Fileds = datas.value(forKey: "Fileds") as? String ?? ""
        self.Count = datas.value(forKey: "Count") as? Double ?? 0.00
        
    }
    
}

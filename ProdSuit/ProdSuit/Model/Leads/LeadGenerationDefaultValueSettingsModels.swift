//
//  LeadGenerationDefaultValueSettingsModels.swift
//  ProdSuit
//
//  Created by MacBook on 10/04/23.
//

import Foundation
import UIKit



//"ID_Employee": 40,
//        "EmpFName": "VYSHAKH PN",
//        "ID_BranchType": 3,
//        "BranchType": "Branch Office",
//        "ID_Branch": 3,
//        "Branch": "Hi -Lite Branch",
//        "FK_Department": 2,
//        "Department": "Customer service",
//        "FK_Country": 10,
//        "Country": "INDIA",
//        "FK_States": 1,
//        "StateName": "KERALA",
//        "FK_District": 3,
//        "DistrictName": "WAYANAD"

struct LeadGenerationDefaultValueModel{
    
    var ID_Employee : NSNumber
    var EmpFName : String
    
    var ID_BranchType : NSNumber
    var BranchType : String
    
    var ID_Branch : NSNumber
    var Branch : String
    
    var FK_Department : NSNumber
    var Department : String
    
    var FK_Country : NSNumber
    var Country : String
    
    var FK_States : NSNumber
    var StateName : String
    
    var FK_District : NSNumber
    var DistrictName : String
    
    init(datas:NSDictionary){
        
        self.ID_Employee = datas.value(forKey: "ID_Employee") as? NSNumber ?? -1
        self.EmpFName = datas.value(forKey: "EmpFName") as? String ?? ""
        
        self.ID_BranchType = datas.value(forKey: "ID_BranchType") as? NSNumber ?? -1
        self.BranchType = datas.value(forKey: "BranchType") as? String ?? ""
        
        self.ID_Branch = datas.value(forKey: "ID_Branch") as? NSNumber ?? -1
        self.Branch = datas.value(forKey: "Branch") as? String ?? ""
        
        self.FK_Department = datas.value(forKey: "FK_Department") as? NSNumber ?? -1
        self.Department = datas.value(forKey: "Department") as? String ?? ""
        
        self.FK_Country = datas.value(forKey: "FK_Country") as? NSNumber ?? -1
        self.Country = datas.value(forKey: "Country") as? String ?? ""
        
        
        self.FK_States = datas.value(forKey: "FK_States") as? NSNumber ?? -1
        self.StateName = datas.value(forKey: "StateName") as? String ?? ""
        
        
        self.FK_District = datas.value(forKey: "FK_District") as? NSNumber ?? -1
        self.DistrictName = datas.value(forKey: "DistrictName") as? String ?? ""
        
    }
}


struct LeadDetailsViewDataModel{
    var date:String
    var name:String
    
}


struct SelectedLeadGenerationDefaultValue{
    var ID_Employee : NSNumber?
    var EmpFName : String?
    
    var ID_BranchType : NSNumber?
    var BranchType : String?
    
    var ID_Branch : NSNumber?
    var Branch : String?
    var FK_Department : NSNumber?
    var Department : String?
    var FK_Country : NSNumber?
    var Country : String?
    
    var FK_States : NSNumber?
    var StateName : String?
    
    var FK_District : NSNumber?
    var DistrictName : String?
    
    var FK_Area : NSNumber?
    var Area : String?
    
    var PostID : NSNumber?
    var PostName : String?
    
    var Pincode : String?
    
    var address : String?
    
    var FK_Place : NSNumber?
    var Place : String?
    
    
}



//"FK_Country": 10,
//"Country": "INDIA"
struct CountryDetailsListInfo:HasValue{
    
    var value: String{ return Country }
    
    
    
    var FK_Country : NSNumber
    var Country : String
    init(datas:NSDictionary) {
        self.FK_Country = datas.value(forKey: "FK_Country") as? NSNumber ?? -1
        self.Country = datas.value(forKey: "Country") as? String ?? ""
    }
}

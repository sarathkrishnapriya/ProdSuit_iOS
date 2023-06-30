//
//  LoginModels.swift
//  ProdSuit
//
//  Created by MacBook on 03/03/23.
//

import Foundation
import UIKit



struct UserLoginDetailsModel{
    
    //1."FK_Employee": 40,
    var FK_Employee  : NSNumber
    
    //2."UserName": "VYSHAKH PN",
    var UserName : String
    
    //3."Address": "ABCD homes",
    var Address : String
    
    //4."MobileNumber": "9605080960",
    var MobileNumber : String
    
    //5."Token": "8012CC85-C936-4B78-B0A5-C09E649BD967",
    var Token : String
    
    //6."Email": "aiswarya@gmail.com",
    var Email : String
    
    //7."UserCode": "VYSHAKH",
    var UserCode : String
    
    //8."FK_Branch": 3,
    var FK_Branch : NSNumber
    
    //9."BranchName": "Hi -Lite Branch",
    var BranchName : String
    
    //10."FK_BranchType": 2,
    var FK_BranchType : NSNumber
    
    //11."FK_Company": 1,
    var FK_Company : NSNumber
    
    //12."FK_BranchCodeUser": 3,
    var FK_BranchCodeUser : NSNumber
    
    //13."FK_UserRole": 13,
    var FK_UserRole : NSNumber
    
    //14."UserRole": "Admin User",
    var UserRole : String
    
    //15."IsAdmin": 1,
    var IsAdmin : NSNumber
    
    //16."ID_User": 67,
    var ID_User : NSNumber
    
    //17."CompanyCategory": 1,
    var CompanyCategory : NSNumber
    
    var FK_Department : NSNumber
    
    var LocLongitude : String
    
    var LocLattitude : String
    
    var LocLocationName : String
    
    var EnteredDate : String
    
    var EnteredTime : String
    
    
    
    var status : Bool
    
    var moduleList : ModuleList
    
    var utilityList : UtilityList
    
    init(datas:NSDictionary) {
        
        self.FK_Employee = datas.value(forKey: "FK_Employee") as? NSNumber ?? 0
        self.UserName = datas.value(forKey: "UserName") as? String ?? ""
        self.Address = datas.value(forKey: "Address") as? String ?? ""
        self.MobileNumber = datas.value(forKey: "MobileNumber") as? String ?? ""
        self.Token = datas.value(forKey: "Token") as? String ?? ""
        
        
        self.Email = datas.value(forKey: "Email") as? String ?? ""
        self.UserCode = datas.value(forKey: "UserCode") as? String ?? ""
        self.FK_Branch = datas.value(forKey: "FK_Branch") as? NSNumber ?? 0
        self.BranchName = datas.value(forKey: "BranchName") as? String ?? ""
        self.FK_BranchType = datas.value(forKey: "FK_BranchType") as? NSNumber ?? 0
        self.FK_Department = datas.value(forKey: "FK_Department") as? NSNumber ?? 0
        
        
        self.FK_Company = datas.value(forKey: "FK_Company") as? NSNumber ?? 0
        self.FK_BranchCodeUser = datas.value(forKey: "FK_BranchCodeUser") as? NSNumber ?? 0
        self.FK_UserRole = datas.value(forKey: "FK_UserRole") as? NSNumber ?? 0
        self.UserRole = datas.value(forKey: "UserRole") as? String ?? ""
        self.IsAdmin = datas.value(forKey: "IsAdmin") as? NSNumber ?? 0
        
        self.ID_User = datas.value(forKey: "ID_User") as? NSNumber ?? 0
        self.CompanyCategory = datas.value(forKey: "CompanyCategory") as? NSNumber ?? 0
        
        self.LocLongitude = datas.value(forKey: "LocLongitude") as? String ?? ""
        self.LocLattitude = datas.value(forKey: "LocLattitude") as? String ?? ""
        self.LocLocationName = datas.value(forKey: "LocLocationName") as? String ?? ""
        self.EnteredDate = datas.value(forKey: "EnteredDate") as? String ?? ""
        self.EnteredTime = datas.value(forKey: "EnteredTime") as? String ?? ""

        self.status = datas.value(forKey: "Status") as? Bool ?? false
        
        let modulelist = datas.value(forKey: "ModuleList") as? NSDictionary ?? [:]
        self.moduleList = ModuleList.init(datas: modulelist)
        
        let utilitylist = datas.value(forKey: "UtilityList") as? NSDictionary ?? [:]
        self.utilityList = UtilityList.init(datas: utilitylist)
        
        
    }
    
}

struct ModuleList{
    var MASTER : Bool
    var SERVICE : Bool
    var LEAD : Bool
    var INVENTORY : Bool
    var SETTINGS : Bool
    var SECURITY : Bool

    var REPORT : Bool
    var PROJECT : Bool
    var OTHER : Bool
    var PRODUCTION : Bool
    var ACCOUNTS : Bool
    var ASSET : Bool
    var TOOL : Bool
    var VEHICLE : Bool
    var DELIVERY : Bool
    var HR : Bool
    
    init(datas:NSDictionary) {
        self.MASTER = datas.value(forKey: "MASTER") as? Bool ?? false
        self.SERVICE = datas.value(forKey: "SERVICE") as? Bool ?? false
        self.LEAD = datas.value(forKey: "LEAD") as? Bool ?? false
        self.INVENTORY = datas.value(forKey: "INVENTORY") as? Bool ?? false
        self.SETTINGS = datas.value(forKey: "SETTINGS") as? Bool ?? false
        self.SECURITY = datas.value(forKey: "SECURITY") as? Bool ?? false
        self.REPORT = datas.value(forKey: "REPORT") as? Bool ?? false
        self.PROJECT = datas.value(forKey: "PROJECT") as? Bool ?? false
        self.OTHER = datas.value(forKey: "OTHER") as? Bool ?? false
        self.PRODUCTION = datas.value(forKey: "PRODUCTION") as? Bool ?? false
        self.ACCOUNTS = datas.value(forKey: "ACCOUNTS") as? Bool ?? false
        self.ASSET = datas.value(forKey: "ASSET") as? Bool ?? false
        self.TOOL = datas.value(forKey: "TOOL") as? Bool ?? false
        self.VEHICLE = datas.value(forKey: "VEHICLE") as? Bool ?? false
        self.DELIVERY = datas.value(forKey: "DELIVERY") as? Bool ?? false
        self.HR = datas.value(forKey: "HR") as? Bool ?? false
    }
}

struct UtilityList{
    var ATTANCE_MARKING : Bool
    var LOCATION_TRACKING : Bool
    var LOCATION_INTERVAL : Int
    init(datas:NSDictionary) {
        self.ATTANCE_MARKING = datas.value(forKey: "ATTANCE_MARKING") as? Bool ?? false
        self.LOCATION_TRACKING = datas.value(forKey: "LOCATION_TRACKING") as? Bool ?? false
        self.LOCATION_INTERVAL = datas.value(forKey: "LOCATION_INTERVAL") as? Int ?? 0
    }
}

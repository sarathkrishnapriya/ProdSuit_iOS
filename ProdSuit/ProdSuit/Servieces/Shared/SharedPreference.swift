//
//  SharedPreference.swift
//  ProdSuit
//
//  Created by MacBook on 22/02/23.
//

import Foundation
import UIKit
import Security



struct SharedPreference{
    
    static var Shared = SharedPreference()
    
    var isLogged : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.isLogged.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.isLogged.rawValue)
        }
    }
    
    var onBoardCompleted : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.onBoard.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.onBoard.rawValue)
        }
    }
    
    var welcomedPageCompleted : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.welcome.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.welcome.rawValue)
        }
    }
    
    var isCommonApp : String{
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.isCommonApp.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.isCommonApp.rawValue)
        }
    }
    
    // appBankKey
    var appBankKey : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.hasBankKey.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.hasBankKey.rawValue)
        }
    }
    
    // AppIconImageCode
    var AppIconImageCode : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.AppIconImageCode.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.AppIconImageCode.rawValue)
        }
    }
    
    //ResellerName
    var ResellerName : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.ResellerName.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.ResellerName.rawValue)
        }
    }
    
    //CompanyLogoImageCode
    var CompanyLogoImageCode : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.CompanyLogoImageCode.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.CompanyLogoImageCode.rawValue)
        }
    }
    
    //ProductName
    var ProductName : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.ProductName.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.ProductName.rawValue)
        }
    }
    
    //PlayStoreLink
    var PlayStoreLink : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.PlayStoreLink.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.PlayStoreLink.rawValue)
        }
    }
    
    //AppStoreLink
    var AppStoreLink : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.AppStoreLink.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.AppStoreLink.rawValue)
        }
    }
    
    //ContactNumber
    var ContactNumber : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.ContactNumber.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.ContactNumber.rawValue)
        }
    }
    
    //ContactAddress
    var ContactAddress : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.ContactAddress.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.ContactAddress.rawValue)
        }
    }
    
    
    //ContactEmail
    var ContactEmail : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.ContactEmail.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.ContactEmail.rawValue)
        }
    }
    
    //CertificateName
    var CertificateName : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.CertificateName.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.CertificateName.rawValue)
        }
    }
    
    //TestingURL
    var TestingURL : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.TestingURL.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.TestingURL.rawValue)
        }
    }
    
    //TestingMachineId
    var TestingMachineId : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.TestingMachineId.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.TestingMachineId.rawValue)
        }
    }
    
    //TestingImageURL
    var TestingImageURL : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.TestingImageURL.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.TestingImageURL.rawValue)
        }
    }
    
    
    //TestingMobileNo
    var TestingMobileNo : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.TestingMobileNo.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.TestingMobileNo.rawValue)
        }
    }
    
    
    //TestingBankKey
    var TestingBankKey : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.TestingBankKey.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.TestingBankKey.rawValue)
        }
    }
    
    //TestingBankHeader
    var TestingBankHeader : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.TestingBankHeader.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.TestingBankHeader.rawValue)
        }
    }
    
    //AboutUs
    var AboutUs : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.AboutUs.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.AboutUs.rawValue)
        }
    }
    


  // ===========================  User Info ===================================

    
    
    // User_Fk_Employee
    var User_Fk_Employee : NSNumber{
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_FK_Employee.rawValue) as! NSNumber
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_FK_Employee.rawValue)
        }
    }
    
    //User_UserName
    var User_UserName : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.user_UserName.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_UserName.rawValue)
        }
    }
    
    // User_Address
    var User_Address : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.user_Address.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_Address.rawValue)
        }
    }
    
    // User_MobileNumber
    
    var User_MobileNumber : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.user_MobileNumber.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_MobileNumber.rawValue)
        }
    }
    
    // User_Token
    
    var User_Token : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.user_Token.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_Token.rawValue)
        }
    }
    
    
    // User_Email
    
    var User_Email : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.user_Email.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_Email.rawValue)
        }
    }
    
    // User_UserCode
    var User_UserCode : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.user_UserCode.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_UserCode.rawValue)
        }
    }
    
    
    // User_FK_Branch
    var User_FK_Branch : NSNumber{
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_FK_Branch.rawValue) as! NSNumber
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_FK_Branch.rawValue)
        }
    }
    
    
    // User_BranchName
    var User_BranchName : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.user_BranchName.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_BranchName.rawValue)
        }
    }
    
    
    // User_FK_BranchType
    var User_FK_BranchType : NSNumber{
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_FK_BranchType.rawValue) as! NSNumber
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_FK_BranchType.rawValue)
        }
    }
    
    
    // user_FK_Company
    var User_FK_Company : NSNumber{
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_FK_Company.rawValue) as! NSNumber
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_FK_Company.rawValue)
        }
    }
    
    
    // User_FK_BranchCodeUser
    var User_FK_BranchCodeUser : NSNumber{
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_FK_BranchCodeUser.rawValue) as! NSNumber
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_FK_BranchCodeUser.rawValue)
        }
    }
    
    // User_FK_DepartMent
    var User_FK_DepartMent : NSNumber{
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_Fk_Department.rawValue) as! NSNumber
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_Fk_Department.rawValue)
        }
    }
    
    // User_FK_UserRole
    var User_FK_UserRole : NSNumber{
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_FK_UserRole.rawValue) as! NSNumber
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_FK_UserRole.rawValue)
        }
    }
    
    
    // User_UserRole
    var User_UserRole : String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.user_UserRole.rawValue) ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_UserRole.rawValue)
        }
    }
    
    // User_IsAdmin
    var User_IsAdmin : NSNumber{
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_IsAdmin.rawValue) as! NSNumber
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_IsAdmin.rawValue)
        }
    }


    // User_ID_User
    var User_ID_User : NSNumber{
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_ID_User.rawValue) as! NSNumber
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_ID_User.rawValue)
        }
    }
    
    
    // User_CompanyCategory
    var User_CompanyCategory : NSNumber{
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_CompanyCategory.rawValue) as! NSNumber
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_CompanyCategory.rawValue)
        }
    }
    
    var User_LoggedDate : String{
        
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_logged_date.rawValue) as! String
        }
        
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_logged_date.rawValue)
        }
        
    }
    
    
//case user_loc_LocLattitude = "locLattitude" // string
    
    var User_loc_LocLattitude : String{
        
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_loc_LocLattitude.rawValue) as! String
        }
        
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_loc_LocLattitude.rawValue)
        }
        
    }
    
//case user_loc_LocLongitude = "locLongitude" // string
    
    var User_loc_LocLongitude : String{
        
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_loc_LocLongitude.rawValue) as! String
        }
        
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_loc_LocLongitude.rawValue)
        }
        
    }
//case user_loc_LocLocationName = "locLocationName" // string
  
    var User_loc_LocLocationName : String{
        
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_loc_LocLocationName.rawValue) as! String
        }
        
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_loc_LocLocationName.rawValue)
        }
        
    }
    
//case user_EnteredDate = "enteredDate" // string
    
    var User_EnteredDate : String{
        
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_EnteredDate.rawValue) as! String
        }
        
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_EnteredDate.rawValue)
        }
        
    }
    
//case user_EnteredTime = "enteredTime" // string
    
    var User_EnteredTime : String{
        
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_EnteredTime.rawValue) as! String
        }
        
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_EnteredTime.rawValue)
        }
        
    }
//case user_Status = "status" // bool
    var User_Status : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_Status.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_Status.rawValue)
        }
    }
//case user_module_MASTER = "MASTER" // bool
    var User_module_MASTER : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_MASTER.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_MASTER.rawValue)
        }
    }
//case user_module_SERVICE = "SERVICE" // bool
    var User_module_SERVICE : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_SERVICE.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_SERVICE.rawValue)
        }
    }
//case user_module_LEAD = "LEAD" // bool
    var User_module_LEAD : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_LEAD.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_LEAD.rawValue)
        }
    }
//case user_module_INVENTORY = "INVENTORY" // bool
    var User_module_INVENTORY : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_INVENTORY.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_INVENTORY.rawValue)
        }
    }
//case user_module_SETTINGS = "SETTINGS" // bool
    var User_module_SETTINGS : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_SETTINGS.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_SETTINGS.rawValue)
        }
    }
//case user_module_SECURITY = "SECURITY" // bool
    var User_module_SECURITY : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_SECURITY.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_SECURITY.rawValue)
        }
    }
//case user_module_REPORT = "REPORT" // bool
    var User_module_REPORT : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_REPORT.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_REPORT.rawValue)
        }
    }
//case user_module_PROJECT = "PROJECT" // bool
    var User_module_PROJECT : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_PROJECT.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_PROJECT.rawValue)
        }
    }
//case user_module_OTHER = "OTHER" // bool
    var User_module_OTHER : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_OTHER.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_OTHER.rawValue)
        }
    }
//case user_module_PRODUCTION = "PRODUCTION" // bool
    var User_module_PRODUCTION : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_PRODUCTION.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_PRODUCTION.rawValue)
        }
    }
//case user_module_ACCOUNTS = "ACCOUNTS" // bool
    var User_module_ACCOUNTS : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_ACCOUNTS.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_ACCOUNTS.rawValue)
        }
    }
//case user_module_ASSET = "ASSET" // bool
    var User_module_ASSET : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_ASSET.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_ASSET.rawValue)
        }
    }
//case user_module_TOOL = "TOOL" // bool
    var User_module_TOOL : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_TOOL.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_TOOL.rawValue)
        }
    }
//case user_module_VEHICLE = "VEHICLE" // bool
    var User_module_VEHICLE : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_VEHICLE.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_VEHICLE.rawValue)
        }
    }
//case user_module_DELIVERY = "DELIVERY" // bool
    var User_module_DELIVERY : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_DELIVERY.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_DELIVERY.rawValue)
        }
    }
//case user_module_HR = "HR" // bool
    var User_module_HR : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_HR.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_HR.rawValue)
        }
    }
//
//case user_module_ATTANCE_MARKING = "ATTANCE_MARKING" // bool
    var User_module_ATTANCE_MARKING : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_ATTANCE_MARKING.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_ATTANCE_MARKING.rawValue)
        }
    }
//case user_module_LOCATION_TRACKING = "LOCATION_TRACKING" // bool
    var User_module_LOCATION_TRACKING : Bool{
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.user_module_LOCATION_TRACKING.rawValue)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_LOCATION_TRACKING.rawValue)
        }
    }
//case user_module_LOCATION_INTERVAL = "LOCATION_INTERVAL" // Int
    var User_module_LOCATION_INTERVAL : Int{
        get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.user_module_LOCATION_INTERVAL.rawValue) as? Int ?? 0
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.user_module_LOCATION_INTERVAL.rawValue)
        }
    }

   

    
    
    
    // =============================== logout =====================================
    
    func logOut(){
        
        
        for value in UserDefaultKeys.allCases{
        UserDefaults.standard.removeObject(forKey: value.rawValue)
        }
        AppVC.Shared.initiateToRootViewController()
    }
    
    
}

enum UserDefaultKeys:String,CaseIterable{
    case isLogged = "isLogged"
    case onBoard = "hasOnBoard"
    case welcome = "hasWelcomed"
    case isCommonApp = "commonapp"
    case hasBankKey = "bankKey"
    
    
    case AppIconImageCode = "appIconImageCode"
    case ResellerName = "resellerName"
    case CompanyLogoImageCode = "companyLogoImageCode"
    case ProductName = "productName"
    case PlayStoreLink = "playStoreLink"
    case AppStoreLink = "appStoreLink"
    case ContactNumber = "contactNumber"
    case ContactEmail = "contactEmail"
    case ContactAddress = "contactAddress"
    case CertificateName = "certificateName"
    
    case TestingURL = "testingURL"
    case TestingMachineId = "testingMachineId"
    case TestingImageURL = "testingImageURL"
    case TestingMobileNo = "testingMobileNo"
    case TestingBankKey = "testingBankKey"
    case TestingBankHeader = "testingBankHeader"
    case AboutUs = "aboutUs"
    
    
    //"user info keys"
    
    case user_FK_Employee = "fK_Employee" // nsnumber
    case user_UserName = "userName" // string
    case user_Address = "user_address" // string
    case user_MobileNumber = "user_mobileNumber" // string
    case user_Token = "user_token" // string
    
    case user_Email = "user_email" // string
    case user_UserCode = "userCode" // string
    case user_FK_Branch = "fK_Branch" // nsnumber
    case user_BranchName = "branchName" // string
    case user_FK_BranchType = "fK_BranchType" // nsnumber
    
    
    case user_FK_Company = "fK_Company" // nsnumber
    case user_FK_BranchCodeUser = "fK_BranchCodeUser" // nsnumber
    case user_FK_UserRole = "fK_UserRole" // nsnumber
    case user_UserRole = "userRole" // string
    case user_IsAdmin = "isAdmin" // nsnumber
    case user_Fk_Department = "fK_Department" // nsnumber
    
    case user_ID_User = "id_User" // nsnumber
    case user_CompanyCategory = "companyCategory" // nsnumber
    case user_logged_date = "userLoggedDate" // Date
    
    case user_loc_LocLattitude = "locLattitude" // string
    case user_loc_LocLongitude = "locLongitude" // string
    case user_loc_LocLocationName = "locLocationName" // string
    
    case user_EnteredDate = "enteredDate" // string
    case user_EnteredTime = "enteredTime" // string
    case user_Status = "status" // bool
    
    case user_module_MASTER = "MASTER" // bool
    case user_module_SERVICE = "SERVICE" // bool
    case user_module_LEAD = "LEAD" // bool
    case user_module_INVENTORY = "INVENTORY" // bool
    case user_module_SETTINGS = "SETTINGS" // bool
    case user_module_SECURITY = "SECURITY" // bool
    case user_module_REPORT = "REPORT" // bool
    case user_module_PROJECT = "PROJECT" // bool
    case user_module_OTHER = "OTHER" // bool
    case user_module_PRODUCTION = "PRODUCTION" // bool
    case user_module_ACCOUNTS = "ACCOUNTS" // bool
    case user_module_ASSET = "ASSET" // bool
    case user_module_TOOL = "TOOL" // bool
    case user_module_VEHICLE = "VEHICLE" // bool
    case user_module_DELIVERY = "DELIVERY" // bool
    case user_module_HR = "HR" // bool
    
    case user_module_ATTANCE_MARKING = "ATTANCE_MARKING" // bool
    case user_module_LOCATION_TRACKING = "LOCATION_TRACKING" // bool
    case user_module_LOCATION_INTERVAL = "LOCATION_INTERVAL" // Int
    
}

/*"ResellerName": "ProdSuit Demo",
 "AppIconImageCode": "/Images/ResellerImages/applogo.png",
 "CompanyLogoImageCode": "/Images/ResellerImages/companylogo.png",
 "ProductName": "ProdSuit Demo",
 "PlayStoreLink": "https://play.google.com/store",
 "AppStoreLink": "https://play.google.com/store",
 "ContactNumber": "9539036341",
 "ContactEmail": "sree@gmail.com",
 "ContactAddress": null,
 "CertificateName": "demo.pem",
 "TestingURL": "https://112.133.227.123:14020/ProdsuiteAPI/api",
 "TestingMachineId": "10.4.11.11",
 "TestingImageURL": "https://112.133.227.123:14020/ProdsuiteAPI",
 "TestingMobileNo": "9966225511",
 "TestingBankKey": "-600",
 "TestingBankHeader": "PERFECT  BANK HEAD OFFICE DEMO",
 "AboutUs": "PERFECT  BANK HEAD OFFICE",
 */



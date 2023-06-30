//
//  SplashModels.swift
//  ProdSuit
//
//  Created by MacBook on 01/03/23.
//

import Foundation
import UIKit

// Maintenance Message Response

/*"MaintenanceMessage": {
        "Description": "Warrning,Do you want to continue",
        "Type": 1,
        "ResponseCode": "0",
        "ResponseMessage": "Transaction Verified"
    }*/

struct MaintenanceModel {
    var Description : String
    var Types : NSNumber
    var ResponseCode : String
    var ResponseMessage : String
    init(datas:NSDictionary) {
        self.Description = datas.value(forKey: "Description") as? String ?? ""
        self.Types = datas.value(forKey: "Type") as? NSNumber ?? -5
        self.ResponseCode = datas.value(forKey: "ResponseCode") as? String ?? ""
        self.ResponseMessage = datas.value(forKey: "ResponseMessage") as? String ?? ""
    }
}

/*
 
 "ResellerDetails": {
        "ResellerName": "ProdSuit Demo",
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
        "ResponseCode": "0",
        "ResponseMessage": "Transaction Verified"
    },

*/

struct ResellerDetailModel {
    var aboutUs : String
    var appIconImageCode : String
    var AppstoreLink : String
    var certificateName : String
    
    var contactAddress : String
    var contactEmail : String
    var contactNumber: String
    var playstoreLink : String
    
    var productName:String
    var resellerName : String
    
    var companyLogoImageCode : String
    
   
    
    
    
   
    
    
    var testingBankHeader : String
    
    var testingBankKey : String
    var testingImageUrl : String
    var testingMachineId : String
    var testingMobileNo : String
    
    var testingUrl : String
    
    init(datas:NSDictionary) {
        
        self.aboutUs = datas.value(forKey: "AboutUs") as? String ?? ""
        self.appIconImageCode = datas.value(forKey: "AppIconImageCode") as? String ?? ""
        self.AppstoreLink = datas.value(forKey: "AppStoreLink") as? String ?? ""
        self.certificateName = datas.value(forKey: "CertificateName") as? String ?? ""
        
        self.companyLogoImageCode = datas.value(forKey: "TechnologyPartnerImage") as? String ?? ""
        self.contactNumber = datas.value(forKey: "ContactNumber") as? String ?? ""
        self.playstoreLink = datas.value(forKey: "PlayStoreLink") as? String ?? ""
        self.contactAddress = datas.value(forKey: "ContactAddress") as? String ?? ""
        
        self.contactEmail = datas.value(forKey: "ContactEmail") as? String ?? ""
        self.productName = datas.value(forKey: "ProductName") as? String ?? ""
        self.resellerName = datas.value(forKey: "ResellerName") as? String ?? ""
        self.testingBankHeader = datas.value(forKey: "TestingBankHeader") as? String ?? ""
        
        self.testingBankKey = datas.value(forKey: "TestingBankKey") as? String ?? ""
        self.testingImageUrl = datas.value(forKey: "TestingImageURL") as? String ?? ""
        self.testingMachineId = datas.value(forKey: "TestingMachineId") as? String ?? ""
        self.testingMobileNo = datas.value(forKey: "TestingMobileNo") as? String ?? ""
        
        self.testingUrl = datas.value(forKey: "TestingURL") as? String ?? ""
        
       
        
        
    }
}

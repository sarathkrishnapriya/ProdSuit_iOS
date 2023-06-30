//
//  DashboardModels.swift
//  ProdSuit
//
//  Created by MacBook on 08/03/23.
//

import Foundation
import UIKit

struct BannerDetailItemModel {
    var ID_Banner : NSNumber
    var ImagePath : String
    init(datas:NSDictionary){
        self.ID_Banner = datas.value(forKey: "ID_Banner") as? NSNumber ?? 0
        self.ImagePath = datas.value(forKey: "ImagePath") as? String ?? ""
    }
}

struct MenuModel{
    
    var name : String
    var image : UIImage
    var hasNotification : Bool
    var visible : Bool
    
    
    init(name : String,image : UIImage,hasNotification : Bool = false,visible:Bool=true) {
        self.name = name
        self.image = image
        self.hasNotification = hasNotification
        self.visible = visible
    }
}

struct SidMenueModel{
    
    var name : String
    var image : UIImage
    
    init(name : String,image : UIImage) {
        
        self.name = name
        self.image = image
        
    }
    
}


struct CompanyLogDetailsModel{
    
    var BranchName : String
    var CompanyLogo : String
    var CompanyName : String
    var DisplayType : String
    
    init(datas:NSDictionary) {
        self.BranchName = datas.value(forKey: "BranchName") as? String ?? ""
        self.CompanyLogo = datas.value(forKey: "CompanyLogo") as? String ?? ""
        self.CompanyName = datas.value(forKey: "CompanyName") as? String ?? ""
        self.DisplayType = datas.value(forKey: "DisplayType") as? String ?? "0"
    }
}

//"ID_Notification": 624,
//                "SendOn": "Mar  7 2023  6:09PM",
//                "Title": "fghf",
//                "Message": "hfghfgh",
//                "EmpImgValue": null,
//                "IsRead": 0,
//                "EmpFName": "VYSHAKH PN"

struct NotificationDetailsInfo{
    
    var ID_Notification : NSNumber
    var SendOn : String
    var Title : String
    var Message : String
    
    var EmpImgValue : String
    var IsRead : NSNumber
    var EmpFName : String
    
    init(datas:NSDictionary) {
        
        self.ID_Notification = datas.value(forKey: "ID_Notification") as? NSNumber ?? 0
        self.SendOn = datas.value(forKey: "SendOn") as? String ?? ""
        self.Title = datas.value(forKey: "Title") as? String ?? ""
        self.Message = datas.value(forKey: "Message") as? String ?? ""
        self.EmpImgValue = datas.value(forKey: "EmpImgValue") as? String ?? ""
        self.IsRead = datas.value(forKey: "IsRead") as? NSNumber ?? 0
        self.EmpFName = datas.value(forKey: "EmpFName") as? String ?? ""
        
        
    }
    
    
}


var menuItemList : [MenuModel] = [MenuModel(name:"Agenda",image:UIImage(named:"home_agenda")!,
                                          hasNotification: false),
                     MenuModel(name: "Dashboard", image: UIImage(named: "home_dashboard")!,hasNotification: false),
                     MenuModel(name: "Notification", image: UIImage(named: "home_notification")!,hasNotification: true),
                                  
                     MenuModel(name: "Leads", image: UIImage(named: "home_leads")!,hasNotification: false),
                     MenuModel(name: "Service", image: UIImage(named: "home_service")!,hasNotification: false),
                    MenuModel(name: "Collection", image: UIImage(named: "home_collection")!,hasNotification: false),
                    MenuModel(name: "Pickup Delivery", image: UIImage(named: "home_pickupdelivery")!,hasNotification: false),
                    MenuModel(name: "Location Details", image: UIImage(named: "locationmark")!,hasNotification: false),
                    MenuModel(name: "Report", image: UIImage(named: "home_report")!,hasNotification: false),
                    MenuModel(name: "Reminder", image: UIImage(named: "home_reminder")!,hasNotification: false),
                    MenuModel(name: "Profile", image: UIImage(named: "home_profile")!,hasNotification: false),
                    MenuModel(name: "Contact us", image: UIImage(named: "home_reminder")!,hasNotification: false),
                    MenuModel(name: "About us", image: UIImage(named: "home_reminder")!,hasNotification: false)
                    ]


var sideMenueItemList : [SidMenueModel] = [SidMenueModel(name: "Profile", image:   UIImage(named: "ic_profile")!),
                                           SidMenueModel(name: "Change Mpin", image: UIImage(named: "ic_change_mpin")!),
                                           
                                           SidMenueModel(name: "About us", image: UIImage(named: "ic_about")!),
                                           
                                           SidMenueModel(name: "Contact us", image: UIImage(named: "ic_contact")!),
                                           
                                           SidMenueModel(name: "Share", image: UIImage(named: "ic_share")!),
                                           SidMenueModel(name: "Logout", image: UIImage(named: "ic_logout")!),
                                           
                                           SidMenueModel(name: "Quit", image: UIImage(named: "ic_exit")!)]



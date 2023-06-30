//
//  LeadManagementModels.swift
//  ProdSuit
//
//  Created by MacBook on 09/05/23.
//

import Foundation
import UIKit

//
//"Todolist": 0,
//        "OverDue": 37480,
//        "UpComingWorks": 2,
//        "MyLeads": 37475,
struct PendingCountInfo {
    var Todolist : NSNumber
    var OverDue : NSNumber
    var UpComingWorks : NSNumber
    var MyLeads : NSNumber
    
    init(datas:NSDictionary) {
        self.Todolist = datas.value(forKey: "Todolist") as? NSNumber ?? 0
        self.OverDue = datas.value(forKey: "OverDue") as? NSNumber ?? 0
        self.UpComingWorks = datas.value(forKey: "UpComingWorks") as? NSNumber ?? 0
        self.MyLeads = datas.value(forKey: "MyLeads") as? NSNumber ?? 0
    }
}

struct EmployeeAllDetails:HasValue {
    
    var value: String{ return EmpName }
    
    var ID_Employee : NSNumber
    var EmpName : String
    var DepartmentName : String
    var DesignationName : String
    var Branch : String
    
    
    init(datas:NSDictionary) {
        self.ID_Employee = datas.value(forKey: "ID_Employee") as? NSNumber ?? -1
        self.EmpName = datas.value(forKey: "EmpName") as? String ?? ""
        self.DepartmentName = datas.value(forKey: "DepartmentName") as? String ?? ""
        self.DesignationName = datas.value(forKey: "DesignationName") as? String ?? ""
        self.Branch = datas.value(forKey: "Branch") as? String ?? ""
        
    }
};

            
struct LeadManagementDetailsInfo{
    var SlNo : NSNumber
    var ID_LeadGenerate : NSNumber
    var ID_LeadGenerateProduct : NSNumber
    
    var LgLeadDate : String
    var LgCusName : String
    
    var LgCusMobile : String
    var LgCollectedBy : String
    var NextActionDate : String
    var DueDays : NSNumber
    
    var ProdName : String
    var ProjectName : String
    var LgpDescription : String
    var FK_Employee : String
    
    var LeadNo : String
    var Preference : String
    var AssignedTo : String
    var CusAddress : String
    
    var ID_NextAction : NSNumber
    var Action : String
    
    
    init(datas:NSDictionary) {
        self.SlNo = datas.value(forKey: "SlNo") as? NSNumber ?? 0
        self.ID_LeadGenerate = datas.value(forKey: "ID_LeadGenerate") as? NSNumber ?? 0
        self.ID_LeadGenerateProduct = datas.value(forKey: "ID_LeadGenerateProduct") as? NSNumber ?? 0
        self.LgCusMobile = datas.value(forKey: "LgCusMobile") as? String ?? ""
        self.LgLeadDate = datas.value(forKey: "LgLeadDate") as? String ?? ""
        self.LgCusName = datas.value(forKey: "LgCusName") as? String ?? ""
        self.LgCollectedBy = datas.value(forKey: "LgCollectedBy") as? String ?? ""
        self.NextActionDate = datas.value(forKey: "NextActionDate") as? String ?? ""
        
        self.DueDays = datas.value(forKey: "DueDays") as? NSNumber ?? 0
        self.ProdName = datas.value(forKey: "ProdName") as? String ?? ""
        self.ProjectName = datas.value(forKey: "ProjectName") as? String ?? ""
        self.LgpDescription = datas.value(forKey: "LgpDescription") as? String ?? ""
        
        self.FK_Employee = datas.value(forKey: "FK_Employee") as? String ?? ""
        self.LeadNo = datas.value(forKey: "LeadNo") as? String ?? ""
        self.Preference = datas.value(forKey: "Preference") as? String ?? ""
        self.AssignedTo = datas.value(forKey: "AssignedTo") as? String ?? ""
        
        self.CusAddress = datas.value(forKey: "CusAddress") as? String ?? ""
        
        self.ID_NextAction = datas.value(forKey: "ID_NextAction") as? NSNumber ?? 0
        self.Action = datas.value(forKey: "Action") as? String ?? ""
    }
}

struct LMLeadDetails:HasValue{
    var value: String { return TodoListLeadDetailsName }
    
    var TodoListLeadDetailsName : String
    var ID_TodoListLeadDetails:  NSNumber
    
    init(datas:NSDictionary){
        self.ID_TodoListLeadDetails = datas.value(forKey: "ID_TodoListLeadDetails") as? NSNumber ?? 0
        self.TodoListLeadDetailsName = datas.value(forKey: "TodoListLeadDetailsName") as? String ?? ""
    }
}



struct LeadInfoDetailsModel{
    var LeadNo : String
    var LeadDate : String
    var LeadSource : String
    
    var LeadFrom : String
    var Category : String
    var Product : String
    
    var Action : String
    var Customer : String
    var Address : String
    
    var MobileNumber : String
    var Email : String
    var CollectedBy : String
    
    var AssignedTo : String
    var TargetDate : String
    var ExpectDate : String
    
    init(datas:NSDictionary){
        
        self.LeadNo = datas.value(forKey: "LeadNo") as? String ?? ""
        self.LeadDate = datas.value(forKey: "LeadDate") as? String ?? ""
        self.LeadSource = datas.value(forKey: "LeadSource") as? String ?? ""
        
        self.LeadFrom = datas.value(forKey: "LeadFrom") as? String ?? ""
        self.Category = datas.value(forKey: "Category") as? String ?? ""
        self.Product = datas.value(forKey: "Product") as? String ?? ""
        
        
        self.Action = datas.value(forKey: "Action") as? String ?? ""
        self.Customer = datas.value(forKey: "Customer") as? String ?? ""
        self.Address = datas.value(forKey: "Address") as? String ?? ""
        
        
        self.MobileNumber = datas.value(forKey: "MobileNumber") as? String ?? ""
        self.Email = datas.value(forKey: "Email") as? String ?? ""
        self.CollectedBy = datas.value(forKey: "CollectedBy") as? String ?? ""
        
        
        self.AssignedTo = datas.value(forKey: "AssignedTo") as? String ?? ""
        self.TargetDate = datas.value(forKey: "TargetDate") as? String ?? ""
        self.ExpectDate = datas.value(forKey: "ExpectDate") as? String ?? ""
        
        
    }

    
}


struct LeadActivitiesDetailsModel{
    var ID_LeadGenerateProduct : String
    var Product : String
    var EnquiryAbout : String
    
    var LgpDescription : String
    var Action : String
    var ActionDate : String
    
    var Status : String
    var Agentremarks : String
    var FollowedBy : String
    
    var ActionType : String
    
    init(datas:NSDictionary){
        self.ID_LeadGenerateProduct = datas.value(forKey: "ID_LeadGenerateProduct") as? String ?? ""
        self.Product = datas.value(forKey: "Product") as? String ?? ""
        self.EnquiryAbout = datas.value(forKey: "EnquiryAbout") as? String ?? ""
        
        self.LgpDescription = datas.value(forKey: "LgpDescription") as? String ?? ""
        self.Action = datas.value(forKey: "Action") as? String ?? ""
        self.ActionDate = datas.value(forKey: "ActionDate") as? String ?? ""
        
        
        self.Status = datas.value(forKey: "Status") as? String ?? ""
        self.Agentremarks = datas.value(forKey: "Agentremarks") as? String ?? ""
        self.FollowedBy = datas.value(forKey: "FollowedBy") as? String ?? ""
        
        
        self.ActionType = datas.value(forKey: "ActionType") as? String ?? ""
    }
}

struct LeadImageLocationDetailsModel {
    var LocationLandMark1 : String
    var LocationLandMark2 : String
    var LocationLatitude : String
    
    var LocationLongitude : String
    var LocationName : String
    
    init(datas:NSDictionary){
        self.LocationLandMark1 = datas.value(forKey: "LocationLandMark1") as? String ?? ""
        self.LocationLandMark2 = datas.value(forKey: "LocationLandMark2") as? String ?? ""
        self.LocationLatitude = datas.value(forKey: "LocationLatitude") as? String ?? ""
        self.LocationLongitude = datas.value(forKey: "LocationLongitude") as? String ?? ""
        self.LocationName = datas.value(forKey: "LocationName") as? String ?? ""
    }
}


struct LMDDocumentDetailsModel {
    var ID_LeadDocumentDetails : NSNumber
    var DocumentSubject : String
    var DocumentImageFormat : String
    
    var DocumentDate : String
    var DocumentDescription : String
    
    init(datas:NSDictionary){
        self.ID_LeadDocumentDetails = datas.value(forKey: "ID_LeadDocumentDetails") as? NSNumber ?? 0
        self.DocumentSubject = datas.value(forKey: "DocumentSubject") as? String ?? ""
        self.DocumentImageFormat = datas.value(forKey: "DocumentImageFormat") as? String ?? ""
        self.DocumentDate = datas.value(forKey: "DocumentDate") as? String ?? ""
        
        self.DocumentDescription = datas.value(forKey: "DocumentDescription") as? String ?? ""
    }
}

struct StatusDetailsInfoModel:HasValue{
    var value: String{ return StatusName }
    var ID_Status : NSNumber
    var StatusName : String
    var IsEnable : NSNumber
    init(datas:NSDictionary){
        self.ID_Status = datas.value(forKey: "ID_Status") as? NSNumber ?? 0
        self.StatusName = datas.value(forKey: "StatusName") as? String ?? ""
        self.IsEnable = datas.value(forKey: "IsEnable") as? NSNumber ?? 0

    }
}

struct DepartmentDetailsInfoModel:HasValue{
    var value: String{ return DeptName }
    var ID_Department : NSNumber
    var DeptName : String
    
    init(datas:NSDictionary){
        self.ID_Department = datas.value(forKey: "ID_Department") as? NSNumber ?? 0
        self.DeptName = datas.value(forKey: "DeptName") as? String ?? ""
     

    }
}

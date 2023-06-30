//
//  LeadGenerationModels.swift
//  ProdSuit
//
//  Created by MacBook on 11/04/23.
//

import Foundation
import UIKit
import Network

//"ID_LeadFrom": 2,
//                "LeadFromName": "Dealer",
//                "LeadFromType": 1


struct LeadFromSelectedInfo{
    
    var ID_LeadFrom : NSNumber
    var LeadFromName : String
    var LeadFromType : NSNumber
    
}


struct WalkingCustomerDetailsInfo{
    var SlNo: NSNumber
    var ID_CustomerAssignment: NSNumber
    var Customer: String
    var Mobile: String
    var AssignedDate : String
    var Employee: String
    var FK_Employee: NSNumber
    var DESCRIPTION: String
    
    init(datas:NSDictionary){
        
        self.SlNo = datas.value(forKey: "SlNo") as? NSNumber ?? 0
        self.ID_CustomerAssignment = datas.value(forKey: "ID_CustomerAssignment") as? NSNumber ?? 0
        
        self.Customer = datas.value(forKey: "Customer") as? String ?? ""
        self.Mobile = datas.value(forKey: "Mobile") as? String ?? ""
        
        self.AssignedDate = datas.value(forKey: "AssignedDate") as? String ?? ""
        
        self.Employee = datas.value(forKey: "Employee") as? String ?? ""
        
        self.FK_Employee = datas.value(forKey: "FK_Employee") as? NSNumber ?? 0
        
        self.DESCRIPTION = datas.value(forKey: "DESCRIPTION") as? String ?? ""
        
        
    }
}



struct LeadFromDetailsInfo:HasValue{
    
    var value: String { return LeadFromName }
    
    
    var ID_LeadFrom : NSNumber
    var LeadFromName : String
    var LeadFromType : NSNumber
    
    init(datas:NSDictionary) {
        self.ID_LeadFrom = datas.value(forKey: "ID_LeadFrom") as? NSNumber ?? 0
        self.LeadFromName = datas.value(forKey: "LeadFromName") as? String ?? ""
        self.LeadFromType = datas.value(forKey: "LeadFromType") as? NSNumber ?? 0
    }
}

//"ID_LeadThrough": 15,
//                "LeadThroughName": "EX Counter",
//                "HasSub": 0

struct SelectedLeadThroughDetails{
    var ID_LeadThrough : NSNumber
    var LeadThroughName : String
    var HasSub : NSNumber
}

struct LeadThroughDetailsInfo:HasValue{
    
    var value: String { return LeadThroughName }
    
    var ID_LeadThrough : NSNumber
    var LeadThroughName : String
    var HasSub : NSNumber
    
    init(datas:NSDictionary) {
        self.ID_LeadThrough = datas.value(forKey: "ID_LeadThrough") as? NSNumber ?? 0
        self.LeadThroughName = datas.value(forKey: "LeadThroughName") as? String ?? ""
        self.HasSub = datas.value(forKey: "HasSub") as? NSNumber ?? 0
    }
    
    
}

//{
//               "ID_MediaSubMaster": 24,
//               "SubMdaName": "ins"
//           }

struct SelectedSubMediaDetails{
    var ID_MediaSubMaster : NSNumber
    var SubMdaName : String
}

struct SubMediaTypeDetailsInfo:HasValue{
    var value: String{ return SubMdaName }
    
    var ID_MediaSubMaster : NSNumber
    var SubMdaName : String
    
    init(datas:NSDictionary) {
        
        self.ID_MediaSubMaster = datas.value(forKey: "ID_MediaSubMaster") as? NSNumber ?? 0
        self.SubMdaName = datas.value(forKey: "SubMdaName") as? String ?? ""
    
    }
}
//"ID_CollectedBy": 10058,
//                "Name": "Dhanya K",
//                "DepartmentName": "Software Engineer",
//                "DesignationName": "Service Engineer"

struct SelectedUserFromCollectionDetails{
    var ID_CollectedBy:NSNumber?
    var Name :String?
    var DepartmentName : String?
    var DesignationName : String?
}

struct CollectedByUsersInfo:HasValue{
    
    var value: String {return Name}

    
    var ID_CollectedBy:NSNumber
    var Name :String
    var DepartmentName : String
    var DesignationName : String
    
    init(datas:NSDictionary) {
        self.ID_CollectedBy = datas.value(forKey: "ID_CollectedBy") as? NSNumber ?? 0
        self.Name = datas.value(forKey: "Name") as? String ?? ""
        self.DepartmentName = datas.value(forKey: "DepartmentName") as? String ?? ""
        self.DesignationName = datas.value(forKey: "DesignationName") as? String ?? ""
    }
}

struct SearchByNameOrMobileVM{
    var name : String
    var submode : String
}

//"ID_Customer": 10087,
//                "CusNameTitle": "",
//                "CusName": "Haseena",
//                "CusAddress1": "calicut",
//                "CusAddress2": "",
//                "CusEmail": "",
//                "CusPhnNo": "9846176725",
//                "Company": "RedBee",
//                "CountryID": 10,
//                "CntryName": "INDIA",
//                "StatesID": 1,
//                "StName": "KERALA",
//                "DistrictID": 4,
//                "DtName": "KOZHIKODE",
//                "PostID": 3452,
//                "PostName": "PERAMBRA",
//                "FK_Area": 0,
//                "Area": "",
//                "CusMobileAlternate": "",
//                "Pincode": "123456",
//                "Customer_Type": 1

struct CustomerDetailsInfo<T>:HasValue{
    
    let typeOf = String(describing: T.self)
    
    
    
    
    var value: String { return typeOf is T ? CusName : CusPhnNo  }
    
    var ID_Customer : NSNumber
    var CusNameTitle : String
    var CusName : String
    var CusAddress1 :String
    var CusAddress2 : String
    
    var CusEmail : String
    var CusPhnNo : String
    var Company : String
    var CountryID : NSNumber
    var CntryName : String
    
    var StatesID : NSNumber
    var StName : String
    var DistrictID : NSNumber
    var DtName : String
    var PostID : NSNumber
    
    var PostName : String
    var FK_Area : NSNumber
    var Area : String
    var CusMobileAlternate : String
    var Pincode : String
    
    var Customer_Type : NSNumber
    
    init(datas:NSDictionary){
        
        self.ID_Customer = datas.value(forKey: "ID_Customer") as? NSNumber ?? 0
        self.CusNameTitle = datas.value(forKey: "CusNameTitle") as? String ?? ""
        self.CusName = datas.value(forKey: "CusName") as? String ?? ""
        self.CusAddress1 = datas.value(forKey: "CusAddress1") as? String ?? ""
        self.CusAddress2 = datas.value(forKey: "CusAddress2") as? String ?? ""
        
        
        self.CusEmail = datas.value(forKey: "CusEmail") as? String ?? ""
        self.CusPhnNo = datas.value(forKey: "CusPhnNo") as? String ?? ""
        self.Company = datas.value(forKey: "Company") as? String ?? ""
        self.CountryID = datas.value(forKey: "CountryID") as? NSNumber ?? 0
        self.CntryName = datas.value(forKey: "CntryName") as? String ?? ""
        
        self.StatesID = datas.value(forKey: "StatesID") as? NSNumber ?? 0
        self.StName = datas.value(forKey: "StName") as? String ?? ""
        self.DtName = datas.value(forKey: "DtName") as? String ?? ""
        self.DistrictID = datas.value(forKey: "DistrictID") as? NSNumber ?? 0
        self.PostID = datas.value(forKey: "PostID") as? NSNumber ?? 0
        
    
        
        
        self.PostName = datas.value(forKey: "PostName") as? String ?? ""
        self.Area = datas.value(forKey: "Area") as? String ?? ""
        self.CusMobileAlternate = datas.value(forKey: "CusMobileAlternate") as? String ?? ""
        self.FK_Area = datas.value(forKey: "FK_Area") as? NSNumber ?? 0
        self.Pincode = datas.value(forKey: "Pincode") as? String ?? ""
        
        self.Customer_Type = datas.value(forKey: "Customer_Type") as? NSNumber ?? 0
       
        
    }
    
}

struct SelectedCustomerDetailsInfo{
    var ID_Customer : NSNumber = -1
    var CusNameTitle : String = ""
    var CusName : String?
    var CusAddress1 :String = ""
    var CusAddress2 : String = ""
    
    var CusEmail : String = ""
    var CusPhnNo : String = ""
    var Company : String = ""
    var CountryID : NSNumber = -1
    var CntryName : String = ""
    
    var StatesID : NSNumber  = -1
    var StName : String = ""
    var DistrictID : NSNumber  = -1
    var DtName : String = ""
    var PostID : NSNumber  = -1
    
    var PostName : String = ""
    var FK_Area : NSNumber  = -1
    var Area : String = ""
    var CusMobileAlternate : String
    var Pincode : String = ""
    var whatsapp : String = ""
    var Customer_Type : NSNumber  = -1
}


//"Post": "PERAMBRA",
//                "FK_Post": 3452,
//                "Place": "",
//                "FK_Place": 0,
//                "Area": "KUTTIADI",
//                "FK_Area": 514,
//                "District": "KOZHIKODE",
//                "FK_District": 4,
//                "States": "KERALA",
//                "FK_States": 1,
//                "Country": "INDIA",
//                "FK_Country": 10


struct PincodeDetailsListInfo:HasValue{
    var value: String { return Post }
    
    
    var FK_Post : NSNumber
    var Post : String

    
    var FK_Place : NSNumber
    var Place : String
    
    var FK_Area : NSNumber
    var Area : String
    
    var FK_Country : NSNumber
    var Country : String
    
    var FK_States : NSNumber
    var States : String
    
    var FK_District : NSNumber
    var District : String
    
    init(datas:NSDictionary){
        self.FK_Post = datas.value(forKey: "FK_Post") as? NSNumber ?? -1
        self.Post = datas.value(forKey: "Post") as? String ?? ""
        
        
        self.FK_Place = datas.value(forKey: "FK_Place") as? NSNumber ?? -1
        self.Place = datas.value(forKey: "Place") as? String ?? ""
        
        self.FK_Area = datas.value(forKey: "FK_Area") as? NSNumber ?? -1
        self.Area = datas.value(forKey: "Area") as? String ?? ""
        
        self.FK_Country = datas.value(forKey: "FK_Country") as? NSNumber ?? -1
        self.Country = datas.value(forKey: "Country") as? String ?? ""
        
        self.FK_States = datas.value(forKey: "FK_States") as? NSNumber ?? -1
        self.States = datas.value(forKey: "States") as? String ?? ""
        
        self.FK_District = datas.value(forKey: "FK_District") as? NSNumber ?? -1
        self.District = datas.value(forKey: "District") as? String ?? ""
    }
}

struct StatesDetailsListInfo:HasValue{
    
    var value: String{ return States }
    
    
    
    var FK_States : NSNumber
    var States : String
    init(datas:NSDictionary) {
        self.FK_States = datas.value(forKey: "FK_States") as? NSNumber ?? -1
        self.States = datas.value(forKey: "States") as? String ?? ""
    }
}

struct SelectedCountryDetails{
    var FK_Country : NSNumber
    var Country : String
}


struct DistrictDetailsListInfo:HasValue{
    
    
    var value: String { return District }
    

    var District : String
    var FK_District : NSNumber
    
    init(datas:NSDictionary) {
        self.FK_District = datas.value(forKey: "FK_District") as? NSNumber ?? -1
        self.District = datas.value(forKey: "District") as? String ?? ""
    }
    
    
}


struct AreaDetailsListInfo:HasValue{
    
    
    var value: String { return Area }
    

    var Area : String
    var FK_Area : NSNumber
    
    init(datas:NSDictionary) {
        self.FK_Area = datas.value(forKey: "FK_Area") as? NSNumber ?? -1
        self.Area = datas.value(forKey: "Area") as? String ?? ""
    }
    
    
}



struct PostDetailsListInfo:HasValue{
    
    
    var value: String { return PostName }
    

    var PostName : String
    var PinCode : String
    var FK_Post : NSNumber
    
    init(datas:NSDictionary) {
        self.FK_Post = datas.value(forKey: "FK_Post") as? NSNumber ?? -1
        self.PostName = datas.value(forKey: "PostName") as? String ?? ""
        self.PinCode = datas.value(forKey: "PinCode") as? String ?? ""
    }
    
}



struct CategoryListInfo:HasValue{
    
    
    var value: String { return CategoryName }
    

    var Project : NSNumber
    var CategoryName : String
    var ID_Category : NSNumber
    
    init(datas:NSDictionary) {
        self.Project = datas.value(forKey: "Project") as? NSNumber ?? -1
        self.CategoryName = datas.value(forKey: "CategoryName") as? String ?? ""
        self.ID_Category = datas.value(forKey: "ID_Category") as? NSNumber ?? -1
    }
    
}


struct ProductListInfo:HasValue{
    
    
    var value: String { return ProductName }
    

    var ID_Product : NSNumber
    var ProductName : String
    var ProductCode : NSNumber
    
    init(datas:NSDictionary) {
        self.ID_Product = datas.value(forKey: "ID_Product") as? NSNumber ?? -1
        self.ProductName = datas.value(forKey: "ProductName") as? String ?? ""
        self.ProductCode = datas.value(forKey: "ProductCode") as? NSNumber ?? -1
    }
    
}

struct PriorityListInfo:HasValue{
    
    
    var value: String { return PriorityName }
    

    var PriorityName : String
    var ID_Priority : NSNumber
    
    init(datas:NSDictionary) {
        self.ID_Priority = datas.value(forKey: "ID_Priority") as? NSNumber ?? 0
        self.PriorityName = datas.value(forKey: "PriorityName") as? String ?? ""
    }
    
    
}

struct FollowUpActionDetailsListInfo:HasValue{
    
    
    var value: String { return NxtActnName }
    

    var ID_NextAction : NSNumber
    var NxtActnName : String
    var Status : NSNumber
    
    init(datas:NSDictionary) {
        self.ID_NextAction = datas.value(forKey: "ID_NextAction") as? NSNumber ?? -1
        self.NxtActnName = datas.value(forKey: "NxtActnName") as? String ?? ""
        self.Status = datas.value(forKey: "Status") as? NSNumber ?? -1
    }
    
}

struct FollowUpTypeDetailsListInfo:HasValue {
    
    var value: String{ return ActnTypeName }
    
    var ID_ActionType : NSNumber
    var ActnTypeName : String
    var ActionMode : NSNumber
    
    init(datas:NSDictionary) {
        self.ID_ActionType = datas.value(forKey: "ID_ActionType") as? NSNumber ?? -1
        self.ActnTypeName = datas.value(forKey: "ActnTypeName") as? String ?? ""
        self.ActionMode = datas.value(forKey: "ActionMode") as? NSNumber ?? -1
    }
};

//"ID_Employee": 10058,
//                "EmpName": "Dhanya K",
//                "DepartmentName": "Software Engineer",
//                "DesignationName": "Service Engineer"

struct EmployeeDetailsListInfo:HasValue {
    
    var value: String{ return EmpName }
    
    var ID_Employee : NSNumber
    var EmpName : String
    var DepartmentName : String
    var DesignationName : String
    
    
    init(datas:NSDictionary) {
        self.ID_Employee = datas.value(forKey: "ID_Employee") as? NSNumber ?? -1
        self.EmpName = datas.value(forKey: "EmpName") as? String ?? ""
        self.DepartmentName = datas.value(forKey: "DepartmentName") as? String ?? ""
        self.DesignationName = datas.value(forKey: "DesignationName") as? String ?? ""
        
    }
};


struct SelectedProductDetailsInfo{
    var Project : NSNumber?
    var CategoryName : String?
    var ID_Category : NSNumber?
    var ModelString : String?
    var ID_Product : NSNumber?
    var ProductName : String?
    var quantity : String?
    var ProductCode : NSNumber?
    var PriorityName : String?
    var ID_Priority : NSNumber?
    var EnquiryText : String?
    var Status : NSNumber?
    var ID_NextAction : NSNumber?
    var NxtActnName : String?
    var ID_ActionType : NSNumber?
    var ActnTypeName : String?
    var ActionMode : NSNumber?
    var date:String?
    var ID_Employee : NSNumber?
    var EmpName : String?
    var DepartmentName : String?
    var DesignationName : String?
    
}


struct LeadConfirmationDetails{
    var sectionTitle:String
    var row:[LeadConfirmDataRow]
}



struct LeadConfirmDataRow{
    var name:String
    var details:String
}



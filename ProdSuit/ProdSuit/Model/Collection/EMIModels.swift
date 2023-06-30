//
//  EMIModels.swift
//  ProdSuit
//
//  Created by MacBook on 16/06/23.
//

import Foundation
import UIKit


struct FilterEmiReportCount{
    var FK_FinancePlanType  : String = "0"
    var FK_Product  : NSNumber = 0
    var FK_Area  : NSNumber = 0
    var FK_Category  : NSNumber = 0
    

}

struct EMIReportParamModel{
       var fromDateString:String
       var toDateString:String
       var demandString:String
       var submode:String
       var filterdInfo : FilterEmiReportCount
}

struct EMICollectionReportCountModel{
    var ToDoList : NSNumber
    var OverDue : NSNumber
    var Upcoming : NSNumber
    init(datas:NSDictionary) {
        self.ToDoList = datas.value(forKey: "ToDoList") as? NSNumber ?? 0
        self.OverDue = datas.value(forKey: "OverDue") as? NSNumber ?? 0
        self.Upcoming = datas.value(forKey: "Upcoming") as? NSNumber ?? 0
    }
}

struct FinancePlanTypeDetailsModel:HasValue{
    
    var FinanceName:String
    var ID_FinancePlanType : String
    var value: String { return FinanceName}
    
    init(datas:NSDictionary) {
        self.FinanceName = datas.value(forKey: "FinanceName") as? String ?? ""
        self.ID_FinancePlanType = datas.value(forKey: "ID_FinancePlanType") as? String ?? "0"
    }
}

struct EMICollectionReportModel{

    let iD_CustomerWiseEMI : String
    let eMINo : String
    let customer : String
    let mobile : String
    let product : String
    let financePlan : String
    let lastTransaction : String
    let dueAmount : String
    let fineAmount : String
    let balance : String
    let dueDate : String
    let nextEMIDate : String
    let instNo : String
    let area : String
    let fK_Area : String
    
    init(datas:NSDictionary) {
        
        
        self.iD_CustomerWiseEMI = datas.value(forKey:"ID_CustomerWiseEMI") as? String ?? ""
        
        self.eMINo = datas.value(forKey:"EMINo") as? String ?? ""
        
        self.customer = datas.value(forKey:"Customer") as? String ?? ""
        
        self.product = datas.value(forKey:"Product") as? String ?? ""
        
        self.mobile = datas.value(forKey:"Mobile") as? String ?? ""
        
        self.financePlan = datas.value(forKey:"FinancePlan") as? String ?? ""
        
        self.fineAmount = datas.value(forKey:"FineAmount") as? String ?? ""
        
        self.lastTransaction = datas.value(forKey:"LastTransaction") as? String ?? ""
        
        self.dueAmount = datas.value(forKey:"DueAmount") as? String ?? ""
        
        self.dueDate = datas.value(forKey:"DueDate") as? String ?? ""
        
        self.instNo = datas.value(forKey:"InstNo") as? String ?? ""
        
        self.balance = datas.value(forKey:"Balance") as? String ?? ""
        
        self.nextEMIDate = datas.value(forKey:"NextEMIDate") as? String ?? ""
        
        self.fK_Area = datas.value(forKey:"FK_Area") as? String ?? ""
        
        self.area = datas.value(forKey:"Area") as? String ?? ""
    }
}

struct FollowUpPaymentMethodModel:HasValue{
    var value: String { return paymentName }
    
    let id_PaymentMethod : NSNumber
    let paymentName : String
    init(datas:NSDictionary) {
        
        
        self.id_PaymentMethod = datas.value(forKey:"ID_PaymentMethod") as? NSNumber ?? 0
        
        self.paymentName = datas.value(forKey:"PaymentName") as? String ?? ""

    }
}

struct EMIAccountDetailsModel{
    var CustomerInformationList:[EmiCustomerInformationModel]=[]
    var EMIAccountDetailsList:[EmiEMIAccountDetailsModel] = []
    
    init(datas:NSDictionary) {
        let customerInfoList = datas.value(forKey: "CustomerInformationList") as? [NSDictionary] ?? []
        let emiAccountDetailsList = datas.value(forKey: "EMIAccountDetailsList") as? [NSDictionary] ?? []
        self.CustomerInformationList = []
        self.CustomerInformationList = customerInfoList.map{ EmiCustomerInformationModel(datas: $0) }
        
        self.EMIAccountDetailsList = []
        self.EMIAccountDetailsList = emiAccountDetailsList.map{ EmiEMIAccountDetailsModel(datas: $0) }
        
        
        
    }
}

struct EmiCustomerInformationModel{
    
    var id_Customer : String
    var id_CustomerWiseEMI: String
    var cusName: String
    var mobile : String
    var address : String
    
    init(datas:NSDictionary) {
        
        self.id_Customer = datas.value(forKey: "ID_Customer") as? String ?? "0"
        self.id_CustomerWiseEMI = datas.value(forKey: "ID_CustomerWiseEMI") as? String ?? "0"
        self.cusName = datas.value(forKey: "CusName") as? String ?? ""
        self.mobile = datas.value(forKey: "Mobile") as? String ?? ""
        self.address = datas.value(forKey: "Address") as? String ?? ""
        
    }
}


struct EmiEMIAccountDetailsModel{
    
    var fk_customerWiseEMI : String
    var billDate : String
    var emiNo : String
    var product : String
    var amount : String
    var fine : String
    var balance : String
    var fk_FinancePlanType : String
    
    init(datas:NSDictionary) {
        
        self.fk_customerWiseEMI = datas.value(forKey: "FK_CustomerWiseEMI") as? String ?? "0"
        self.billDate = datas.value(forKey: "BillDate") as? String ?? ""
        self.emiNo = datas.value(forKey: "EMINo") as? String ?? ""
        self.product = datas.value(forKey: "Product") as? String ?? ""
        self.amount = datas.value(forKey: "Amount") as? String ?? ""
        
        self.fine = datas.value(forKey: "Fine") as? String ?? "0.00"
        self.balance = datas.value(forKey: "Balance") as? String ?? "0.00"
        self.fk_FinancePlanType = datas.value(forKey: "FK_FinancePlanType") as? String ?? "0"
        
    }
}

struct PaymentParmaInfoModel{
    var transdate:String
    var collectdate:String
    var accountmode:String = "2"
    var id_customerwiseEMI:String
    var totalamount:String
    var fineamount:String
    var netamount:String
    var emi_details:PaymentParamEmiDetailsModel
    var paymentDetailsList:[PaymentParamPaymentDetailsModel]
    var location_lat:String
    var location_long:String
    var location_name:String
    var location_enteredTime:String
}

struct PaymentParamEmiDetailsModel{
    var fk_CustomerWiseEMI:String
    var cusTrDetPayAmount:String
    var cusTrDetFineAmount:String
    var total:String
    var balance:String
    var fk_Closed:String
}

struct PaymentParamPaymentDetailsModel{
    var paymentMethod:String
    var pamount:String
    var refno:String
}

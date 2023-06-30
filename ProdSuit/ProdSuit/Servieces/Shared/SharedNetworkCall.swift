//
//  SharedNetworkCall.swift
//  ProdSuit
//
//  Created by MacBook on 01/06/23.
//

import Foundation
import Combine
import UIKit

protocol SharedNetworkApiDelegate:AnyObject {
    
    var parserVm:GlobalAPIViewModel! { get set }
    var apiParserVm :  APIParserManager! { get set }
    
}

class SharedNetworkCall:SharedNetworkApiDelegate{
    
    lazy var viewModelVc : UIViewController = {
       let vc = UIViewController()
        return vc
    }()
    
    var apiParserVm: APIParserManager!

    var parserVm: GlobalAPIViewModel!
    var collectionAPIManager:CollectionAPIManager?
    var leadMangeAPIManager:LMAPIManager?
    
    
   
    
    
    static var Shared = SharedNetworkCall()
    
     private init(){
         
        
        apiParserVm = APIParserManager()
        parserVm = GlobalAPIViewModel(bgView: viewModelVc.view)
        
        self.collectionAPIManager = CollectionAPIManager()
        self.leadMangeAPIManager = LMAPIManager()
    }
    
   
    
    
    
    
    
    
    //================ 
}


class LMAPIManager:SharedNetworkApiDelegate{
    
    lazy var viewModelVc : UIViewController = {
       let vc = UIViewController()
        return vc
    }()
    
    var apiParserVm: APIParserManager!

    var parserVm: GlobalAPIViewModel!
    
    lazy var statusCancellable = Set<AnyCancellable>()
    lazy var emplyeeDetailsCancellable = Set<AnyCancellable>()
    lazy var walkInAssignedCancellable = Set<AnyCancellable>()
    lazy var wcUpdateCancellable = Set<AnyCancellable>()
    lazy var actionCancellable = Set<AnyCancellable>()
    lazy var priorityCancellable = Set<AnyCancellable>()
    lazy var departmentCancellable = Set<AnyCancellable>()
    lazy var saveDataCancellable = Set<AnyCancellable>()
    
    
    init(){
        apiParserVm = APIParserManager()
        parserVm = GlobalAPIViewModel(bgView: viewModelVc.view)
    }
    
    func saveFollowUpdateLeadManagementUpDetails(actionType:String,info:FollowUpParamValidation,_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        
          let userAction = "1"
          let transMode = "ERP"
          let iD_LeadGenerate = info.id_LeadGenerate
          let iD_LeadGenerateProduct = info.id_LeadGenerateProduct
        
        
          let lgActMode = actionType
          let iD_FollowUpBy = info.followUPby
          let actStatus = "\(info.statusId)"
          let trnsDate = DateTimeModel.shared.formattedDateFromString(dateString: info.date)
          let customerNote  = info.customerRemark
        
          let employeeNote = info.employeeRemark
          let fK_Action = info.nextActionID
          let fK_ActionType = info.nextActionTypeID
          let nextActionDate = DateTimeModel.shared.formattedDateFromString(dateString: info.nextActionFollowUpdate)
          let fK_Priority = info.nextActionPriorityID
         
        
          let fK_ToEmployee = info.employee_ID
          let fetchTime = DateTimeModel.shared.fetchTime()
          
          let lgFollowUpTime = fetchTime
          let lgFollowUpStatus = info.callStatusId
          let lgFollowupDuration = "00:00:00"
          let locLatitude = "\(info.coordinates.lat)"
          let locLongitude = "\(info.coordinates.lon)"
          let locationLandMark1 = info.uploadImageOne
          let locationLandMark2 = info.uploadImageTwo
          
        if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let eentrBy = instanceOfEncryptionPost.encryptUseDES(entrBy, key: SKey),
           let efk_branchCodeUser = instanceOfEncryptionPost.encryptUseDES(fk_branchCodeUser, key: SKey),
           
           let efk_department = instanceOfEncryptionPost.encryptUseDES(fk_department, key: SKey),
           let euserAction = instanceOfEncryptionPost.encryptUseDES(userAction, key: SKey),
           let etransMode = instanceOfEncryptionPost.encryptUseDES(transMode, key: SKey),
           let eiD_LeadGenerate = instanceOfEncryptionPost.encryptUseDES(iD_LeadGenerate, key: SKey),
           let eiD_LeadGenerateProduct = instanceOfEncryptionPost.encryptUseDES(iD_LeadGenerateProduct, key: SKey),
           
           let elgActMode = instanceOfEncryptionPost.encryptUseDES(lgActMode, key: SKey),
           
           let eiD_FollowUpBy = instanceOfEncryptionPost.encryptUseDES(iD_FollowUpBy, key: SKey),
           let eactStatus = instanceOfEncryptionPost.encryptUseDES(actStatus, key: SKey),
           let etrnsDate = instanceOfEncryptionPost.encryptUseDES(trnsDate, key: SKey),
           let ecustomerNote = instanceOfEncryptionPost.encryptUseDES(customerNote, key: SKey),
        
            let eemployeeNote = instanceOfEncryptionPost.encryptUseDES(employeeNote, key: SKey),
           let efK_Action = instanceOfEncryptionPost.encryptUseDES(fK_Action, key: SKey),
           let efK_ActionType = instanceOfEncryptionPost.encryptUseDES(fK_ActionType, key: SKey),
           let enextActionDate = instanceOfEncryptionPost.encryptUseDES(nextActionDate, key: SKey),
           let efK_Priority = instanceOfEncryptionPost.encryptUseDES(fK_Priority, key: SKey),
            
            
            let efK_ToEmployee = instanceOfEncryptionPost.encryptUseDES(fK_ToEmployee, key: SKey),
            let elgFollowUpStatus = instanceOfEncryptionPost.encryptUseDES(lgFollowUpStatus, key: SKey),
           let elgFollowUpTime = instanceOfEncryptionPost.encryptUseDES(lgFollowUpTime, key: SKey),
           let elgFollowupDuration = instanceOfEncryptionPost.encryptUseDES(lgFollowupDuration, key: SKey),
           let elocLatitude = instanceOfEncryptionPost.encryptUseDES(locLatitude, key: SKey),
           let elocLongitude = instanceOfEncryptionPost.encryptUseDES(locLongitude, key: SKey),
           let elocationLandMark1 = instanceOfEncryptionPost.encryptUseDES(locationLandMark1, key: SKey),
           let elocationLandMark2 = instanceOfEncryptionPost.encryptUseDES(locationLandMark2, key: SKey)
        {
            
            
            let arguments = ["BankKey": ebankKey,
                             "FK_Employee": efk_employee ,
                             "Token": etoken ,
                             "UserAction": euserAction,
                             "TransMode": etransMode,
                             "FK_Company": efk_company,
                             "FK_BranchCodeUser": efk_branchCodeUser ,
                             "EntrBy": eentrBy ,
                             "ID_LeadGenerate": eiD_LeadGenerate,
                             "ID_LeadGenerateProduct": eiD_LeadGenerateProduct,
                             "LgActMode": elgActMode,
                             "ID_FollowUpBy": eiD_FollowUpBy,
                             "ActStatus": eactStatus,
                             "TrnsDate": etrnsDate,
                             "CustomerNote": ecustomerNote,
                             "EmployeeNote": eemployeeNote,
                             "FK_Action": efK_Action,
                             "FK_ActionType": efK_ActionType,
                             "NextActionDate": enextActionDate,
                             "FK_Priority": efK_Priority,
                             "FK_Departement": efk_department ,
                             "FK_ToEmployee": efK_ToEmployee,
                             "LgFollowUpTime": elgFollowUpTime,
                             "LgFollowUpStatus": elgFollowUpStatus,
                             "LgFollowupDuration": elgFollowupDuration,
                             "LocLatitude": elocLatitude,
                             "LocLongitude": elocLongitude,
                             "LocationLandMark1": locationLandMark1,
                             "LocationLandMark2": locationLandMark2]
            
            
            let request = apiParserVm.request(urlPath: URLPathList.Shared.fd_UpdateLeadManagement,arguMents: arguments)
            self.parserVm.modelInfoKey = "UpdateLeadManagement"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    self.parserVm.progressBar.hideIndicator()
                     completionHandler(responseHandler)
                     self.saveDataCancellable.dispose()
                }.store(in: &saveDataCancellable)
        
        }
          
        
          
    }
    
    // ED-54
    func employeeDetails_APICall(_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        let requestMode = RequestMode.shared.fd_followUpBy
        let bankKey = preference.appBankKey
        let fk_company = "\(preference.User_FK_Company)"
        let token = preference.User_Token
        let ID_Department = "\(preference.User_FK_DepartMent)"
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let eID_Department = instanceOfEncryptionPost.encryptUseDES(ID_Department, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"FK_Company":efk_company,"Token":etoken,"ID_Department":eID_Department]
            
            let request = self.apiParserVm.request(urlPath: URLPathList.Shared.fd_FollowUpBy, arguMents: arguMents)
            self.parserVm.modelInfoKey = "EmployeeDetails"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    self.parserVm.progressBar.hideIndicator()
                   
                      completionHandler(responseHandler)
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    self.emplyeeDetailsCancellable.dispose()
                }.store(in: &emplyeeDetailsCancellable)
            
            
        }
    }
    
    //WICAC-259313
    //MARK: - Walk_in_customer_APICall
    func walk_in_customer_APICall(_ requestMode:String,_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        
        
        let requestMode = requestMode
        let bankKey = preference.appBankKey
        let fk_company = "\(preference.User_FK_Company)"
        let token = preference.User_Token
        
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"FK_Company":efk_company,"Token":etoken]
            
            let request = self.apiParserVm.request(urlPath: URLPathList.Shared.walkInCustomer, arguMents: arguMents)
            self.parserVm.modelInfoKey = "EmployeeDetails"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    self.parserVm.progressBar.hideIndicator()
                   
                      completionHandler(responseHandler)
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    self.walkInAssignedCancellable.dispose()
                }.store(in: &walkInAssignedCancellable)
            
            
        }
        
    }
    
    func walk_in_customer_Updation( id_CustomerAssignment:String,name:String,mobile:String,date:String,description:String,_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        
        
        
        let bankKey = preference.appBankKey
        let fk_company = "\(preference.User_FK_Company)"
        let token = preference.User_Token
        let userAction = "1"
        let TransMode = ""
        let fK_Employee = "\(preference.User_Fk_Employee)"
        let entrBy = preference.User_UserCode
        let fk_branchCodeUser = "\(preference.User_FK_BranchCodeUser)"
        let formattedDate = DateTimeModel.shared.formattedDateFromString(dateString: date)
        
        
        if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let eUserAction = instanceOfEncryptionPost.encryptUseDES(userAction, key: SKey),
           let eTransMode = instanceOfEncryptionPost.encryptUseDES(TransMode, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fK_Employee, key: SKey),
           
            let eentrBy = instanceOfEncryptionPost.encryptUseDES(entrBy, key: SKey),
           
            let efk_branchCodeUser = instanceOfEncryptionPost.encryptUseDES(fk_branchCodeUser, key: SKey),
           
           let eid_CustomerAssignment = instanceOfEncryptionPost.encryptUseDES(id_CustomerAssignment, key: SKey),
           
            let eName = instanceOfEncryptionPost.encryptUseDES(name, key: SKey),
            
            let eMobile = instanceOfEncryptionPost.encryptUseDES(mobile, key: SKey),
           
            let eDate = instanceOfEncryptionPost.encryptUseDES(formattedDate, key: SKey),
           
            let eDescription = instanceOfEncryptionPost.encryptUseDES(description, key: SKey),
            
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey){
            
            let arguMents = ["BankKey":ebankKey,"FK_Company":efk_company,"Token":etoken,"UserAction":"\(eUserAction)","TransMode":eTransMode,"ID_CustomerAssignment":eid_CustomerAssignment,"CusName":eName,"CusMobile":eMobile,"CaAssignedDate":eDate,"CaDescription":eDescription,"FK_Employee":efk_employee,"FK_BranchCodeUser":efk_branchCodeUser,"EntrBy":eentrBy]
            
            let request = self.apiParserVm.request(urlPath: URLPathList.Shared.walkInCustomerUpdation, arguMents: arguMents)
            self.parserVm.modelInfoKey = ""
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    self.parserVm.progressBar.hideIndicator()
                   
                      completionHandler(responseHandler)
                    
                    self.wcUpdateCancellable.dispose()
                }.store(in: &wcUpdateCancellable)
            
            
        }
    }
    
    //FUCSAC-6313
    //FUSAC-613
    //FollowUp Status Api call
    func status_ApiCall(_ requestMode:String,_ completionHandler:@escaping ((successErrorHandler) -> Void)) {
        let requestMode = requestMode
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        //let fk_company = "\(preference.User_FK_Company)"
    
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           //let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey)
             {
           let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee]
           
            let request = apiParserVm.request(urlPath: URLPathList.Shared.fd_FollowUpStatus,arguMents: arguMents)
            
            self.parserVm.modelInfoKey = "StatusDetailsList"
            
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    self.parserVm.progressBar.hideIndicator()
                   
                      completionHandler(responseHandler)
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    self.statusCancellable.dispose()
                }.store(in: &statusCancellable)
            
            
        }
    }
    
    // NAAL-1112
    // NEXT ACTION ACTION LISTING
    func nextActionActionListingAPICall(_ requestMode:String,_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        let requestMode = requestMode
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let subMode = SubMode.Shared.leadFollowUpAction
        let fk_company = "\(preference.User_FK_Company)"
    
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
            let esubMode = instanceOfEncryptionPost.encryptUseDES(subMode, key: SKey){
           let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company,"SubMode":esubMode]
           
            let request = apiParserVm.request(urlPath: URLPathList.Shared.fd_Action,arguMents: arguMents)
            
            self.parserVm.modelInfoKey = "FollowUpActionDetails"
            
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    
                    
                    //print(responseHandler.info)
                    
                    completionHandler(responseHandler)
                    
                    self.actionCancellable.dispose()
                    
                }.store(in: &actionCancellable)
          }
    }
    
    // NAPL-1411
    //MARK: - ========= prioriyAPICall() =============
    func nextActionPriorityListingAPICall(_ requestMode:String,_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        let requestMode = requestMode
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        
        let fk_company = "\(preference.User_FK_Company)"
        
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           
            let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company]
            
            let request = self.apiParserVm.request(urlPath: URLPathList.Shared.leadPriority,arguMents: arguMents)
            self.parserVm.modelInfoKey = "PriorityDetailsList"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    
                    self.parserVm.progressBar.hideIndicator()
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                   completionHandler(responseHandler)
                    
                    self.priorityCancellable.dispose()
                }.store(in: &priorityCancellable)
        }
    }
    
    // NADL-141412
    //MARK: - ========= nextActionDepartmentListingAPICall() =============
    func nextActionDepartmentListingAPICall(_ requestMode:String,_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        let requestMode = requestMode
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        
        let fk_company = "\(preference.User_FK_Company)"
        
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           
            let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company]
            
            let request = self.apiParserVm.request(urlPath: URLPathList.Shared.fd_Department,arguMents: arguMents)
            self.parserVm.modelInfoKey = "DepartmentDetails"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    self.parserVm.progressBar.hideIndicator()

                    completionHandler(responseHandler)
                    self.departmentCancellable.dispose()
                }.store(in: &departmentCancellable)
            
        }
        
    }
    
}


class CollectionAPIManager:SharedNetworkApiDelegate{
    
    lazy var viewModelVc : UIViewController = {
       let vc = UIViewController()
        return vc
    }()
    
    
    var apiParserVm: APIParserManager!

    var parserVm: GlobalAPIViewModel!
    
    lazy var emiCRCCancellable = Set<AnyCancellable>()
    lazy var EMICServiceCancellable = Set<AnyCancellable>()
    
    init(){
        apiParserVm = APIParserManager()
        parserVm = GlobalAPIViewModel(bgView: viewModelVc.view)
    }
   
    //MARK: - commonAPIServiecCall()
    func commonAPIServiecCall(path:String,arguments:[String:String],showActivityIndicator:Bool=true,modelInfoKey:String="",_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        let request = apiParserVm.request(urlPath: path,arguMents: arguments)
        self.parserVm.modelInfoKey = modelInfoKey
        if showActivityIndicator == true{
        self.parserVm.progressBar.showIndicator()
        }
        self.parserVm.parseApiRequest(request)
        self.parserVm.$responseHandler
            .dropFirst()
            .sink { responseHandler in
            if showActivityIndicator == true{
                self.parserVm.progressBar.hideIndicator()
            }
            completionHandler(responseHandler)
            self.EMICServiceCancellable.dispose()
        }.store(in: &EMICServiceCancellable)
    }
    
    //MARK:- emiCollectionReportCountAPICall()
    func emiCollectionReportCountAPICall(hasFilter:Bool=false,filterParam:FilterEmiReportCount?,_ fromDate:String,_ toDate:String,Demand:String="30",_ completionHandler:@escaping ((successErrorHandler) -> Void)){

        let apiPath = URLPathList.Shared.emiCRC

        let fromDatString = DateTimeModel.shared.formattedDateFromString(dateString: fromDate)
        let toDateString = DateTimeModel.shared.formattedDateFromString(dateString: toDate)
        let demand = Demand
        
        if let efromDatString = instanceOfEncryptionPost.encryptUseDES(fromDatString, key: SKey),
           let etoDateString = instanceOfEncryptionPost.encryptUseDES(toDateString, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
              
              let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
              let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
              let eentrBy = instanceOfEncryptionPost.encryptUseDES(entrBy, key: SKey),
              let efk_branch = instanceOfEncryptionPost.encryptUseDES(fk_branch, key: SKey),
              let efk_branchCodeUser = instanceOfEncryptionPost.encryptUseDES(fk_branchCodeUser, key: SKey),
             let edemand = instanceOfEncryptionPost.encryptUseDES(demand, key: SKey){
            
           
            
           
            
            var arguments = ["BankKey":ebankKey,"Token":etoken,"ReqMode":RequestMode.shared.emiCRC,"FK_Company":efk_company,"FK_BranchCodeUser":efk_branchCodeUser,"EntrBy":eentrBy,"FK_Branch":efk_branch,"FromDate":efromDatString,"ToDate":etoDateString,"Demand":edemand]
            
            
            
            if hasFilter == true{
                if let param = filterParam{
                    arguments.updateValue("\(param.FK_FinancePlanType)", forKey: "FK_FinancePlanType")
                    arguments.updateValue("\(param.FK_Product)", forKey: "FK_Product")
                    arguments.updateValue("\(param.FK_Area)", forKey: "FK_Area")
                    arguments.updateValue("\(param.FK_Category)", forKey: "FK_Category")
                }
            }
            
            
            self.commonAPIServiecCall(path: apiPath, arguments: arguments, showActivityIndicator: true, modelInfoKey: "EMICollectionReportCount") { responseHandler in
                completionHandler(responseHandler)
            }
        
        }
        
    }
    
    
    //MARK:- emiFinancePlanTypeAPICall()
    func emiFinancePlanTypeAPICall(_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        
        let apiPath = URLPathList.Shared.emiFinanceType
        let requestMode = RequestMode.shared.emiFPT
        if let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey){
            let arguments = ["BankKey":ebankKey,"Token":etoken,"ReqMode":erequestMode,"FK_Company":efk_company]
            self.commonAPIServiecCall(path: apiPath, arguments: arguments, showActivityIndicator: true, modelInfoKey: "FinancePlanTypeDetails") { responseHandler in
                completionHandler(responseHandler)
            }}}
    
    //MARK:- emiCategoryAPICall()
    func emiCategoryAPICall(_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        
        let apiPath = URLPathList.Shared.leadCategory
        let requestMode = RequestMode.shared.LeadCategory
        if let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey){
            let arguments = ["BankKey":ebankKey,"Token":etoken,"ReqMode":erequestMode,"FK_Company":efk_company,"FK_Employee":efk_employee]
            self.commonAPIServiecCall(path: apiPath, arguments: arguments, showActivityIndicator: true, modelInfoKey: "CategoryDetailsList") { responseHandler in
                completionHandler(responseHandler)
            }}}
    
    
    //MARK:- emiAreaAPICall()
    func emiAreaAPICall(_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        
        let apiPath = URLPathList.Shared.leadAreaDetails
        let requestMode = RequestMode.shared.LeadAreaDetails
        let subMode = SubMode.Shared.leadArea
        if let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let esubMode = instanceOfEncryptionPost.encryptUseDES(subMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey){
            let arguments = ["BankKey":ebankKey,"Token":etoken,"ReqMode":erequestMode,"FK_Company":efk_company,"FK_Employee":efk_employee,"SubMode":esubMode]
            self.commonAPIServiecCall(path: apiPath, arguments: arguments, showActivityIndicator: true, modelInfoKey: "AreaDetails") { responseHandler in
                completionHandler(responseHandler)
            }}}
    
    
    //MARK:- collectionEMIReportAPICall()
    func collectionEMIReportAPICall(details:EMIReportParamModel,_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        
        
        let apiPath = URLPathList.Shared.emiReport

        let fromDatString = DateTimeModel.shared.formattedDateFromString(dateString: details.fromDateString)
        let toDateString = DateTimeModel.shared.formattedDateFromString(dateString: details.toDateString)
        let demand = details.demandString
        let subMode = details.submode
        
        
        if let efromDatString = instanceOfEncryptionPost.encryptUseDES(fromDatString, key: SKey),
           let etoDateString = instanceOfEncryptionPost.encryptUseDES(toDateString, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
              
              let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
              let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
              let eentrBy = instanceOfEncryptionPost.encryptUseDES(entrBy, key: SKey),
              let efk_branch = instanceOfEncryptionPost.encryptUseDES(fk_branch, key: SKey),
              let efk_branchCodeUser = instanceOfEncryptionPost.encryptUseDES(fk_branchCodeUser, key: SKey),
             let edemand = instanceOfEncryptionPost.encryptUseDES(demand, key: SKey),
             let esubMode = instanceOfEncryptionPost.encryptUseDES(subMode, key: SKey) {
            
            
            
            
    
            var arguments = ["BankKey":ebankKey,"Token":etoken,"ReqMode":RequestMode.shared.emiCRC,"FK_Company":efk_company,"FK_BranchCodeUser":efk_branchCodeUser,"EntrBy":eentrBy,"FK_Branch":efk_branch,"FromDate":efromDatString,"ToDate":etoDateString,"Demand":edemand,"SubMode":esubMode]
            
           
                 let info = details.filterdInfo
                arguments.updateValue(info.FK_FinancePlanType, forKey: "FK_FinancePlanType")
                arguments.updateValue("\(info.FK_Product)", forKey: "FK_Product")
                arguments.updateValue("\(info.FK_Area)", forKey: "FK_Area")
                arguments.updateValue("\(info.FK_Category)", forKey: "FK_Category")
            
            
            
            self.commonAPIServiecCall(path: apiPath, arguments: arguments, showActivityIndicator: true, modelInfoKey: "EMICollectionReport") { responseHandler in
                completionHandler(responseHandler)
            }}
        
    }
    
    func employeeListDetailsAPICall(_ requestMode:String,_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        let requestMode = requestMode //RequestMode.shared.emiET
        let bankKey = preference.appBankKey
        let fk_company = "\(preference.User_FK_Company)"
        let token = preference.User_Token
        let apiPath = URLPathList.Shared.emiEmployee
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"FK_Company":efk_company,"Token":etoken]
            
            self.commonAPIServiecCall(path: apiPath, arguments: arguMents, showActivityIndicator: true, modelInfoKey: "EmployeeDetails") { responseHandler in
                completionHandler(responseHandler)
            }
        }
    }
    
    
    //MARK: - paymentMethodAPICall()
    func paymentMethodAPICall(_ requestMode:String=RequestMode.shared.paymentMethod,_ completionHandler:@escaping ((successErrorHandler) -> Void)){
       
        let apiPath = URLPathList.Shared.PaymentMethod
        if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
              let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
              let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
              let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
              let eentrBy = instanceOfEncryptionPost.encryptUseDES(entrBy, key: SKey),
              let efk_branchCodeUser = instanceOfEncryptionPost.encryptUseDES(fk_branchCodeUser, key: SKey){
             
            let arguments = ["BankKey":ebankKey,"Token":etoken,"ReqMode":erequestMode,"FK_Company":efk_company,"FK_BranchCodeUser":efk_branchCodeUser,"EntrBy":eentrBy]
            
            self.commonAPIServiecCall(path: apiPath, arguments: arguments, showActivityIndicator: true, modelInfoKey: "FollowUpPaymentMethod") { responseHandler in
                completionHandler(responseHandler)
            }
    
        }
    }
    
    //MARK: - emiAccountCustomerDetailsAPICall()
    func emiAccountCustomerDetailsAPICall(_ requestMode:String=RequestMode.shared.emiRCI ,transDate:String,model:EMICollectionReportModel,_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        
        let apiPath = URLPathList.Shared.emiAccount_customerDetails
        let transDateFormate = DateTimeModel.shared.formattedDateFromString(dateString: transDate)
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let etransDate = instanceOfEncryptionPost.encryptUseDES(transDateFormate, key: SKey),
           let eAccountMode = instanceOfEncryptionPost.encryptUseDES("2", key: SKey),
           let eid_CustomerWiseEMI = instanceOfEncryptionPost.encryptUseDES(model.iD_CustomerWiseEMI, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
            let arguments = ["BankKey":ebankKey,"Token":etoken,"ReqMode":erequestMode,"ID_CustomerWiseEMI":eid_CustomerWiseEMI,"TrnsDate":etransDate,"FK_Company":efk_company,"AccountMode":eAccountMode]
            
            self.commonAPIServiecCall(path: apiPath, arguments: arguments, showActivityIndicator: true, modelInfoKey: "EMIAccountDetails") { responseHandler in
                completionHandler(responseHandler)
            
        }
     }
   }
    //MARK: - UPDATE EMAI COLLECTION()
    func updateEMICollection(info:PaymentParmaInfoModel,_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        
        let transDateFormate = DateTimeModel.shared.formattedDateFromString(dateString: info.transdate)
        
        let collectDateFormate = DateTimeModel.shared.formattedDateFromString(dateString: info.collectdate)
        
        let locationDate = DateTimeModel.shared.formattedDateFromString(dateString: currentDateString)
        
        
        var emiListInfo : [[String:String]] = [[String:String]]()
        
          let emidetails = ["FK_CustomerWiseEMI":info.emi_details.fk_CustomerWiseEMI,"CusTrDetPayAmount":info.emi_details.cusTrDetPayAmount,"CusTrDetFineAmount":info.emi_details.cusTrDetFineAmount,"Total":info.emi_details.total,"Balance":info.emi_details.balance,"FK_Closed":info.emi_details.fk_Closed]
        
        
           emiListInfo.append(emidetails)
        
        let emiDetailString = convertToJsonArray(list: emiListInfo)
        
                    
        
        var paymentListInfo:[[String:String]] = [[String:String]]()
      
        for payment in info.paymentDetailsList{
            paymentListInfo.append(["PaymentMethod":payment.paymentMethod,"PAmount":payment.pamount,"Refno":payment.refno])
        }
        
        let paymentMethodInfoString = convertToJsonArray(list: paymentListInfo)
        
        let apiPath = URLPathList.Shared.emiUpdate
        
        
        if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let etransDate = instanceOfEncryptionPost.encryptUseDES(transDateFormate, key: SKey),
           let ecollectDate = instanceOfEncryptionPost.encryptUseDES(collectDateFormate, key: SKey),
           let eFK_Company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let efk_branchCodeUser = instanceOfEncryptionPost.encryptUseDES(fk_branchCodeUser, key: SKey),
           let eentrBy = instanceOfEncryptionPost.encryptUseDES(entrBy, key: SKey),
           let eAccountMode = instanceOfEncryptionPost.encryptUseDES(info.accountmode, key: SKey),
           let eid_CustomerWiseEMI = instanceOfEncryptionPost.encryptUseDES(info.id_customerwiseEMI, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let elatitude = instanceOfEncryptionPost.encryptUseDES(info.location_lat, key: SKey),
            let elongitude = instanceOfEncryptionPost.encryptUseDES(info.location_long, key: SKey),
            let elocationName = instanceOfEncryptionPost.encryptUseDES(info.location_name, key: SKey),
           let elocationtime = instanceOfEncryptionPost.encryptUseDES(info.location_enteredTime, key: SKey),
           let elocationdate = instanceOfEncryptionPost.encryptUseDES(locationDate, key: SKey),
           let eTotalAmount = instanceOfEncryptionPost.encryptUseDES(info.totalamount, key: SKey),
           let eFineAmount = instanceOfEncryptionPost.encryptUseDES(info.fineamount, key: SKey),
           let eNetAmount = instanceOfEncryptionPost.encryptUseDES(info.netamount, key: SKey),
           let eemiDetails = instanceOfEncryptionPost.encryptUseDES(emiDetailString, key: SKey),
           let epaymentMethodInfo = instanceOfEncryptionPost.encryptUseDES(paymentMethodInfoString, key: SKey)
           
           
               {
                
            let arguments:[String:String] = ["BankKey":ebankKey,"Token":etoken,"TrnsDate":etransDate,"FK_Company":eFK_Company,"FK_BranchCodeUser":efk_branchCodeUser,"EntrBy":eentrBy,"AccountMode":eAccountMode,"ID_CustomerWiseEMI":eid_CustomerWiseEMI,"CollectDate":ecollectDate,"FK_Employee":efk_employee,"TotalAmount":eTotalAmount,"FineAmount":eFineAmount,"NetAmount":eNetAmount,"EMIDetails":eemiDetails,"PaymentDetail":epaymentMethodInfo,"LocLatitude":elatitude,"LocLongitude":elongitude,"Address":elocationName,"LocationEnteredDate":elocationdate,"LocationEnteredTime":elocationtime]
               
             
            self.commonAPIServiecCall(path: apiPath, arguments: arguments, showActivityIndicator: true, modelInfoKey: "UpdateEMICollection") { responseHandler in
                completionHandler(responseHandler)
        }}
        
    }
    
}

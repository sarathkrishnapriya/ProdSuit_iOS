//
//  LeadManageMentViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 08/05/23.
//

import Foundation
import UIKit
import Combine

class LeadManagementViewModel{
    
   //MARK: - VIEW CONTROLLER
   lazy var viewModelVc : LeadManagementVC = {
        let vc = LeadManagementVC()
        return vc
    }()
    
    //MARK: - API PARSER AND COMBINE API RESULT VIEWMODEL
    lazy var apiParserVm:APIParserManager = APIParserManager()
    lazy var parserVm : GlobalAPIViewModel = GlobalAPIViewModel(bgView: self.viewModelVc.view)
    
    //MARK: - CANCELLABLE
    lazy var pendingCountCancellable = Set<AnyCancellable>()
    lazy var employeeListCancellable = Set<AnyCancellable>()
    
    
    
    init(vc:LeadManagementVC) {
        
        self.viewModelVc = vc
        
        
    }
    
    func viewModelCheckSetUp() {
        viewModelVc.view.backgroundColor = AppColor.Shared.colorWhite
    }
    
    func initializeUILabel(){
        self.viewModelVc.todoLabel.text = "0"
        self.viewModelVc.overDueLabel.text = "0"
        self.viewModelVc.upcomingWorksLabel.text = "0"
        self.viewModelVc.myleadLabel.text = "0"
    }
    
  
    
    //MARK: - leadManagementPendingCountDetailsAPICall()
    func leadManagementPendingCountDetailsAPICall(fk_employee:NSNumber=preference.User_Fk_Employee,fromFilter:Bool = false){
        let requestMode = RequestMode.shared.leadManagementPendingCountDetails
        let bankKey = preference.appBankKey
        let fk_employee = "\(fk_employee)"
        let token = preference.User_Token
        let fk_company = "\(preference.User_FK_Company)"
        
         if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
            let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
            let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
            let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
            let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company]
            
             let request = apiParserVm.request(urlPath: URLPathList.Shared.leadManagementPendingCountDetails,arguMents: arguMents)
             self.parserVm.modelInfoKey = "PendingCountDetails"
             self.parserVm.progressBar.showIndicator()
             self.parserVm.parseApiRequest(request)
             
             self.parserVm.$responseHandler
                 .dropFirst()
                 
                 .sink { responseHandler in
                     //self.parserVm.progressBar.hideIndicator()
                     let statusCode = responseHandler.statusCode
                     let message = responseHandler.message
                     if statusCode == 0{
                        // print(responseHandler.info)
                        let pendingCountModel = responseHandler.info
                        let pendingCountInfo = PendingCountInfo(datas: pendingCountModel)
                        
                             
                             self.viewModelVc.todo_count = pendingCountInfo.Todolist
                             self.viewModelVc.overDue_count = pendingCountInfo.OverDue
                             self.viewModelVc.task_count = pendingCountInfo.UpComingWorks
                             self.viewModelVc.lead_count = pendingCountInfo.MyLeads
                             
                         DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                             
                             self.pendingCountCancellable.dispose()
                             self.leadManagementGetAllEmployeeList(fromFilter: fromFilter)
                             }
                             

                     }else{
                         self.parserVm.progressBar.hideIndicator()
                         self.viewModelVc.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in
                             print("no data found")
                         },nil])
                     }
                     print("pending details: \(responseHandler.info)")
                     self.pendingCountCancellable.dispose()
                 }.store(in: &pendingCountCancellable)
             
        }
    }
    
    
    //MARK: - leadManagementGetAllEmployeeList()
    func leadManagementGetAllEmployeeList(fromFilter:Bool){
        let requestMode = RequestMode.shared.leadManagementAllEmployee
        let bankKey = preference.appBankKey
        let fk_employee = preference.User_Fk_Employee
        let token = preference.User_Token
        let fk_company = "\(preference.User_FK_Company)"
        let entrBy = preference.User_UserCode // "EntrBy"
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES("\(fk_employee)", key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           
            let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let eentrBy = instanceOfEncryptionPost.encryptUseDES(entrBy, key: SKey){
           
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"FK_Employee":efk_employee,"Token":etoken,"EntrBy":eentrBy,"FK_Company":efk_company]
            let request = apiParserVm.request(urlPath: URLPathList.Shared.leadManagementAllEmployee,arguMents: arguMents)
           // self.parserVm.progressBar.showIndicator()
            
            self.parserVm.modelInfoKey = "EmployeeAllDetails"
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .sink { responseHandler in
                    self.parserVm.progressBar.hideIndicator()
                    
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    
                    if statusCode == 0{
                        
                        let list = responseHandler.info.value(forKey: "EmployeeAllDetailsList") as? [NSDictionary] ?? []
                        
                        self.viewModelVc.getAllEmployeeList = []
                        self.viewModelVc.getAllEmployeeList = list.map{ EmployeeAllDetails(  datas: $0) }
                        
                        if self.viewModelVc.getAllEmployeeList.count > 0 && fromFilter == false{
                            let result = self.viewModelVc.getAllEmployeeList.filter{ item in
                            let id = item.ID_Employee
                            return id == fk_employee
                        }
                         
                            if let info = result[0] as? EmployeeAllDetails{
                                self.viewModelVc.selectedEmployee = info
                                print(self.viewModelVc.selectedEmployee)
                                
                            }
                        
                        
                        }
                        
                    }else{
                        self.viewModelVc.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in
                            print("no data found")
                        },nil])
                    }
                    
                    print("employee details: \(responseHandler.info)")
                    
                self.employeeListCancellable.dispose()
                }.store(in: &employeeListCancellable)
            
        }
    }
}

//
//  LMCategoryListViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 12/05/23.
//

import Foundation
import UIKit
import Combine

class LMCategoryListViewModel{
    
    
    lazy var viewModelVc : LManagementCategoryListVC = {
        let vc  = LManagementCategoryListVC()
        
        return vc
    }()
    
    let apiParserVm : APIParserManager = APIParserManager()
    lazy var parserVm : GlobalAPIViewModel = GlobalAPIViewModel(bgView: viewModelVc.view)
    
    lazy var lmCategoryListCancellable = Set<AnyCancellable>()
    
    
    init(controller:LManagementCategoryListVC,submode:String,branchCode:String,name:String="",id:String="",criteria:String="",fk_employee:String = ""){
        self.viewModelVc = controller
        leadMangeDetailListAPICall(subMode: submode, branchCode: branchCode,name: name, id:id, criteria: criteria, fk_employee: fk_employee)
    }
    
    func leadMangeDetailListAPICall(subMode:String,branchCode:String,name:String="",id:String="",criteria:String="",fk_employee:String){
        let requestMode = RequestMode.shared.lmCategoryList
        let bankKey = preference.appBankKey
        let fk_employee = fk_employee == "" ? "\(preference.User_Fk_Employee)" : fk_employee
        let token = preference.User_Token
        let fk_company = "\(preference.User_FK_Company)"
        let get_subMode = subMode
        let get_branchCode = branchCode
        let toDate = ""
        let get_name = name
        let get_ID_TodoListLeadDetails = id
        let get_criteria = criteria
        
        
         if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
            let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
            let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
            let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
            let eSubMode = instanceOfEncryptionPost.encryptUseDES(get_subMode, key: SKey),
            let eBranchCode = instanceOfEncryptionPost.encryptUseDES(get_branchCode, key: SKey),
            let eDate = instanceOfEncryptionPost.encryptUseDES(toDate, key: SKey),
            
            let eName = instanceOfEncryptionPost.encryptUseDES(get_name, key: SKey),
            let eId = instanceOfEncryptionPost.encryptUseDES(get_ID_TodoListLeadDetails, key: SKey),
            let eCriteria = instanceOfEncryptionPost.encryptUseDES(get_criteria, key: SKey),
                
                
            let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
             let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company,"SubMode":eSubMode,"Name":eName,"Todate":eDate,"criteria":eCriteria,"BranchCode":"\(eBranchCode)","ID_TodoListLeadDetails":eId]
            
             let request = apiParserVm.request(urlPath: URLPathList.Shared.lmCategoryList,arguMents: arguMents)
             
             self.parserVm.modelInfoKey = "LeadManagementDetailsList"
             self.parserVm.progressBar.showIndicator()
             self.parserVm.parseApiRequest(request)
             
             self.parserVm.$responseHandler
                 .receive(on: DispatchQueue.main)
                 .dropFirst()
                 .sink { responseHandler in
                     self.parserVm.progressBar.hideIndicator()
                     let statusCode = responseHandler.statusCode
                     let message = responseHandler.message
                     // LeadManagementDetailsInfo
                    
                     if statusCode == 0{
                         let list  = responseHandler.info.value(forKey: "LeadManagementDetails") as? [NSDictionary] ?? []
                         self.viewModelVc.lmListTableView.tableIsEmpty("ic_no_data","Loading....",AppColor.Shared.coloBlack)
                         self.viewModelVc.list = []
                         self.viewModelVc.selectedReminderList = []
                         self.viewModelVc.list = list.map{ LeadManagementDetailsInfo(datas: $0)}
                         for i in list{
                             self.viewModelVc.selectedReminderList.append(0)
                         }
                         
                         self.viewModelVc.lmListTableView.tableHasItems()
                         
                     }else{
                         
                         self.viewModelVc.list = []
                         self.viewModelVc.lmListTableView.tableIsEmpty("ic_no_data","No Data Found",AppColor.Shared.coloBlack)
                         
                     }
                     
                    
                     
                   self.lmCategoryListCancellable.dispose()
                 }.store(in: &lmCategoryListCancellable)
             
         }
    }
    
}




//
//  FollowUpViewModel.swift
//  
//
//  Created by MacBook on 31/05/23.
//

import Foundation
import UIKit
import Combine

enum ResponseError:Error{
    case statusCodeError(message:String)
}

class FollowUpViewModel{
    
    
    //MARK: - VIEW CONTROLLER
    lazy var viewModelVc : UIViewController = {
         let vc = UIViewController()
         return vc
     }()
    
    //MARK: - API PARSER AND COMBINE API RESULT VIEWMODEL
    lazy var apiParserVm:APIParserManager = APIParserManager()
    lazy var parserVm : GlobalAPIViewModel = GlobalAPIViewModel(bgView: self.viewModelVc.view)
    
    //MARK: - CANCELLABLE
    lazy var actionTypeCancellable = Set<AnyCancellable>()
    
    
    let commonNetworkLayer = SharedNetworkCall.Shared
    
    init(vc:UIViewController){
        self.viewModelVc = vc
    }
    
    
    func followUpActionTypeAPICall(_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        
        let requestMode = RequestMode.shared.fd_ActionType
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let fk_company = "\(preference.User_FK_Company)"
    
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey)
             {
           let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company]
           
            let request = apiParserVm.request(urlPath: URLPathList.Shared.fd_ActionType,arguMents: arguMents)
            
            self.parserVm.modelInfoKey = "FollowUpTypeDetails"
            
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    
                    
                    //print(responseHandler.info)
                    
                    completionHandler(responseHandler)
                    
                    self.actionTypeCancellable.dispose()
                    
                }.store(in: &actionTypeCancellable)
          }
     }
    
    // ED-54
    // FollowUP By Call
    func followUp_ByAPICall(_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        
        commonNetworkLayer.leadMangeAPIManager?.employeeDetails_APICall { responseHandler in
            completionHandler(responseHandler)
        }
    }
    
    //FUSAC-613
    // FollowUp Status Api call
    func followUp_StatusAPICall(_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        commonNetworkLayer.leadMangeAPIManager?.status_ApiCall(RequestMode.shared.fd_FollowUpStatus) { responseHandler in
            completionHandler(responseHandler)
        }
    }
    
    //FUCSAC-6313
    // FollowUp Call Status Api call
    func followUp_CallStatusAPICall(_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        commonNetworkLayer.leadMangeAPIManager?.status_ApiCall(RequestMode.shared.fd_FollowUpCallStatus) { responseHandler in
            completionHandler(responseHandler)
        }
    }
    
    // NAAL-1112
    // NEXT ACTION ACTION LISTING
    func nextActionActionListingAPICall(_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        commonNetworkLayer.leadMangeAPIManager?.nextActionActionListingAPICall(RequestMode.shared.fd_Action) { responseHandler in
            completionHandler(responseHandler)
        }
    }
    
    // NAPL-1411 NEXT ACTION PRIORITY LISTING API
    //MARK: - ========= prioriyAPICall() =============
    func nextActionPriorityListingAPICall(_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        commonNetworkLayer.leadMangeAPIManager?.nextActionPriorityListingAPICall(RequestMode.shared.LeadPriority) { responseHandler in
            completionHandler(responseHandler)
        }
    }
    
    // NADL-141412 NEXT ACTION DETAILS LISTING
    //MARK: - ========= nextActionDepartmentListingAPICall() =============
    func nextActionDepartmentListingAPICall(_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        commonNetworkLayer.leadMangeAPIManager?.nextActionDepartmentListingAPICall(RequestMode.shared.fd_Department) { responseHandler in
            completionHandler(responseHandler)
        }
    }
    
    // SFUDAC-6413 SAVE FOLLOW UP DETAILS API CALL
    //MARK: - ========= saveFollowUpDetailsAPICall() =============
    func saveFollowUpDetailsAPICall(actionType:String,info:FollowUpParamValidation,_ completionHandler:@escaping ((successErrorHandler) -> Void)){
        commonNetworkLayer.leadMangeAPIManager?.saveFollowUpdateLeadManagementUpDetails(actionType:actionType,info: info, { responseHandler in
            completionHandler(responseHandler)
        })
    }
}

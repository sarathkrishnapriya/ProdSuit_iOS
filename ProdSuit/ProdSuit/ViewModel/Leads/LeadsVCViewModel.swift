//
//  LeadsVCViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 10/04/23.
//

import Foundation
import UIKit
import Combine

class LeadsVCViewModel{
    
    lazy var controller:LeadsVC = {
        let vc = LeadsVC()
        
        return vc
    }()
    
    var parserViewModel : APIParserManager = APIParserManager()
    
    var parserVm : GlobalAPIViewModel!
    
    lazy var defaultLeadValueCancellable = Set<AnyCancellable>()
    
    
    init(controller:LeadsVC){
        self.controller = controller
        self.parserVm = GlobalAPIViewModel(bgView: self.controller.view)
        self.leadGenerationDefaultValueLoadingAPICall()
    }
    
    func leadGenerationDefaultValueLoadingAPICall(){
        
        
        let requestMode = RequestMode.shared.LeadDefaultValueLoading
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let fk_company = "\(preference.User_FK_Company)"
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
        let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
        let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
        let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
        let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"FK_Employee":efk_employee,"FK_Company":efk_company,"Token":etoken]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.defaultValueLoading, arguMents: arguMents)
            //self.parserVm.progressBar.showIndicator()
           
            self.parserVm.parseApiRequest(request)
            self.parserVm.modelInfoKey = "LeadGenerationDefaultvalueSettings"
            self.parserVm.$responseHandler
                .dropFirst()
                .eraseToAnyPublisher()
                .sink { responseHandler in
                    //self.parserVm.progressBar.hideIndicator()
                    let message = responseHandler.message
                    //print(responseHandler.info)
                    
                    if responseHandler.statusCode == 0{
                    self.controller.leadGenerationDefaultValueSettingsInfo = LeadGenerationDefaultValueModel(datas: responseHandler.info)
                        print(responseHandler.info)
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [closeTitle], actions: [{action1 in
                            print("leads chart error")
                        },nil])
                    }
                    
                }.store(in: &defaultLeadValueCancellable)
            
            
            
        }
        
        
        
    }
    
    deinit {
       
        print("lead vc relased")
        
    }
    
}

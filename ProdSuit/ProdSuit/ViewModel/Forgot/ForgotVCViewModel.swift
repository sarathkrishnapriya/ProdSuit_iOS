//
//  ForgotVCViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 06/03/23.
//

import Foundation
import UIKit
import Combine

class ForgotVCViewModel{
    
    var preference = SharedPreference.Shared
    var parsetViewModel : APIParserManager = APIParserManager()
    var parserVm : GlobalAPIViewModel!
    lazy var forgotCancellable = Set<AnyCancellable>()
    
    var controller : UIViewController!
    
    init(controller:UIViewController) {
        self.controller = controller
        self.parserVm = GlobalAPIViewModel(bgView: controller.view)
    }
    
    
    fileprivate func resultHandler(_ responseHandler: Publishers.Drop<Published<successErrorHandler>.Publisher>.Output, _ message: String) {
        let forgotMpinVC = self.controller as! ForgotMpin
        forgotMpinVC.view.isUserInteractionEnabled = true
        forgotMpinVC.mobileTF.text = ""
        if responseHandler.statusCode == 0{
            
            let mpindetailsInfo = ForgotMpinModel(datas: responseHandler.info)
            
            forgotMpinVC.popupAlert(title: "", message: mpindetailsInfo.responseMessage, actionTitles: [okTitle], actions: [{okAction in
                forgotMpinVC.dismiss(animated: true)
            },nil])
            
            
        }else if responseHandler.statusCode == -11{
            print("forgot password error : \(responseHandler.message)")
        }else{
            
            self.controller.popupAlert(title: "", message: message, actionTitles: [closeTitle], actions: [{ action in
                forgotMpinVC.dismiss(animated: true)
            },nil])
            
        }
    }
    
    func forgotMpinApiCall(mobile_number:String){
        
        let bankKey = preference.appBankKey
        let requestmode = RequestMode.shared.ForgotMPIN
        let token = preference.User_Token
        let fk_employee = "\(preference.User_Fk_Employee)"
        
        if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let ereqMode = instanceOfEncryptionPost.encryptUseDES(requestmode, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let emobileNumber = instanceOfEncryptionPost.encryptUseDES(mobile_number, key: SKey){
            
            let arguMents = ["ReqMode":ereqMode,"BankKey":ebankKey,"FK_Employee":efk_employee,"Token":etoken,"MobileNumber":emobileNumber]
            
           let request =  self.parsetViewModel.request(urlPath: URLPathList.Shared.forgotMpin, arguMents: arguMents)
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.modelInfoKey = "MPINDetails"
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    
                    print(responseHandler.info)
                    let message = responseHandler.message
                    self.parserVm.progressBar.hideIndicator()
                    self.resultHandler(responseHandler, message)
                    
                    
                }.store(in: &forgotCancellable)
            
        }
        
    }
    
}

//
//  ChangeMPINViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 21/03/23.
//

import Foundation
import Combine
import UIKit

protocol ChangeMPINProtocol:AnyObject{
    func  changeMPINAction(changeMPINVC:ChangeMpinVC)
}

class ChangeMpinVCViewModel{
    
   
    var preference = SharedPreference.Shared
    
    lazy var changeMPINCancellable = Set<AnyCancellable>()
    
    lazy var controller: UIViewController={
        
       let changeVc = ChangeMpinVC()
        
        return changeVc
        
    }()
    
    
    var parderViewModel : APIParserManager = APIParserManager()
    
    var parserVm : GlobalAPIViewModel!
    @Published var confirmMpin:String = ""
    
    
    
    init(controller:UIViewController){
        self.controller = controller
        self.parserVm = GlobalAPIViewModel(bgView: self.controller.view)
        
    }
    
   
   // MARK: - ChangeMPIN_API_Call()
    fileprivate func resultHandler(_ responseHandler: Publishers.Drop<Published<successErrorHandler>.Publisher>.Output,_ changeMPINVC:ChangeMpinVC) {
        let statuCode = responseHandler.statusCode
        let exmessage = responseHandler.message
        
        if statuCode == 0{
            self.controller.popupAlert(title: "", message: successMPINChangeMessage, actionTitles: [okTitle], actions: [{
                action1 in
                changeMPINVC.dismiss(animated: true) {
                    
                    changeMPINVC.delegate?.changeMPINAction(changeMPINVC: changeMPINVC)
                    
                }
            },nil])
        }else{
            
            self.controller.popupAlert(title: "", message: exmessage, actionTitles: [closeTitle], actions: [{
                action1 in
                print("change mpin not work")
            },nil])
        }
    }
    
    func changeMPIN_API_Call(current:String,new:String,changeMPINVC:ChangeMpinVC){
        
           let bankKey = preference.appBankKey
           let token = preference.User_Token
           let fk_emplyee = "\(preference.User_Fk_Employee)"
           let requestmode = RequestMode.shared.ChangeMPIN
           
        if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_emplyee, key: SKey),
           let erequestmode = instanceOfEncryptionPost.encryptUseDES(requestmode, key: SKey),
           let ecurrentMPIN = instanceOfEncryptionPost.encryptUseDES(current, key: SKey),
           let enewMPIN = instanceOfEncryptionPost.encryptUseDES(new, key: SKey){
            
               let arguMents = ["BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"ReqMode":erequestmode,"MPIN":enewMPIN,"OldMPIN":ecurrentMPIN]
               let request =  self.parderViewModel.request(urlPath: URLPathList.Shared.changeMPIN,method: .POST,arguMents: arguMents)
               
               self.parserVm.parseApiRequest(request)
               self.parserVm.progressBar.showIndicator()
               self.parserVm.$responseHandler
                   .dropFirst()
                   .sink { responseHandler in
                       print(responseHandler.info)
                       self.parserVm.progressBar.hideIndicator()
                       
                       changeMPINVC.resetMPIN()
                       
                       self.resultHandler(responseHandler, changeMPINVC)
                       
                   }.store(in: &changeMPINCancellable)
               
        }
        
        
//
        
    }
    
    
    
}







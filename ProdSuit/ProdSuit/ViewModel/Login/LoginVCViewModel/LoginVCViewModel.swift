//
//  LoginVCViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 02/03/23.
//

import Foundation
import UIKit
import Combine


class LoginViewModel{
    
    lazy var controller : UIViewController = {
        let controller = LoginVC()
        
        return controller
    }()
    lazy var parserViewModel:APIParserManager = APIParserManager()
    var parserVM : GlobalAPIViewModel!
    let preference = SharedPreference.Shared
    
    var loginCancellable = Set<AnyCancellable>()
    
    init(controller:UIViewController) {
        self.controller = controller
        self.parserVM = GlobalAPIViewModel(bgView: controller.view)
        
    }
    
    // userLoginApiCall
    func userLoginApiCall(mobile_Number:String,sender:UIButton){
        
        let bankKey = preference.appBankKey
        let requestMode = RequestMode.shared.UserLogin
        print("requestMode: \(requestMode) == bankKey: \(bankKey) == mobileNumber : \(mobile_Number)")
        if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
        let eRequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
        let eMobileNumber = instanceOfEncryptionPost.encryptUseDES(mobile_Number, key: SKey){
        let arguMents = ["BankKey":ebankKey,"ReqMode":eRequestMode,"MobileNumber":eMobileNumber]
        
        
        
        let request = self.parserViewModel.request(urlPath: URLPathList.Shared.login, arguMents: arguMents)
        self.parserVM.parseApiRequest(request)
        self.parserVM.modelInfoKey = "UserLoginDetails"
        self.parserVM.$responseHandler
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { responseHandler in
                
                
                
                
                self.loginSuccessFailedHandling(responseHandler: responseHandler)
                
                self.clearTextfield(sender: sender)
                
                
            }.store(in: &loginCancellable)
        }
        
    }
    
    func userLoginValidation(mobile_Number: String,sender:UIButton){
        parserVM.NetworkCheck()
        if parserVM.isInternetConnected == true{
            userLoginApiCall(mobile_Number: mobile_Number, sender: sender)
        }else{
            self.controller.popupAlert(title: networkTitle, message: networkMsg, actionTitles: [closeTitle], actions: [{ action1 in
                 print("login failed because of bad network")
            },nil])
            
        }
    }
    
    func clearTextfield(sender:UIButton){
        let loginVc = self.controller as! LoginVC
        loginVc.mobileNumberTF.text = ""
        sender.isEnabled = true
    }
    
    func loginSuccessFailedHandling(responseHandler:successErrorHandler){
        
        let loginVc = controller as! LoginVC
        loginVc.successErrorView = SuccessErrorView(bgView: loginVc.view)
        
        
        if responseHandler.statusCode == 0{
            loginVc.successErrorView.showMessage(msg: loginSuccessText, style: .success, time: 3)
            
            let userLoginDetailsInfo = UserLoginDetailsModel(datas: responseHandler.info)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+4) {
                
                print("next page")
                print("token==  "+userLoginDetailsInfo.Token)
                var navlist = self.controller.navigationController?.viewControllers
                if !self.controller.allControllers.contains(AppVC.Shared.OtpPage){
                let otpVc = AppVC.Shared.OtpPage
                
                navlist!.removeLast()
                navlist!.append(otpVc)
                otpVc.token = userLoginDetailsInfo.Token
                otpVc.fk_employee = "\(userLoginDetailsInfo.FK_Employee)"
                    
                    self.controller.navigationController?.setViewControllers(navlist!, animated: true)
                }
            }
        }else if responseHandler.statusCode == -11{
            print("status code -11")
        } else{
            
            loginVc.successErrorView.showMessage(msg: responseHandler.message, style: .failed, time: 3)
            
        }
        
        
    }
    
    
    
}

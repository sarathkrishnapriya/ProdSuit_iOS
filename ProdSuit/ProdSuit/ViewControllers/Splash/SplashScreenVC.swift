//
//  ViewController.swift
//  ProdSuit
//
//  Created by MacBook on 13/02/23.
//

import UIKit
import Foundation
import Combine

class SplashScreenVC: UIViewController {
    
    let encryptionInstance : EncryptionPost = EncryptionPost()
    lazy var splashViewModel : SplashViewModel = SplashViewModel(bgView: self.view, controller: self)
    
    private var cancellables = [AnyCancellable]()
    private var bankcancellables = [AnyCancellable]()
    lazy var maintenanceCancellables = Set<AnyCancellable>()
    
    let reachability  = Reachability()
    var isInternetConnected = Bool()
    var successErrorView : SuccessErrorView!
    var bankKey : String = ""
    
    
    
    
    
    fileprivate func pageDirection() {
        
        if SharedPreference.Shared.onBoardCompleted == false{
            
            let login_sliderVC = AppVC.Shared.LoginSlider
            if !self.allControllers.contains(login_sliderVC){
            self.moveToNextVc(nextController: login_sliderVC)
            }else{
                print("login slider page already in navigation controller")
            }
            
        }else{
            
            if SharedPreference.Shared.welcomedPageCompleted == false{
                
                let welcomPage = AppVC.Shared.WelcomePage
                if !self.allControllers.contains(welcomPage){
                    self.moveToNextVc(nextController: welcomPage)
                }else{
                    print("welcome page already in navigation controller")
                }
                
                
            }else{
                
                if SharedPreference.Shared.isLogged == false{
                    
                    let loginPage = AppVC.Shared.LoginPage
                    if !self.allControllers.contains(loginPage){
                        self.moveToNextVc(nextController: loginPage)
                    }else{
                        print("login page already in navigation controller")
                    }
                    
                    
                }else{
                    
                    let mpinPage = AppVC.Shared.MpinPage
                    if !self.allControllers.contains(mpinPage){
                        self.moveToNextVc(nextController: mpinPage)
                    }else{
                        print("mpin page already in navigation controller")
                    }
                    
                }
                
                
                
            }
            
            
        }
        
    }
    
    
    func NetworkCheck(connected:Bool) {
        // Do any additional setup after loading the view.
        
        if connected==true || self.isInternetConnected == true{
            
            print(SharedPreference.Shared.appBankKey)
            print(SharedPreference.Shared.TestingURL)
            if SharedPreference.Shared.appBankKey != ""{
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    
                    if SharedPreference.Shared.User_Token == ""{
                        self.pageDirection()
                    }else{
                        
                        let bank_key = SharedPreference.Shared.appBankKey
                        self.splashViewModel.bankKey = bank_key
                        
                        self.getBankKeyGetApiResponse()
                        
                        
                    }
                    
                }
                
            }else{
                
                isInternerConnectedCall(functionHandler: self.commonAppApiCall)
                
            }
            
            
        }else{
            
            //errorView.showMessage(msg: networkMsg,style: .failed)
            self.popupAlert(title: "Network", message: "No internet connection. Do you want to continue", actionTitles: ["No","Yes"], actions:[{action1 in
                print("exit")
                exit(0)
            },{action2 in
                self.NetworkCheck(connected: self.isInternetConnected)
            }, nil])
            
        }
        
    }
    
    fileprivate func splashinitializeMethod() {
        self.successErrorView = SuccessErrorView(bgView: self.view)
        var networkCancellable : AnyCancellable!
       networkCancellable = reachability.$isActive
            .receive(on: DispatchQueue.main)
        
            .sink(receiveCompletion: { [weak self] _ in
               // let cancelIndex = self?.cancellables.firstIndex{$0 == networkCancellable}
               // print("index value = \(cancelIndex)")
                networkCancellable.cancel()
            }, receiveValue: { connected in
                print(connected)
                
                self.isInternetConnected = connected
                self.NetworkCheck(connected: connected)
            })
        networkCancellable.store(in: &cancellables)
        
        
    }
    
    
    
    
    func isInternerConnectedCall(functionHandler:()->Void){
        
        
        
        functionHandler()
        
        
    }
    
    func commonAppApiCall(){
        
        
        self.splashViewModel.commonAppApiCall()
        self.splashViewModel.$commonApiMode
            .sink { getMode in
                //print("mode: \(mode)")
                if getMode == "1" {
                    print("get mode \(getMode)")
                    self.commonApiModeAlert(model: self.splashViewModel,vc: self)
                    self.getBankKeyGetApiResponse()
                    
                }else{
                    print("get mode \(getMode)")
                    
                    self.getBankKeyGetApiResponse()
                }
            }.store(in: &cancellables)
        
        
    }
    
    
    func getBankKeyGetApiResponse(){
        self.splashViewModel.$bankKey.sink { bank_key in
            print("bankKey = \(bank_key)")
            if bank_key != ""{
                self.bankKey = bank_key
                if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bank_key, key: SKey){
                    let reqMode = instanceOfEncryptionPost.encryptUseDES(RequestMode.shared.MaintenanceMessage, key: SKey)
                    self.splashViewModel.maintenanceMessageAPICall(bankKey: ebankKey, reqMode: reqMode!)
                    
                }
                
            }
        }.store(in: &bankcancellables)
    }
    
    func maintenanceAPIInfo() {
        
        splashViewModel.messageCancellable.dispose()
        splashViewModel.$maintenanceModel
            
            .sink { maintenanceInfo in
                
                if let maintenanceInfoModel = maintenanceInfo{
                    print(maintenanceInfoModel)
                    
                    switch maintenanceInfoModel.Types{
                    case 0:
                        print("Maintenance Type : \(maintenanceInfoModel.Types)")
                        print("continue with get seller api")
                        if let eBankKey = instanceOfEncryptionPost.encryptUseDES(self.bankKey, key: SKey){
                            let reqMode = instanceOfEncryptionPost.encryptUseDES(RequestMode.shared.ResellerDetails, key: SKey) ?? ""
                            self.splashViewModel.resellerDetailsAPICall(bankKey: eBankKey, reqMode: reqMode, originalBankKey: self.bankKey, controller: self)
                        }
                        
                    case 1:
                        print("Maintenance Type : \(maintenanceInfoModel.Types)")
                        self.popupAlert(title: "Warning", message: maintenanceInfoModel.Description, actionTitles: ["No","Yes"], actions: [
                            { action1 in
                                print("app exit")
                                exit(0)
                            },
                            { action2 in
                                
                                
                                if let eBankKey = instanceOfEncryptionPost.encryptUseDES(self.bankKey, key: SKey){
                                    let reqMode = instanceOfEncryptionPost.encryptUseDES(RequestMode.shared.ResellerDetails, key: SKey) ?? ""
                                    self.splashViewModel.resellerDetailsAPICall(bankKey: eBankKey, reqMode: reqMode, originalBankKey: self.bankKey, controller: self)
                                }
                                
                                
                            },nil
                        ])
                        
                        
                    case 2:
                        print("Maintenance Type : \(maintenanceInfoModel.Types)")
                        
                        self.popupAlert(title: "Warning", message: maintenanceInfoModel.Description,  actionTitles: ["Exit"], actions: [{ action1 in
                            print("app exit")
                            exit(0)
                        },nil])
                        
                        
                    default:
                        print("Maintenance Type : default")
                    }
                }
               
            }.store(in: &maintenanceCancellables)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.allControllers)
        self.splashViewModel = SplashViewModel(bgView: self.view, controller: self)
        self.maintenanceAPIInfo()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        
        splashinitializeMethod()
        
    }
    
    func combineApiTest(){
        //        parserViewModel.run(request)
        //
        //            .sink { completion in
        //            switch completion{
        //            case.finished:
        //                print("finished")
        //            case .failure(let parserError):
        //
        //                switch parserError {
        //                case .internalError(let _statusCode, let _msg):
        //                    print("status == \(_statusCode) msg == \(_msg)")
        //                case .serverError(let _statusCode, let _msg):
        //                    print("status == \(_statusCode) msg == \(_msg)")
        //                case .customError(let _statusCode, let _msg):
        //                    print("status == \(_statusCode) msg == \(_msg)")
        //                }
        //            }
        //
        //        } receiveValue: { result in
        //            print(result.value)
        //            let respons = result.response as! HTTPURLResponse
        //            print(respons.statusCode)
        //        }
        //
        //        .store(in: &cancellables)
    }
    
    
    

}

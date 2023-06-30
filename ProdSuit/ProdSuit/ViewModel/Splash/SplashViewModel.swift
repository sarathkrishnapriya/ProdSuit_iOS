//
//  SplashViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 23/02/23.
//

import Foundation
import UIKit
import Combine

class SplashViewModel{
    
    @Published var commonApiMode:String = ""
    @Published var bankKey :String = ""
    @Published var maintenanceModel:MaintenanceModel!
    
    
    lazy var parserViewModel : APIParserManager = APIParserManager()
    private var cancellables = Set<AnyCancellable>()
    lazy var getCodeCancellable = Set<AnyCancellable>()
    lazy var messageCancellable = Set<AnyCancellable>()
    lazy var resellerCancellable = Set<AnyCancellable>()
    var popupView : PopUpView!
    var parserVM : GlobalAPIViewModel!
    lazy var controller : UIViewController = {
        let controller = SplashScreenVC()
        
        return controller
    }()
    
    init(bgView:UIView,controller:UIViewController) {
        
        self.parserVM = GlobalAPIViewModel(bgView: bgView)
        self.controller = controller
        
        
        
    }
    
   
    //MARK: - COMMON_APP_API_CALL_RESPONSE()
    func commonAppApiCall(){
        
        let request = parserViewModel.request(urlPath: URLPathList.Shared.commonApp)
        self.parserVM.parseApiRequest(request)
        
        self.parserVM.$responseHandler
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { responseHandler in
                if let commonmode = responseHandler.info.value(forKey: "Mode") as? String{
                    
                    self.commonApiMode = commonmode
                    if self.commonApiMode == "0"{
                        self.bankKey = BankKey
                    }
                    if self.commonApiMode != "" && SharedPreference.Shared.isCommonApp == ""{
                        SharedPreference.Shared.isCommonApp = self.commonApiMode
                    }else{
                        print("common Mode == \(SharedPreference.Shared.isCommonApp)")
                    }
                }
            
        }.store(in: &cancellables)
        
    }
    
    //MARK: - company_Code_Api_Call()
    func companyCodeApiCall(companyCode:String){
        let arguMents = ["CompanyCode":companyCode]
        let request = parserViewModel.request(urlPath: URLPathList.Shared.companyCode, arguMents: arguMents)
        
        self.parserVM.parseApiRequest(request)
        
        self.parserVM.$responseHandler
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { responseHandler in
                
                let message = responseHandler.message
                
                if responseHandler.statusCode == 0{
                    
                    let modelInfo = responseHandler.info
                print(responseHandler)
                if let bankKeyValue = modelInfo.value(forKey: "BankKey") as? String{
                    print("bank key =  \(bankKeyValue)")
                    self.bankKey = bankKeyValue
                }
                    
                }else{
                    
                    self.controller.popupAlert(title: "", message: message, actionTitles: ["Cancel","Retry"], actions: [
                        { action1 in
                            print("app exit")
                            exit(0)
                        },
                        { [self] action2 in
                            
                            
                            let splash = self.controller as! SplashScreenVC
                             splash.commonAppApiCall()
                            
                        }
                     ,nil])
                    
                }
                
                
                    
                    
                
            }.store(in: &getCodeCancellable)
        
        
    }
    
    //MARK: - maintenanceMessageAPICall()
    func maintenanceMessageAPICall(bankKey:String,reqMode:String,controller:SplashScreenVC = AppVC.Shared.Splash){
        
        let arguMents = ["BankKey":bankKey,"ReqMode":reqMode]
        
        let request = parserViewModel.request(urlPath: URLPathList.Shared.app_MaintenanceMessage,arguMents: arguMents)
        
        self.parserVM.parseApiRequest(request)
            
             self.parserVM.$responseHandler
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { responseHandler in
                self.parserVM.modelInfoKey = "MaintenanceMessage"
                
                let modelInfo = responseHandler.info
                //print("messageInfo:\(modelInfo)")
                self.maintenanceModel = MaintenanceModel(datas: modelInfo)
                
                
                
            }.store(in: &messageCancellable)
     }
    
    
    //MARK: - resellerDetailsAPICall()
    func resellerDetailsAPICall(bankKey:String,reqMode:String,originalBankKey:String,controller:UIViewController){
        
        let arguMents = ["BankKey":bankKey,"ReqMode":reqMode]
        let splash = controller as! SplashScreenVC
        splash.maintenanceCancellables.dispose()
        let request = parserViewModel.request(urlPath: URLPathList.Shared.app_Reseller , arguMents: arguMents)
        self.parserVM.modelInfoKey =  "ResellerDetails"
        self.parserVM.parseApiRequest(request)
        self.parserVM.$responseHandler
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { responseHandler in
                
                
                if responseHandler.statusCode == 0{
                    
                    
                    let modelInfo = responseHandler.info
                    //ResellerDetailModel
                    let resellerModel = ResellerDetailModel(datas: modelInfo)
                    
                    
                    if resellerModel.testingUrl != ""{
                        
                    
                        
                        //print("sellerInfo : \(resellerModel)")
                       
                        self.loginInfoStore(bankKey: originalBankKey, resellerModel: resellerModel)
                        
                    }
                    
                    //print("reseller details fetch successfully and bankKey : \(originalBankKey)")
                }else{
                    
                    controller.popupAlert(title: "", message: responseHandler.message, actionTitles: ["Cancel","Retry"], actions: [{ action1 in
                        
                        print("app exit")
                        exit(0)
                        
                    },{ action2 in
                        
                        self.resellerDetailsAPICall(bankKey: bankKey, reqMode: reqMode, originalBankKey: originalBankKey, controller: controller)
                        
                    },nil])
                    
                }
                
                
            }.store(in: &resellerCancellable)
            
        
    }
    
    func loginInfoStore(bankKey:String,resellerModel:ResellerDetailModel) {
        
        
        var preference = SharedPreference.Shared
        
        if preference.appBankKey == "" && preference.TestingURL == ""{
            
            print("nobank key")
            
            
            preference.appBankKey = bankKey
            preference.AppIconImageCode = resellerModel.appIconImageCode
            preference.AboutUs = resellerModel.aboutUs
            preference.CertificateName = resellerModel.certificateName
            
            preference.ContactEmail = resellerModel.contactEmail
            preference.ContactNumber = resellerModel.contactNumber
            preference.ContactAddress = resellerModel.contactAddress
            preference.AppStoreLink = resellerModel.AppstoreLink
            preference.PlayStoreLink = resellerModel.playstoreLink
            
            preference.CompanyLogoImageCode = resellerModel.companyLogoImageCode
            preference.ProductName = resellerModel.productName
            preference.ResellerName = resellerModel.resellerName
            preference.TestingBankHeader = resellerModel.testingBankHeader
            
            preference.TestingBankKey = resellerModel.testingBankKey
            preference.TestingMobileNo = resellerModel.testingMobileNo
            preference.TestingMachineId = resellerModel.testingMachineId
            preference.TestingImageURL = resellerModel.testingImageUrl
            preference.TestingURL = resellerModel.testingUrl
            
            print("first saved")
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.resellerCancellable.dispose()
                    let login_sliderVC = AppVC.Shared.LoginSlider
                    DispatchQueue.main.async {[weak self] in
                    self?.controller.navigationController?.pushViewController(login_sliderVC, animated: true)
                    }
                       
            }
            
            
            
        }else{
            
            
            
            print("bankKey : \(SharedPreference.Shared.appBankKey)")
            print("testbankKey : \(SharedPreference.Shared.TestingBankKey))")
            print("already saved")
            
            
            let mpinPage = AppVC.Shared.MpinPage
            if !controller.allControllers.contains(mpinPage){

//                let dashboardVC = AppVC.Shared.DashboardPage
//                dashboardVC.dashboardVM = DashboardVCViewModel(controller: dashboardVC)
//                dashboardVC.dashboardVM.bannerDetailsAPICall(vc: dashboardVC, nil)
                
               
                controller.moveToNextVc(nextController: mpinPage)
            }else{
                print("mpin page already in navigation controller")
            }
            //SharedPreference.Shared.logOut()
            
            
        }
        
    }
    
    
    
}

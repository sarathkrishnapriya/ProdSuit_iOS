//
//  OtpVCViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 03/03/23.
//

import Foundation
import UIKit
import Combine


class OtpViewModel{
    
    var parserViewModel : APIParserManager = APIParserManager()
    var parserVM : GlobalAPIViewModel!
    lazy var controller : UIViewController = {
        let controller = OTPVC()
        
        return controller
    }()
    let preference = SharedPreference.Shared
    var count = 0
    var userdetailsModelInfo : UserLoginDetailsModel!
    lazy var otpCancellables = Set<AnyCancellable>()
    
    
    init(controller:UIViewController){
        self.controller = controller
        self.parserVM = GlobalAPIViewModel(bgView: self.controller.view)
    }
    
    //MARK: - callSetMpinPage()
    fileprivate  func callSetMpinPage(_ userdetailsInfo: UserLoginDetailsModel) {
//        let dashboardVC = AppVC.Shared.DashboardPage
//        dashboardVC.dashboardVM = DashboardVCViewModel(controller: dashboardVC)
//        dashboardVC.dashboardVM.bannerDetailsAPICall(vc: dashboardVC, nil)
        
        var navlist = self.controller.navigationController?.viewControllers
        
        let setMpinVc = AppVC.Shared.SetMpinPage
        
        navlist!.removeLast()
        navlist!.append(setMpinVc)
        setMpinVc.token = userdetailsInfo.Token
        setMpinVc.userdetailsModelInfo = userdetailsInfo
        setMpinVc.fk_employee = "\(userdetailsInfo.FK_Employee)"
        self.controller.navigationController?.setViewControllers(navlist!, animated: true)
    }
    
    //MARK: - resultHandler()
    fileprivate  func resultHandler(_ responseHandler: Publishers.Drop<AnyPublisher<Published<successErrorHandler>.Publisher.Output, Published<successErrorHandler>.Publisher.Failure>>.Output, _ message: String) {
        //count += 1
        
        if responseHandler.statusCode == 0{
            let userdetailsInfo = UserLoginDetailsModel(datas: responseHandler.info)
            print("otp_details: \(userdetailsInfo)")
            
            callSetMpinPage(userdetailsInfo)
            
        }else if responseHandler.statusCode == -11{
            print("status code -11")
        }else{
            
            
            self.controller.popupAlert(title: "", message: message, actionTitles: [closeTitle], actions: [{action1 in
                print("otp verification issue statuscode =\(responseHandler.statusCode) - \(responseHandler.message)")
                
                
            },nil])
            
        }
    }
    
    //MARK: - resetPage()
    fileprivate func resetPage() {
        let otpVc = self.controller as! OTPVC
        otpVc.resetPage()
    }
    
    //MARK: - otpApiCall(token:String)
    func otpApiCall(token:String,otp:String,fk_employee:String){
        
       
       
        let bankKey = preference.appBankKey
        let requestMode = RequestMode.shared.Otp_Verification
        
        
        
        if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let ereqmode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let eotp = instanceOfEncryptionPost.encryptUseDES(otp, key: SKey){
           let arguMents = ["BankKey":ebankKey,"FK_Employee":efk_employee,"Token":etoken,"ReqMode":ereqmode,"OTP":eotp]
           let request = parserViewModel.request(urlPath: URLPathList.Shared.otp_Verification,arguMents: arguMents)
           
            otpCancellables.dispose()
            
            self.parserVM.modelInfoKey = "UserLoginDetails"
            self.parserVM.progressBar.showIndicator()
            self.parserVM.parseApiRequest(request)
            
            
            self.parserVM.$responseHandler
                
                .eraseToAnyPublisher()
                .dropFirst() // for remove last datas stored in cancellable array
                .receive(on: DispatchQueue.main)
                .sink {  completion in
                 print(completion)
                } receiveValue: {[self] responseHandler in
                
                let message = responseHandler.message
                    self.parserVM.progressBar.hideIndicator()
                    self.resultHandler(responseHandler, message)
                    self.resetPage()
            }.store(in: &otpCancellables)
            
            

            
        }
        
       
        
    }
    
}

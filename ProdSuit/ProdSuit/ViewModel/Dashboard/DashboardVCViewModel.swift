//
//  DashboardVCViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 07/03/23.
//

import Foundation
import UIKit
import Combine

class DashboardVCViewModel{
    
    var preference = SharedPreference.Shared
    
    weak var controller : UIViewController? 
    
    var parserViewModel : APIParserManager = APIParserManager()
    
    var parserVm : GlobalAPIViewModel!
    
    var bannerDetailsList = [BannerDetailItemModel]()
    
    lazy var bannerCancellables = Set<AnyCancellable>()
    
    lazy var companyLogDetailsCancellable = Set<AnyCancellable>()
    
    lazy var notificationCancellable = Set<AnyCancellable>()
    
    
    
    init(controller:UIViewController,from:String="splash") {
        self.controller = controller
        self.parserVm = GlobalAPIViewModel(bgView: controller.view)
        
            
        
        //let dashboardVc = self.controller as! DashboardVC
        //bannerDetailsAPICall(vc: dashboardVc)
        
        
    }
    
   
    //MARK: - bannerDetailsAPICall()
    func bannerDetailsAPICall(vc:DashboardVC,_ vm:SetMpinVCViewModel?){
        let bankKey = preference.appBankKey
        let requestmode = RequestMode.shared.HomeBanner
        
        
        if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let ereqmode = instanceOfEncryptionPost.encryptUseDES(requestmode, key: SKey){
           let arguMents = ["BankKey":ebankKey,"ReqMode":ereqmode]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.homeBanners, arguMents: arguMents)
            if (vm != nil){
            vm?.setMpinCancellable.dispose()
            }
            
            
            self.parserVm.modelInfoKey = "BannerDetails"
            
            self.parserVm.parseApiRequest(request)
            
            self.parserVm.$responseHandler
                .dropFirst()
                
                .receive(on: DispatchQueue.main)
                .sink { responseHandler in
                    
                    
                    print(responseHandler.info)
                    
                    let bannerList = responseHandler.info.value(forKey: "BannerDetailsList")  as? [NSDictionary] ?? []

                    self.bannerDetailsList = []
                    self.bannerDetailsList = bannerList.map{ BannerDetailItemModel(datas: $0) }
                    
                    vc.imageSliderView.slidePageInitilizer(imageCounts: self.bannerDetailsList.count, imageList: self.bannerDetailsList, parserVM: self.parserVm)
                    vc.imageSliderView.start(count: self.bannerDetailsList.count)

                    
                    
                    self.bannerCancellables.dispose()
                    
                    self.companyLogDetailsAPICall(dashboardVC: vc)
                    
                }.store(in: &bannerCancellables)
        }
        
        
    }
    
    fileprivate func resultHandler(_ companyLogDetailInfo: CompanyLogDetailsModel,_ dashboardVC:DashboardVC) {
        
        let stackview = dashboardVC.companyLogNameLabel.superview as! UIStackView
        
        //dashboardVC.stackBGView.translatesAutoresizingMaskIntoConstraints = false
        
        //dashboardVC.dashCurveView.translatesAutoresizingMaskIntoConstraints = false
        
        if companyLogDetailInfo.DisplayType == "0"{
            
            dashboardVC.companyLogNameLabel.numberOfLines = 0
            dashboardVC.companyLogNameLabel.text  = ""
            
            dashboardVC.companyLogImageView.contentMode = .scaleAspectFit
            //dashboardVC.companyLogImageView.backgroundColor = UIColor.red
            stackview.spacing = 0
  
            stackview.distribution = .fillProportionally
            
    
            
        }else{
            
            dashboardVC.companyLogNameLabel.numberOfLines = 1
            //dashboardVC.companyLogNameLabel.frame.size.height = 20
            
            dashboardVC.companyLogNameLabel.text = companyLogDetailInfo.CompanyName
            stackview.spacing = 3
            stackview.distribution = .fillProportionally
            
        }
        
        let companyLogo = companyLogDetailInfo.CompanyLogo
        
        
        let encryptData = Data(base64Encoded: companyLogo)
        
        if let image = UIImage(data: encryptData!){
            
            dashboardVC.companyLogImageView.image = image.imageWithColor(color1: AppColor.Shared.companyLog)
        
        }
        
        dashboardVC.dashboardVM.notificationListApiCall()
    }
    
    func companyLogDetailsAPICall(dashboardVC:DashboardVC){
        
        let bankKey = preference.appBankKey
        let requestmode = RequestMode.shared.HomeCompanyLogo
        let token = preference.User_Token
        let id_user = "\(preference.User_ID_User)"
        
        if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let ereqmode = instanceOfEncryptionPost.encryptUseDES(requestmode, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let eid_user = instanceOfEncryptionPost.encryptUseDES(id_user, key: SKey){
            
            
            let arguMents = ["BankKey":ebankKey,"ReqMode":ereqmode,"Token":etoken,"FK_User":eid_user]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.homeCompanyLogoDetails, arguMents: arguMents)
            
            //self.bannerCancellables.dispose()
            self.parserVm.parseApiRequest(request)
            self.parserVm.modelInfoKey = "CompanyLogDetails"
            self.parserVm.$responseHandler
                
                .receive(on: DispatchQueue.main)
                .dropFirst()
                .sink { responseHandler in
                    
                    let companyLogDetailInfo = CompanyLogDetailsModel(datas: responseHandler.info)
                    
                    self.resultHandler(companyLogDetailInfo,dashboardVC)
                    
                    
                    print("logo info : \(companyLogDetailInfo)")
                }.store(in: &companyLogDetailsCancellable)
            
            
        }
        
        
    }
    
    
    //MARK: - notificationListApiCall()
     func notificationListApiCall(){
        
        let requestMode = RequestMode.shared.HomeNotificationList
        let bankKey = preference.appBankKey
        let id_user = "\(preference.User_ID_User)"
        let fk_company = "\(preference.User_FK_Company)"
        let token = preference.User_Token
        
        if let ereqMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let eid_user = instanceOfEncryptionPost.encryptUseDES(id_user, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey)
        {
            
            let arguMents = ["ReqMode":ereqMode,"BankKey":ebankKey,"Token":etoken,"FK_Company":efk_company,"FK_User":eid_user]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.homeNotificationList, arguMents: arguMents)
            self.companyLogDetailsCancellable.dispose()
            self.parserVm.parseApiRequest(request)
            self.parserVm.modelInfoKey = "NotificationDetails"
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    //print(responseHandler.info)
                    let dashboardVC = self.controller as! DashboardVC
                    let notficationInfo = responseHandler.info.value(forKey: "NotificationInfo") as? [NSDictionary] ?? []
                    dashboardVC.notificationList = []
                    dashboardVC.notificationList = notficationInfo.map{ NotificationDetailsInfo(datas: $0) }
                    
                    
                    
                    DispatchQueue.main.async {
                        
                        dashboardVC.collectionVW.reloadData()
                        
                    }
                    
                    print("notification count : \(dashboardVC.notificationList.count)")
                    
                }.store(in: &self.notificationCancellable)
        }
        
        
        
        
    }
    
    deinit{
        print("dashboard vm deallocate")
    }
}




//
//  SetMpinVCViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 03/03/23.
//

import Foundation
import UIKit
import Combine

class SetMpinVCViewModel{
    
    var parserViewModel : APIParserManager = APIParserManager()
    var parserVM : GlobalAPIViewModel!
    lazy var controller : UIViewController = {
        let controller = SetMpinVC()
        
        return controller
    }()
    
    var preference = SharedPreference.Shared
    lazy var setMpinCancellable = Set<AnyCancellable>()
    
    init(controller:UIViewController) {
        self.controller = controller
        self.parserVM = GlobalAPIViewModel(bgView: self.controller.view)
    }
    
    fileprivate func resetPage() {
        let setMpinVc = self.controller as! SetMpinVC
        setMpinVc.resetPage()
    }
    
    fileprivate func saveUserInfo(userdetailInfo:UserLoginDetailsModel,setMpinVc:SetMpinVC) {
        if self.preference.User_Token == ""{
            
            print("token :\(userdetailInfo.Token)")
            
            self.preference.User_Fk_Employee = userdetailInfo.FK_Employee
            self.preference.User_UserName = userdetailInfo.UserName
            self.preference.User_Address = userdetailInfo.Address
            self.preference.User_MobileNumber = userdetailInfo.MobileNumber
            self.preference.User_Token = userdetailInfo.Token
            
            
            self.preference.User_Email = userdetailInfo.Email
            self.preference.User_UserCode = userdetailInfo.UserCode
            self.preference.User_FK_Branch = userdetailInfo.FK_Branch
            self.preference.User_BranchName = userdetailInfo.BranchName
            self.preference.User_FK_BranchType = userdetailInfo.FK_BranchType
            self.preference.User_FK_DepartMent = userdetailInfo.FK_Department
            
            
            self.preference.User_FK_Company = userdetailInfo.FK_Company
            self.preference.User_FK_BranchCodeUser = userdetailInfo.FK_BranchCodeUser
            self.preference.User_FK_UserRole = userdetailInfo.FK_UserRole
            self.preference.User_UserRole = userdetailInfo.UserRole
            self.preference.User_IsAdmin = userdetailInfo.IsAdmin
            
            let loggedDate_Time =  Date()
            let stringLoggedDate = DateTimeModel.shared.string_Date_From_DateFormate(loggedDate_Time)
            self.preference.User_LoggedDate = stringLoggedDate
            
            self.preference.User_ID_User = userdetailInfo.ID_User
            self.preference.User_CompanyCategory = userdetailInfo.CompanyCategory
            
            
            self.preference.User_loc_LocLattitude = userdetailInfo.LocLattitude
            self.preference.User_loc_LocLongitude = userdetailInfo.LocLongitude
            self.preference.User_loc_LocLocationName = userdetailInfo.LocLocationName
             
            self.preference.User_EnteredDate = userdetailInfo.EnteredDate
            self.preference.User_EnteredTime = userdetailInfo.EnteredTime
            self.preference.User_Status = userdetailInfo.status
            
            self.preference.User_module_MASTER = userdetailInfo.moduleList.MASTER
            self.preference.User_module_SERVICE = userdetailInfo.moduleList.SERVICE
            self.preference.User_module_LEAD = userdetailInfo.moduleList.LEAD
            self.preference.User_module_INVENTORY = userdetailInfo.moduleList.INVENTORY
            self.preference.User_module_SETTINGS = userdetailInfo.moduleList.SETTINGS
            self.preference.User_module_SECURITY = userdetailInfo.moduleList.SECURITY
            self.preference.User_module_REPORT = userdetailInfo.moduleList.REPORT
            self.preference.User_module_PROJECT = userdetailInfo.moduleList.PROJECT
            self.preference.User_module_OTHER = userdetailInfo.moduleList.OTHER
            
            self.preference.User_module_PRODUCTION = userdetailInfo.moduleList.PRODUCTION
            self.preference.User_module_ACCOUNTS = userdetailInfo.moduleList.ACCOUNTS
            self.preference.User_module_ASSET = userdetailInfo.moduleList.ASSET
            self.preference.User_module_TOOL = userdetailInfo.moduleList.TOOL
            self.preference.User_module_VEHICLE = userdetailInfo.moduleList.VEHICLE
            self.preference.User_module_DELIVERY = userdetailInfo.moduleList.DELIVERY
            self.preference.User_module_HR = userdetailInfo.moduleList.HR
            
            self.preference.User_module_ATTANCE_MARKING = userdetailInfo.utilityList.ATTANCE_MARKING
            self.preference.User_module_LOCATION_TRACKING = userdetailInfo.utilityList.LOCATION_TRACKING
            self.preference.User_module_LOCATION_INTERVAL = userdetailInfo.utilityList.LOCATION_INTERVAL
            
            
        }else{
            print("saved token :\(userdetailInfo.Token)")
        }
        
        self.resetPage()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
            
            
            
            var navlist = self.controller.navigationController?.viewControllers
            
            let dashboardVC = AppVC.Shared.DashboardPage
//
//
//
//            dashboardVC.dashboardVM = DashboardVCViewModel(controller: dashboardVC)
//
//
//
//            dashboardVC.dashboardVM.bannerDetailsAPICall(vc: dashboardVC, self)
            
            navlist!.removeLast()
            navlist!.append(dashboardVC)
            self.controller.navigationController?.setViewControllers(navlist!, animated: true)
            
           // setMpinVc.moveToNextVc(nextController: dashboardVC)
        }
        
    }
    
    fileprivate func mpinSuccessPopup(message:String,userdetailInfo:UserLoginDetailsModel,setMpinVc:SetMpinVC){
        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{okaction in
            print("shared preference data save and go next page")
            
            self.saveUserInfo(userdetailInfo: userdetailInfo,setMpinVc:setMpinVc)
            
        },nil])
    }
   
    
    fileprivate func resultHandler(_ responseHandler: Published<successErrorHandler>.Publisher.Output, _ message: String,userdetailInfo:UserLoginDetailsModel) {
        if responseHandler.statusCode == 0{
            
            let setMpinModelInfo = SetMpinModel(datas: responseHandler.info)
            
            let setMpinVc = self.controller as! SetMpinVC
            self.controller.popupAlert(title: confirmationTitle, message: setMpinMessage, actionTitles: [no_cancel_title,yesTitle], actions: [{ action1 in
                
                self.resetPage()
            },{ action2 in
                
//                print("set mpin info: \(setMpinModelInfo)")
//                print("user_set_info_details : \(userdetailInfo)")
                self.mpinSuccessPopup(message: setMpinModelInfo.responseMessage, userdetailInfo: userdetailInfo,setMpinVc:setMpinVc)
                
            },nil])
            
        }else if responseHandler.statusCode == -11{
            
            print("setmpin info :\(responseHandler.info)")
            
        }else{
            
            self.controller.popupAlert(title: "", message: message, actionTitles: [closeTitle], actions: [{action1 in
                print("set mpin error \(message)")
            },nil])
            
        }
    }
    
    func setMpinOtpApiCall(token:String,mpin:String,fk_employee:String,userdetailInfo:UserLoginDetailsModel)  {
        
        let bankKey = preference.appBankKey
        let requestMode = RequestMode.shared.SetMPIN
        
        if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let eotp = instanceOfEncryptionPost.encryptUseDES(mpin, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey){
            
            let arguMents = ["BankKey":ebankKey,"FK_Employee":efk_employee,"Token":etoken,"ReqMode":erequestMode,"MPIN":eotp]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.setMpin_Verification,arguMents: arguMents)
            self.parserVM.modelInfoKey = "MPINDetails"
            self.parserVM.progressBar.showIndicator()
            self.parserVM.parseApiRequest(request)
            
            self.parserVM.$responseHandler
                .receive(on: DispatchQueue.main)
                
                .dropFirst()
                .sink { responseHandler in
                     
                    let message = responseHandler.message
                    
                    self.parserVM.progressBar.hideIndicator()
                    self.resultHandler(responseHandler, message,userdetailInfo:userdetailInfo)
                    
                    
                    
                }.store(in: &setMpinCancellable)
        }
            
           
        
    }
}

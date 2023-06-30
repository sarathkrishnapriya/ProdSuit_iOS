//
//  MpinVCViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 06/03/23.
//

import Foundation
import UIKit
import Combine

class MpinVCViewModel{
    
    var preference = SharedPreference.Shared
    var parserViewModel : APIParserManager = APIParserManager()
    var parserVm : GlobalAPIViewModel!
    weak var controller : UIViewController? = {
        let controller = MpinVC()
        
        return controller
    }()
    
    
    lazy var mpinCancellable = Set<AnyCancellable>()
    
    init(controller:UIViewController){
        self.controller = controller
        if let vc = self.controller{
            self.parserVm = GlobalAPIViewModel(bgView: vc.view)
        }
        
    }
    
    fileprivate func callDashboardPage(mpinVc:MpinVC) {
        let dashboardVC = AppVC.Shared.DashboardPage
        if !mpinVc.allControllers.contains(dashboardVC){
        
            
            mpinVc.moveToNextVc(nextController: dashboardVC)
        }else{
            print("home vc already added in navigation controller")
        }
        
        
    }
    
    fileprivate func saveUserInfo(_ userdetailInfo: UserLoginDetailsModel,mpinVc:MpinVC) {
        //print("userinfo :\(userdetailsInfo)")
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
        
        
        self.preference.User_FK_Company = userdetailInfo.FK_Company
        self.preference.User_FK_BranchCodeUser = userdetailInfo.FK_BranchCodeUser
        self.preference.User_FK_UserRole = userdetailInfo.FK_UserRole
        self.preference.User_UserRole = userdetailInfo.UserRole
        self.preference.User_IsAdmin = userdetailInfo.IsAdmin
        self.preference.User_FK_DepartMent = userdetailInfo.FK_Department
        
        
        self.preference.User_ID_User = userdetailInfo.ID_User
        self.preference.User_CompanyCategory = userdetailInfo.CompanyCategory
        
        let loggedDate_Time =  Date()
        let stringLoggedDate = DateTimeModel.shared.string_Date_From_DateFormate(loggedDate_Time)
        self.preference.User_LoggedDate = stringLoggedDate
        
        

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
        
        


//
//    case user_module_ATTANCE_MARKING = "ATTANCE_MARKING" // bool
//    case user_module_LOCATION_TRACKING = "LOCATION_TRACKING" // bool
//    case user_module_LOCATION_INTERVAL = "LOCATION_INTERVAL" // Int

        
        mpinVc.resetPage()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
            self.callDashboardPage(mpinVc: mpinVc)
        }
    }
    
    fileprivate func resultHandler(_ responseHandler: Publishers.Drop<Published<successErrorHandler>.Publisher>.Output, _ message: String) {
        
        let mpinVC = self.controller as! MpinVC
        if responseHandler.statusCode == 0{
            
            let userdetailInfo = UserLoginDetailsModel(datas: responseHandler.info)
            
            saveUserInfo(userdetailInfo, mpinVc: mpinVC)
            
            
            
        }else if responseHandler.statusCode == -11{
            
            print("verify mpin info :\(responseHandler.info)")
            
        }else{
            
            mpinVC.popupAlert(title: "", message: message, actionTitles: [closeTitle], actions: [{ action1 in
                print("verify mpin error found : \(message)")
                mpinVC.resetPage()
            },nil])
            
        }
    }
    
    func verifyMpinApiCall(token:String,fk_employee:String,mpin:String){
        
        let bankKey = preference.appBankKey
        let requestMode = RequestMode.shared.Mpin_Verification
        
        if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let ereqMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let empin = instanceOfEncryptionPost.encryptUseDES(mpin, key: SKey){
            
            let argMents = ["BankKey":ebankKey,"FK_Employee":efk_employee,"Token":etoken,"ReqMode":ereqMode,"MPIN":empin]
            
            lazy var request = parserViewModel.request(urlPath: URLPathList.Shared.verifyMpin,arguMents: argMents)
            self.mpinCancellable.dispose()
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.modelInfoKey = "UserLoginDetails"
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    print(responseHandler.info)
                    let message = responseHandler.message
                    self.parserVm.progressBar.hideIndicator()
                    self.resultHandler(responseHandler, message)
                }.store(in: &mpinCancellable)
            
        }
        
    }
}

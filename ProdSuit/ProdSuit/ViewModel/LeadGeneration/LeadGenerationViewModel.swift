//
//  LeadGenerationViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 10/04/23.
//


import Foundation
import UIKit
import Combine
import DropDown




class LeadGenerationVCViewModel{
    
    lazy var controller:LeadGenerationVC = {
        let vc = LeadGenerationVC()
        
        return vc
    }()
    
    lazy var parserViewModel : APIParserManager = APIParserManager()
    
    var parserVm : GlobalAPIViewModel!
    
    lazy var leadSourceCancellable = Set<AnyCancellable>()
    lazy var leadSourceDetailsCancellable = Set<AnyCancellable>()
    lazy var leadSubMediaCancellable = Set<AnyCancellable>()
    lazy var leadCollectedByUserCancellable = Set<AnyCancellable>()
    lazy var leadSearchByNameOrMobileCancellable = Set<AnyCancellable>()
    lazy var leadPincodeDetailsCancellable = Set<AnyCancellable>()
    lazy var leadCountryCancellable = Set<AnyCancellable>()
    lazy var leadStateCancellable = Set<AnyCancellable>()
    lazy var leadDistrictCancellable = Set<AnyCancellable>()
    lazy var leadAreaCancellable = Set<AnyCancellable>()
    lazy var leadPostCancellable = Set<AnyCancellable>()
    
    
    lazy var leadCategoryCancellable = Set<AnyCancellable>()
    lazy var leadProductCancellable = Set<AnyCancellable>()
    lazy var leadPriorityCancellable = Set<AnyCancellable>()
    lazy var leadProjectStatusCancellable = Set<AnyCancellable>()
    lazy var leadFollowUpTypeCancellable = Set<AnyCancellable>()
    lazy var leadEmployeeCancellable = Set<AnyCancellable>()
    lazy var uplodDocCancellable = Set<AnyCancellable>()
    lazy var leadGenerationCancellable = Set<AnyCancellable>()
    lazy var leadRequestCancellable = Set<AnyCancellable>()
    
    var selectedCountry : SelectedCountryDetails!
    let dropdown = DropDown()
    
    init(controller:LeadGenerationVC){
        
        self.controller = controller
        self.parserVm = GlobalAPIViewModel(bgView: self.controller.view)
        
        self.leadCollectedByUserAPICall()
        
        
    }
    
    //MARK: - ==== leadSourceApiCall() =====
    func leadSourceApiCall(){
        
        let requestMode = RequestMode.shared.LeadSource
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey){
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"FK_Employee":efk_employee,"Token":etoken]
            self.leadCollectedByUserCancellable.dispose()
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadSource,arguMents: arguMents)
            self.parserVm.progressBar.showIndicator()
            self.parserVm.modelInfoKey = "LeadFromDetailsList"
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
            
                .sink { responseHandler in
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    self.parserVm.progressBar.hideIndicator()
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "LeadFromDetails") as? [NSDictionary] ?? []
                        self.controller.leadFromDetailsInfoList = []
                        self.controller.leadFromDetailsInfoList = list.map{ LeadFromDetailsInfo(datas: $0) }
                        print(self.controller.leadFromDetailsInfoList)
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                    self.leadSourceCancellable.dispose()
                    
                    
                }.store(in: &leadSourceCancellable)
        }
        
    }
    
    
    //MARK: - ==== leadSourceDetailsListAPICall() =====
    func leadSourceDetailsListAPICall(id_leadFrom:String){
        
        let requestMode = RequestMode.shared.LeadSourceFrom
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let fk_company = "\(preference.User_FK_Company)"
        let entrBy = preference.User_UserCode // "EntrBy"
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let eentrBy = instanceOfEncryptionPost.encryptUseDES(entrBy, key: SKey),
           let eid_leadFrom = instanceOfEncryptionPost.encryptUseDES(id_leadFrom, key: SKey){
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"FK_Employee":efk_employee,"Token":etoken,"EntrBy":eentrBy,"FK_Company":efk_company,"ID_LeadFrom":eid_leadFrom]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadSourceFrom, arguMents: arguMents)
            
            self.parserVm.progressBar.showIndicator()
            self.parserVm.modelInfoKey = "LeadThroughDetailsList"
            self.parserVm.parseApiRequest(request)
            
            
            self.parserVm.$responseHandler
                .dropFirst()
            
                .sink { responseHandler in
                    self.parserVm.progressBar.hideIndicator()
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "LeadThroughDetails") as? [NSDictionary] ?? []
                        self.controller.leadThroughDetailsInfoList = []
                        self.controller.leadThroughDetailsInfoList = list.map{ LeadThroughDetailsInfo(datas: $0)}
                        //print(self.controller.leadThroughDetailsInfoList)
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                    self.leadSourceDetailsCancellable.dispose()
                }.store(in: &leadSourceDetailsCancellable)
            
            
        }
        
    }
    
    
    //MARK: - ==== leadSourceMediaSubMediaAPICall() =====
    func leadSourceMediaSubMediaAPICall(mediaMaster:String){
        let requestMode = RequestMode.shared.LeadSubMedia
        let bankKey = preference.appBankKey
        let fk_mediaMaster = "\(mediaMaster)"
        let token = preference.User_Token
        let fk_company = "\(preference.User_FK_Company)"
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let efk_mediaMaster = instanceOfEncryptionPost.encryptUseDES(fk_mediaMaster, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey){
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"FK_Company":efk_company,"Token":etoken,"FK_MediaMaster":efk_mediaMaster]
            
            self.parserVm.modelInfoKey = "SubMediaTypeDetails"
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadMediaSubmedia, arguMents: arguMents)
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    //print(responseHandler.info)
                    self.parserVm.progressBar.hideIndicator()
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "SubMediaTypeDetailsList") as? [NSDictionary] ?? []
                        self.controller.leadMediaSubMediaInfoList = []
                        self.controller.leadMediaSubMediaInfoList = list.map{ SubMediaTypeDetailsInfo(datas: $0) }
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                    self.leadSubMediaCancellable.dispose()
                }.store(in: &leadSubMediaCancellable)
            
            
        }
    }
    
    
    //MARK: - ==== leadCollectedByUserAPICall() =====
    func leadCollectedByUserAPICall(){
        let requestMode = RequestMode.shared.LeadCollectedByUser
        let bankKey = preference.appBankKey
        let fk_company = "\(preference.User_FK_Company)"
        let token = preference.User_Token
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"FK_Company":efk_company,"Token":etoken]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadCollectedByUser, arguMents: arguMents)
            self.parserVm.modelInfoKey = "CollectedByUsersList"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    self.parserVm.progressBar.hideIndicator()
                    print(responseHandler.info)
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "CollectedByUsers") as? [NSDictionary] ?? []
                        self.controller.leaduserCollectionInfoList = []
                        self.controller.leaduserCollectionInfoList = list.map{ CollectedByUsersInfo(datas: $0) }
                        
                        self.leadSourceApiCall()
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                }.store(in: &leadCollectedByUserCancellable)
            
            
        }
    }
    
    
    //MARK: - ======== searchByNameOrMobileAPICall() =========
    func searchByNameOrMobileAPICall(_ searchTxt:String,selectedType:SearchByNameOrMobileVM){
        
        
        let requestMode = RequestMode.shared.LeadCustomerSearchByNameOrMobile
        let bankKey = preference.appBankKey
        let fk_company = "\(preference.User_FK_Company)"
        let token = preference.User_Token
        let name = searchTxt
        let fk_employee = "\(preference.User_Fk_Employee)"
        let subMode = selectedType.submode
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let ename = instanceOfEncryptionPost.encryptUseDES(name, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let esubMode = instanceOfEncryptionPost.encryptUseDES(subMode, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"FK_Company":efk_company,"Token":etoken,"Name":ename,"FK_Employee":efk_employee,"SubMode":esubMode]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadCustomerSearchByNameOrMobile,arguMents:arguMents)
            
            self.parserVm.modelInfoKey = "CustomerDetailsList"
            
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    
                    self.parserVm.progressBar.hideIndicator()
                    
                    
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    
                    if statusCode == 0{
                        
                        self.controller.searchNameOrMobileText = ""
                        
                        let table = self.controller.leadGenerateTableView
                        let cell = table?.dequeueReusableCell(withIdentifier: CellIdentifier.shared.leadCustomerDetailCell1) as! CustomerDetailsTVC1
                        cell.searchTF.text = ""
                        table?.reloadSections(IndexSet(integer: 1), with: .none)
                        
                        let list = responseHandler.info.value(forKey: "CustomerDetails") as? [NSDictionary] ?? []
                        
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                            self.showCustomerSearchList(list: list, mode: subMode)
                        }
                        
                        
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [closeTitle], actions: [{action1 in
                            print("no data found")
                        },nil])
                    }
                    
                    self.leadSearchByNameOrMobileCancellable.dispose()
                    
                }.store(in: &leadSearchByNameOrMobileCancellable)
            
            
        }
        
        
    }
    
    //MARK: - =======  pincodeValidationAPICall() =======
    func pincodeValidationAPICall(pincode:String){
        
        
        let requestMode = RequestMode.shared.LeadPinCodeDetails
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let pinCode = pincode
        let fk_company = "\(preference.User_FK_Company)"
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let epinCode = instanceOfEncryptionPost.encryptUseDES(pinCode, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey){
            
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"FK_Company":efk_company,"Token":etoken,"Pincode":epinCode,"FK_Employee":efk_employee]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadPincodeDetails,arguMents: arguMents)
            self.parserVm.modelInfoKey = "PincodeDetails"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    let message = responseHandler.message
                    let statusCode = responseHandler.statusCode
                    self.parserVm.progressBar.hideIndicator()
                    if statusCode == 0{
                        
                        let list = responseHandler.info.value(forKey: "PincodeDetailsList") as? [NSDictionary] ?? []
                        let table = self.controller.leadGenerateTableView
                        let cell = table?.dequeueReusableCell(withIdentifier: CellIdentifier.shared.leadMoreCommunicationInfoCell) as! MoreCommunicationInfoTVC
                        cell.pincodeTF.text = ""
                        self.controller.moreInfoPinCode = ""
                        table?.reloadSections(IndexSet(integer: 2), with: .none)
                        self.controller.pincodeDetailsList = []
                        
                        self.controller.pincodeDetailsList = list.map{  PincodeDetailsListInfo(datas: $0) }
                        
                        print("pincode List count:\(self.controller.pincodeDetailsList.count)")
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                            self.pincodePopUpPageCall(list: self.controller.pincodeDetailsList, pincode:pincode)
                        }
                        
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in
                            print("no data found pin code search")
                        },nil])
                    }
                    
                    self.leadPincodeDetailsCancellable.dispose()
                }.store(in: &leadPincodeDetailsCancellable)
            
        }
        
        
    }
    
    //MARK: - ======= countryListingAPICall() =========
    func countryListingAPICall(){
        
        let requestMode = RequestMode.shared.LeadCountryDetails
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let subMode = SubMode.Shared.leadCountry
        let fk_company = "\(preference.User_FK_Company)"
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let esubMode = instanceOfEncryptionPost.encryptUseDES(subMode, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"SubMode":esubMode,"FK_Employee":efk_employee,"FK_Company":efk_company]
            
            self.parserVm.modelInfoKey = "CountryDetails"
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadCountryDetails,arguMents: arguMents)
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    self.parserVm.progressBar.hideIndicator()
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "CountryDetailsList") as? [NSDictionary] ?? []
                        
                        self.controller.countryDetailsList = []
                        
                        self.controller.countryDetailsList = list.map{ CountryDetailsListInfo(datas: $0) }
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                            self.countryDetailsPopUPPageCall(list: self.controller.countryDetailsList)
                        }
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                    self.leadCountryCancellable.dispose()
                    
                }.store(in: &leadCountryCancellable)
            
        }
        
        
        
        
    }
    
    //MARK: - ======= stateListingAPICall() =========
    func stateListingAPICall(){
        
        let requestMode = RequestMode.shared.LeadStatDetails
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let subMode = SubMode.Shared.leadState
        let fk_company = "\(preference.User_FK_Company)"
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let esubMode = instanceOfEncryptionPost.encryptUseDES(subMode, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"SubMode":esubMode,"FK_Employee":efk_employee,"FK_Company":efk_company]
            
            
            let request  = self.parserViewModel.request(urlPath: URLPathList.Shared.leadStatDetails,arguMents:arguMents)
            
            self.parserVm.modelInfoKey = "StatesDetails"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    self.parserVm.progressBar.hideIndicator()
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "StatesDetailsList") as? [NSDictionary] ?? []
                        
                        self.controller.stateDetailsList = []
                        
                        self.controller.stateDetailsList = list.map{ StatesDetailsListInfo(datas: $0) }
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            self.stateDetailsPopUPPageCall(list: self.controller.stateDetailsList)
                        }
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                    self.leadStateCancellable.dispose()
                }.store(in: &leadStateCancellable)
        }
        
    }
    
    //MARK: - ======= districtListingAPICall() =========
    func districtListingAPICall(){
        
        let requestMode = RequestMode.shared.LeadDistrictDetails
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let subMode = SubMode.Shared.leadDistrict
        let fk_company = "\(preference.User_FK_Company)"
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let esubMode = instanceOfEncryptionPost.encryptUseDES(subMode, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"SubMode":esubMode,"FK_Employee":efk_employee,"FK_Company":efk_company]
            
            
            let request  = self.parserViewModel.request(urlPath: URLPathList.Shared.leadDistrictDetails,arguMents:arguMents)
            
            self.parserVm.modelInfoKey = "DistrictDetails"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    
                    
                    print(responseHandler.info)
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    self.parserVm.progressBar.hideIndicator()
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "DistrictDetailsList") as? [NSDictionary] ?? []
                        
                        self.controller.districtDetailsList = []
                        
                        self.controller.districtDetailsList = list.map{ DistrictDetailsListInfo(datas: $0) }
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            self.districtDetailsPopUPPageCall(list: self.controller.districtDetailsList)
                        }
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                    self.leadDistrictCancellable.dispose()
                }.store(in: &leadDistrictCancellable)
            
        }
        
        
        
    }
    
    //MARK: - ======= areaListingAPICall() =========
    func areaListingAPICall(){
        
        let requestMode = RequestMode.shared.LeadAreaDetails
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let subMode = SubMode.Shared.leadArea
        let fk_company = "\(preference.User_FK_Company)"
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let esubMode = instanceOfEncryptionPost.encryptUseDES(subMode, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"SubMode":esubMode,"FK_Employee":efk_employee,"FK_Company":efk_company]
            
            let request  = self.parserViewModel.request(urlPath: URLPathList.Shared.leadAreaDetails,arguMents:arguMents)
            self.parserVm.modelInfoKey = "AreaDetails"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    
                    
                    print(responseHandler.info)
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    self.parserVm.progressBar.hideIndicator()
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "AreaDetailsList") as? [NSDictionary] ?? []
                        
                        
                        self.controller.areaDetailsList = []
                        
                        self.controller.areaDetailsList = list.map{ AreaDetailsListInfo(datas: $0) }
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            self.areaDetailsPopUPPageCall(list: self.controller.areaDetailsList)
                        }
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                    self.leadAreaCancellable.dispose()
                }.store(in: &leadAreaCancellable)
            
        }
        
    }
    
    //MARK: - ======= postListingAPICall() =========
    func postListingAPICall(){
        
        let requestMode = RequestMode.shared.LeadPostDetails
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let subMode = SubMode.Shared.leadPost
        let fk_company = "\(preference.User_FK_Company)"
        
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let esubMode = instanceOfEncryptionPost.encryptUseDES(subMode, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"SubMode":esubMode,"FK_Employee":efk_employee,"FK_Company":efk_company]
            
            let request  = self.parserViewModel.request(urlPath: URLPathList.Shared.leadPostDetails,arguMents:arguMents)
            self.parserVm.modelInfoKey = "PostDetails"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    
                    
                    print(responseHandler.info)
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    self.parserVm.progressBar.hideIndicator()
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "PostDetailsList") as? [NSDictionary] ?? []
                        
                        self.controller.postDetailsList = []
                        
                        self.controller.postDetailsList = list.map{ PostDetailsListInfo(datas: $0) }
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            self.postDetailsPopUPPageCall(list: self.controller.postDetailsList)
                        }
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                    self.leadPostCancellable.dispose()
                }.store(in: &leadPostCancellable)
            
        }
        
    }
    
    func countryDetailsPopUPPageCall(list:[CountryDetailsListInfo]){
        
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.Country
            
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            
            //            self.controller.selectedDefaultValue = SelectedLeadGenerationDefaultValue(FK_Country:item.FK_Country,Country:item.Country)
            self.selectedCountry = SelectedCountryDetails(FK_Country: item.FK_Country, Country: item.Country)
            self.controller.selectedDefaultValue.FK_Country = self.selectedCountry.FK_Country
            self.controller.selectedDefaultValue.Country = self.selectedCountry.Country
            
            self.controller.selectedDefaultValue.FK_States = 0
            self.controller.selectedDefaultValue.StateName = ""
            
            self.controller.selectedDefaultValue.FK_District = 0
            self.controller.selectedDefaultValue.DistrictName = ""
            
            self.controller.selectedDefaultValue.FK_Area = 0
            self.controller.selectedDefaultValue.Area = ""
            
            self.controller.selectedDefaultValue.PostID = 0
            self.controller.selectedDefaultValue.PostName = ""
            
            print(self.controller.selectedDefaultValue)
            
        }
        
        popUpVC.listingTitleString = "SELECT COUNTRY"
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popUpVC, animated: true)
        
        
    }
    
    
    func stateDetailsPopUPPageCall(list:[StatesDetailsListInfo]){
        
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.States
            
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            
            self.controller.selectedDefaultValue.FK_States = item.FK_States
            self.controller.selectedDefaultValue.StateName = item.States
            
            self.controller.selectedDefaultValue.FK_District = 0
            self.controller.selectedDefaultValue.DistrictName = ""
            
            self.controller.selectedDefaultValue.FK_Area = 0
            self.controller.selectedDefaultValue.Area = ""
            
            self.controller.selectedDefaultValue.PostID = 0
            self.controller.selectedDefaultValue.PostName = ""
            print(self.controller.selectedDefaultValue)
        }
        
        popUpVC.listingTitleString = "SELECT STATE"
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popUpVC, animated: true)
        
        
    }
    
    func districtDetailsPopUPPageCall(list:[DistrictDetailsListInfo]){
        
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.District
            
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            
            
            
            self.controller.selectedDefaultValue.FK_District = item.FK_District
            self.controller.selectedDefaultValue.DistrictName = item.District
            
            self.controller.selectedDefaultValue.FK_Area = 0
            self.controller.selectedDefaultValue.Area = ""
            
            self.controller.selectedDefaultValue.PostID = 0
            self.controller.selectedDefaultValue.PostName = ""
            print(self.controller.selectedDefaultValue)
        }
        
        popUpVC.listingTitleString = "SELECT DISTRICT"
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popUpVC, animated: true)
        
        
    }
    
    func areaDetailsPopUPPageCall(list:[AreaDetailsListInfo]){
        
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.Area
            
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            
            
            
            
            
            self.controller.selectedDefaultValue.FK_Area = item.FK_Area
            self.controller.selectedDefaultValue.Area = item.Area
            
            self.controller.selectedDefaultValue.PostID = 0
            self.controller.selectedDefaultValue.PostName = ""
            print(self.controller.selectedDefaultValue)
        }
        
        popUpVC.listingTitleString = "SELECT AREA"
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popUpVC, animated: true)
        
        
    }
    
    
    func postDetailsPopUPPageCall(list:[PostDetailsListInfo]){
        
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.PostName
            cell.detailsLabel.text = item.PinCode
            
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            
            
            self.controller.selectedDefaultValue.PostID = item.FK_Post
            self.controller.selectedDefaultValue.PostName = item.PostName
            self.controller.moreInfoPinCode = item.PinCode
            self.controller.selectedDefaultValue.Pincode = self.controller.moreInfoPinCode
            print(self.controller.selectedDefaultValue)
        }
        
        popUpVC.listingTitleString = "SELECT POST"
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popUpVC, animated: true)
        
        
    }
    
    
    func pincodePopUpPageCall(list:[PincodeDetailsListInfo],pincode:String){
        
        let popUPVc = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table) in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.Post
            
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            print(item)
            
            self.controller.selectedDefaultValue.FK_Country = item.FK_Country
            self.controller.selectedDefaultValue.Country = item.Country
            
            self.controller.selectedDefaultValue.FK_States = item.FK_States
            self.controller.selectedDefaultValue.StateName = item.States
            
            self.controller.selectedDefaultValue.FK_District = item.FK_District
            self.controller.selectedDefaultValue.DistrictName = item.District
            
            self.controller.selectedDefaultValue.FK_Area = item.FK_Area
            self.controller.selectedDefaultValue.Area = item.Area
            
            self.controller.selectedDefaultValue.PostID = item.FK_Post
            self.controller.selectedDefaultValue.PostName = item.Post
            
            self.controller.selectedDefaultValue.Pincode = pincode
            
            self.controller.selectedDefaultValue.FK_Place = item.FK_Place
            self.controller.selectedDefaultValue.Place = item.Place
            
            
            
            
        }
        
        popUPVc.listingTitleString = "POST"
        popUPVc.modalTransitionStyle = .coverVertical
        popUPVc.modalPresentationStyle = .overCurrentContext
        self.controller.present(popUPVc, animated: true)
        
        
    }
    
    //MARK: - ========= LEAD DETAILS CELL DETAILS ==============
    func cellConfigurationLeadDetails(cell:LeadGenerationTVC,_ type:Int,placeholderTxt:String){
        
        cell.leadSourceFromTextField.customPlaceholder(color:AppColor.Shared.greyText,text: placeholderTxt)
        
        switch type{
        case 0:
            cell.hasLeadSourceFrom = true
            cell.leadSourceFromTextField.addDonButton()
            cell.leadSourceFromTextField.sourceDetailsButton.isHidden = true
            cell.leadSourceFromTextField.rightView = nil
            cell.leadSourceFromTextField.becomeFirstResponder()
            
        case 1:
            cell.hasLeadSourceFrom = true
            cell.leadSourceFromTextField.sourceDetailsButton.isHidden = false
            cell.leadSourceFromTextField.rightView = cell.leadSourceFromTextField.rightSideImageView
            
        case 2:
            cell.hasLeadSourceFrom = false
            
        default:
            cell.hasLeadSourceFrom = false
        }
        
        
        
        
    }
    
    
    func showCustomerSearchList(list:[NSDictionary],mode:String){
        
        
        if mode == "1"{
            
            self.controller.leadCustomerSearchNameInfoList = []
            self.controller.leadCustomerSearchNameInfoList = list.map{CustomerDetailsInfo<String>(datas: $0) }
            
            let popUPTableVC = ReusableTableVC(items: self.controller.leadCustomerSearchNameInfoList) { (cell:SubtitleTableViewCell, userList, table) in
                cell.addcontentView(cell: cell)
                
                //let indexLevel = table.indexPath(for: cell)
                if let index = cell.tag as? Int{
                    cell.indexLabel.text = "\(index + 1)"
                    
                }
                cell.titleLabel.text = userList.CusName
                cell.detailsLabel.text = userList.CusAddress1
                cell.accessoryType = .disclosureIndicator
                UIView.animate(withDuration: 0.1) {
                    cell.layoutIfNeeded()
                }
            } selectHandler: { userList in
                
                print(userList)
//                self.controller.selecteCustomerDetailsInfo = SelectedCustomerDetailsInfo(ID_Customer: userList.ID_Customer, CusNameTitle: userList.CusNameTitle, CusName: userList.CusName, CusAddress1: userList.CusAddress1, CusAddress2: userList.CusAddress2, CusEmail: userList.CusEmail, CusPhnNo: userList.CusPhnNo, Company: userList.Company, CountryID: userList.CountryID, CntryName: userList.CntryName, StatesID: userList.StatesID, StName: userList.StName, DistrictID: userList.DistrictID, DtName: userList.DtName, PostID: userList.PostID, PostName: userList.PostName, FK_Area: userList.FK_Area, Area: userList.Area, CusMobileAlternate: userList.CusMobileAlternate, Pincode: userList.Pincode, Customer_Type: userList.Customer_Type)
                
                self.controller.selecteCustomerDetailsInfo.ID_Customer = userList.ID_Customer
                self.controller.selecteCustomerDetailsInfo.CusNameTitle = userList.CusNameTitle
                self.controller.selecteCustomerDetailsInfo.CusName = userList.CusName
                self.controller.selecteCustomerDetailsInfo.CusAddress1 = userList.CusAddress1
                self.controller.selecteCustomerDetailsInfo.CusAddress2 = userList.CusAddress2
                self.controller.selecteCustomerDetailsInfo.CusEmail = userList.CusEmail
                self.controller.selecteCustomerDetailsInfo.CusPhnNo = userList.CusPhnNo
                self.controller.selecteCustomerDetailsInfo.Company = userList.Company
                self.controller.selecteCustomerDetailsInfo.CountryID = userList.CountryID
                self.controller.selecteCustomerDetailsInfo.CntryName = userList.CntryName
                self.controller.selecteCustomerDetailsInfo.StatesID = userList.StatesID
                self.controller.selecteCustomerDetailsInfo.StName = userList.StName
                self.controller.selecteCustomerDetailsInfo.DistrictID = userList.DistrictID
                self.controller.selecteCustomerDetailsInfo.DtName = userList.DtName
                self.controller.selecteCustomerDetailsInfo.PostID = userList.PostID
                self.controller.selecteCustomerDetailsInfo.PostName = userList.PostName
                self.controller.selecteCustomerDetailsInfo.FK_Area = userList.FK_Area
                self.controller.selecteCustomerDetailsInfo.Area = userList.Area
                self.controller.selecteCustomerDetailsInfo.CusMobileAlternate = userList.CusMobileAlternate
                self.controller.selecteCustomerDetailsInfo.Pincode = userList.Pincode
                self.controller.selecteCustomerDetailsInfo.Customer_Type = userList.Customer_Type
                
                
                
                self.controller.selectedDefaultValue.FK_Country = userList.CountryID
                self.controller.selectedDefaultValue.Country = userList.CntryName
                self.controller.selectedDefaultValue.FK_States = userList.StatesID
                self.controller.selectedDefaultValue.StateName = userList.StName
                self.controller.selectedDefaultValue.FK_District = userList.DistrictID
                self.controller.selectedDefaultValue.DistrictName = userList.DtName
                self.controller.selectedDefaultValue.FK_Area = userList.FK_Area
                self.controller.selectedDefaultValue.Area = userList.Area
                self.controller.selectedDefaultValue.PostID = userList.PostID
                self.controller.selectedDefaultValue.PostName = userList.PostName
                self.controller.selectedDefaultValue.Pincode = userList.Pincode
                self.controller.selectedDefaultValue.address = userList.CusAddress1
                
            }
            
            popUPTableVC.listingTitleString = "CUSTOMER"
            
            popUPTableVC.modalPresentationStyle = .overCurrentContext
           
            self.controller.present(popUPTableVC, animated: false)
        
            
        }else{
            
            self.controller.leadCustomerSearchPhoneInfoList = []
            self.controller.leadCustomerSearchPhoneInfoList = list.map{CustomerDetailsInfo<Int>(datas: $0) }
            
            let popUPTableVC = ReusableTableVC(items:  self.controller.leadCustomerSearchPhoneInfoList) { (cell:SubtitleTableViewCell, userList, table) in
                cell.addcontentView(cell: cell)
                
                //let indexLevel = table.indexPath(for: cell)
                if let index = cell.tag as? Int{
                    cell.indexLabel.text = "\(index + 1)"
                    
                }
                cell.titleLabel.text = userList.CusName
                cell.detailsLabel.text = userList.CusPhnNo
                cell.accessoryType = .disclosureIndicator
                UIView.animate(withDuration: 0.1) {
                    cell.layoutIfNeeded()
                }
            } selectHandler: { userList in
                print(userList)
//                self.controller.selecteCustomerDetailsInfo = SelectedCustomerDetailsInfo(ID_Customer: userList.ID_Customer, CusNameTitle: userList.CusNameTitle, CusName: userList.CusName, CusAddress1: userList.CusAddress1, CusAddress2: userList.CusAddress2, CusEmail: userList.CusEmail, CusPhnNo: userList.CusPhnNo, Company: userList.Company, CountryID: userList.CountryID, CntryName: userList.CntryName, StatesID: userList.StatesID, StName: userList.StName, DistrictID: userList.DistrictID, DtName: userList.DtName, PostID: userList.PostID, PostName: userList.PostName, FK_Area: userList.FK_Area, Area: userList.Area, CusMobileAlternate: userList.CusMobileAlternate, Pincode: userList.Pincode, Customer_Type: userList.Customer_Type)
                
                self.controller.selecteCustomerDetailsInfo.ID_Customer = userList.ID_Customer
                self.controller.selecteCustomerDetailsInfo.CusNameTitle = userList.CusNameTitle
                self.controller.selecteCustomerDetailsInfo.CusName = userList.CusName
                self.controller.selecteCustomerDetailsInfo.CusAddress1 = userList.CusAddress1
                self.controller.selecteCustomerDetailsInfo.CusAddress2 = userList.CusAddress2
                self.controller.selecteCustomerDetailsInfo.CusEmail = userList.CusEmail
                self.controller.selecteCustomerDetailsInfo.CusPhnNo = userList.CusPhnNo
                self.controller.selecteCustomerDetailsInfo.Company = userList.Company
                self.controller.selecteCustomerDetailsInfo.CountryID = userList.CountryID
                self.controller.selecteCustomerDetailsInfo.CntryName = userList.CntryName
                self.controller.selecteCustomerDetailsInfo.StatesID = userList.StatesID
                self.controller.selecteCustomerDetailsInfo.StName = userList.StName
                self.controller.selecteCustomerDetailsInfo.DistrictID = userList.DistrictID
                self.controller.selecteCustomerDetailsInfo.DtName = userList.DtName
                self.controller.selecteCustomerDetailsInfo.PostID = userList.PostID
                self.controller.selecteCustomerDetailsInfo.PostName = userList.PostName
                self.controller.selecteCustomerDetailsInfo.FK_Area = userList.FK_Area
                self.controller.selecteCustomerDetailsInfo.Area = userList.Area
                self.controller.selecteCustomerDetailsInfo.CusMobileAlternate = userList.CusMobileAlternate
                self.controller.selecteCustomerDetailsInfo.Pincode = userList.Pincode
                self.controller.selecteCustomerDetailsInfo.Customer_Type = userList.Customer_Type
                
                self.controller.selectedDefaultValue.FK_Country = userList.CountryID
                self.controller.selectedDefaultValue.Country = userList.CntryName
                self.controller.selectedDefaultValue.FK_States = userList.StatesID
                self.controller.selectedDefaultValue.StateName = userList.StName
                self.controller.selectedDefaultValue.FK_District = userList.DistrictID
                self.controller.selectedDefaultValue.DistrictName = userList.DtName
                self.controller.selectedDefaultValue.FK_Area = userList.FK_Area
                self.controller.selectedDefaultValue.Area = userList.Area
                self.controller.selectedDefaultValue.PostID = userList.PostID
                self.controller.selectedDefaultValue.PostName = userList.PostName
                self.controller.selectedDefaultValue.Pincode = userList.Pincode
                self.controller.selectedDefaultValue.address = userList.CusAddress1
            }
            
            popUPTableVC.listingTitleString = "CUSTOMER"
            popUPTableVC.modalTransitionStyle = .coverVertical
            popUPTableVC.modalPresentationStyle = .overCurrentContext
            self.controller.present(popUPTableVC, animated: true)
            
            
        }
    }
    
     func userCollectedByAction(){
        //print("user select from list")
        
        let popupTableVC = ReusableTableVC(items: self.controller.leaduserCollectionInfoList) { (cell:SubtitleTableViewCell, collectData, table) in
            
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = collectData.Name
            cell.detailsLabel.text = collectData.DesignationName
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
            
        } selectHandler: { collectData in
            //SelectedUserFromCollectionDetails(ID_CollectedBy: collectData.ID_CollectedBy, Name: collectData.Name, DepartmentName: collectData.DepartmentName, DesignationName: collectData.DesignationName)
            self.controller.selectedUserFromCollectionList.ID_CollectedBy = collectData.ID_CollectedBy
            self.controller.selectedUserFromCollectionList.Name = collectData.Name
            self.controller.selectedUserFromCollectionList.DepartmentName = collectData.DepartmentName
            self.controller.selectedUserFromCollectionList.DesignationName = collectData.DesignationName
            print(collectData)
        }
        
        popupTableVC.listingTitleString = "COLLECTED BY"
        popupTableVC.modalTransitionStyle = .coverVertical
        popupTableVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popupTableVC, animated: true)
        
    }
    
    
    
     func sourceDetailsSubMediaListing(){
        
        let popupTableVC = ReusableTableVC(items: self.controller.leadMediaSubMediaInfoList) { (cell:SubtitleTableViewCell, subMedia, table) in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = subMedia.SubMdaName
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { subMedia in
            //print(subMedia)
            self.controller.selectedSubMedia = SelectedSubMediaDetails(ID_MediaSubMaster: subMedia.ID_MediaSubMaster, SubMdaName: subMedia.SubMdaName)
        }
        
        
        popupTableVC.listingTitleString = "SUB MEDIA"
        popupTableVC.modalTransitionStyle = .coverVertical
        popupTableVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popupTableVC, animated: true)
        
    }
    
     func sourceDetailsListing(){
        
        self.controller.selectedSubMedia = SelectedSubMediaDetails(ID_MediaSubMaster: -1, SubMdaName: "")
        
        let popupTableVC = ReusableTableVC(items: self.controller.leadThroughDetailsInfoList) { (cell:SubtitleTableViewCell, leadThrough, table) in
            
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = leadThrough.LeadThroughName
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
            
        } selectHandler: { leadThrough in
            
            self.controller.selectedLeadThrough = SelectedLeadThroughDetails(ID_LeadThrough: leadThrough.ID_LeadThrough, LeadThroughName: leadThrough.LeadThroughName, HasSub: leadThrough.HasSub)
            if leadThrough.HasSub == 1{
            self.leadSourceMediaSubMediaAPICall(mediaMaster: "\(self.controller.selectedLeadThrough.ID_LeadThrough)")
            }
            print(self.controller.selectedLeadThrough)
        }
        
        popupTableVC.listingTitleString = "LEAD THROUGH"
        popupTableVC.modalTransitionStyle = .coverVertical
        popupTableVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popupTableVC, animated: true)
        
    }
    
      func sourceListing(){
        
        self.controller.selectedLeadThrough = SelectedLeadThroughDetails(ID_LeadThrough: -1, LeadThroughName: "", HasSub: -1)
        
        self.controller.view.endEditing(true)
        
        let reusableTableVC = ReusableTableVC(items: self.controller.leadFromDetailsInfoList) {
            
            (cell: SubtitleTableViewCell, leadSource, table) in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = leadSource.LeadFromName
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
            
        } selectHandler: { (leadSource) in
            
            self.controller.selectedLeadSourceInfo = LeadFromSelectedInfo(ID_LeadFrom: leadSource.ID_LeadFrom, LeadFromName: leadSource.LeadFromName, LeadFromType: leadSource.LeadFromType)
            
            print(self.controller.selectedLeadSourceInfo)
            if leadSource.LeadFromType == 1{
            self.leadSourceDetailsListAPICall(id_leadFrom: "\(leadSource.ID_LeadFrom)")
            }
            
        }
        
        
        reusableTableVC.listingTitleString = "LEAD FROM"
        reusableTableVC.modalTransitionStyle = .coverVertical
        reusableTableVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(reusableTableVC, animated: true)
        
        
    }
    
    //MARK: - ========= CUSTOMER DETAILS SEACH BY NAME MOBILE CELL DETAILS ==============
    func cellConfigurationOne(cell:CustomerDetailsTVC1){
        
        
        cell.searchTF.keyboardType = self.controller.selectedCustomerSearchString == "Mobile"  ? .numberPad : .namePhonePad
        
    }
    
     func searchCustomerNameOrMobileAction(){
        self.controller.view.endEditing(true)
        print(self.controller.searchNameOrMobileText)
        let type = self.controller.selectedCustomerSearchString == "" ? "Name" : self.controller.selectedCustomerSearchString
        let searchSelectedTypeModel = self.controller.searchSelectedType(type)
        
        let typeString = self.controller.selectedCustomerSearchString == "" ? "Name" : self.controller.selectedCustomerSearchString
        if self.controller.searchNameOrMobileText == ""{
            self.controller.popupAlert(title: "", message: "Customer \(typeString) cannot be blank", actionTitles: [okTitle], actions: [{action1 in
            },nil])
        }else{
            self.searchByNameOrMobileAPICall(self.controller.searchNameOrMobileText, selectedType: searchSelectedTypeModel)
        }
    }
    
     func searchByNameOrMobile(_ sender: UIButton){
        
        self.dropdown.anchorView = sender.plainView
        self.dropdown.dataSource = self.controller.searchNameorMobileList
        dropdown.show()
        self.dropdown.bottomOffset = CGPoint(x: 0, y:(dropdown.anchorView?.plainView.bounds.height)!)
        dropdown.direction = .bottom
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            // self.lblTitle.text = fruitsArray[index]
            
            self.controller.selectedCustomerSearchString = item
            let selectedItem = self.controller.searchSelectedType(item)
            
            print("Selected item: \(selectedItem.name) at mode: \(selectedItem.submode)")
        }
    }
    
    //MARK: - ========= CUSTOMER DETAILS CELL DETAILS ==============
    func cellConfiurationThree(cell:CustomerDetailsTVC3){
        
        if self.controller.selectedHonorificString == ""{
            self.controller.selectedHonorificString = "Mr"
        }
        cell.respectTF.text = self.controller.selectedHonorificString == "" ? "Mr" : self.controller.selectedHonorificString
        
        cell.customerNameTF.text = self.controller.selecteCustomerDetailsInfo.CusName
        cell.contactNumberTF.text = self.controller.selecteCustomerDetailsInfo.CusPhnNo
        cell.emailTF.text = self.controller.selecteCustomerDetailsInfo.CusEmail
        cell.whatsAppNumberTF.text = self.controller.selecteCustomerDetailsInfo.whatsapp
        cell.companyTF.text = self.controller.selecteCustomerDetailsInfo.Company
        
        
        
        print(cell.frame.origin.x)
    }
    
     func honorificsAction(sender:UIButton){
        
        self.controller.view.endEditing(true)
        
        self.dropdown.anchorView = sender.plainView
        self.dropdown.dataSource = self.controller.honorificsList
        self.dropdown.show()
        self.dropdown.bottomOffset = CGPoint(x: 0, y:(dropdown.anchorView?.plainView.bounds.height)!)
        dropdown.direction = .bottom
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            // self.lblTitle.text = fruitsArray[index]
            
            self.controller.selectedHonorificString = item
            
            
            print("Selected honorString item: \(self.controller.selectedHonorificString)")
            
        }
        
        
        
        
        
    }
    
    //MARK: - ========= MORE INFO CELL DETAILS ==============
    func moreInfoCell(cell:MoreCommunicationInfoTVC,info:SelectedLeadGenerationDefaultValue){
        
        
        
        if info.Country != ""{
            cell.countryTF.text = info.Country
        }
        
        if info.StateName != ""{
            cell.stateTF.text = info.StateName
        }
        
        if info.DistrictName != ""{
            cell.districtTF.text = info.DistrictName
        }
        
        if info.address != ""{
            cell.houseNameTF.text = info.address
        }
        
        if info.Pincode != ""{
            cell.pincodeTF.text = info.Pincode
            controller.moreInfoPinCode = info.Pincode ?? ""
        }
        
        
        
        if info.Area != ""{
            cell.locationTF.text = info.Area
        }
        
        if info.PostName != ""{
            cell.postTF.text = info.PostName
        }
        
        if info.Place != ""{
            cell.placeNameTF.text = info.Place
        }
        
        
        
        
        
        
    }
    
    
   
    
    // <==================================== PROJECT PRODUCT  DETAILS ===========================================>
    
    //MARK: - categoryListAPICall()
    func categoryListAPICall(){
        
        let requestMode = RequestMode.shared.LeadCategory
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        
        let fk_company = "\(preference.User_FK_Company)"
        
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           
            let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadCategory,arguMents: arguMents)
            
            self.parserVm.modelInfoKey = "CategoryDetailsList"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    self.parserVm.progressBar.hideIndicator()
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "CategoryList") as? [NSDictionary] ?? []
                        
                        self.controller.categoryList = []
                        
                        self.controller.categoryList = list.map{ CategoryListInfo(datas: $0) }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.categoryListPopUPPageCall(list: self.controller.categoryList)
                        }
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                    
                    
                    self.leadCategoryCancellable.dispose()
                }.store(in: &leadCategoryCancellable)
            
        }
        
    }
    
    //MARK: - ========= productAPICall() =============
    func productAPICall(){
        
        let requestMode = RequestMode.shared.LeadProduct
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let fk_company = "\(preference.User_FK_Company)"
        let id_Category = "\(self.controller.selectedProductDetailInfo.ID_Category ?? -1)"
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           
            let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company,"ID_Category":id_Category]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadProduct,arguMents: arguMents)
            self.parserVm.modelInfoKey = "ProductDetailsList"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    //print(responseHandler.info)
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    self.parserVm.progressBar.hideIndicator()
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "ProductList") as? [NSDictionary] ?? []
                        
                        self.controller.productList = []
                        self.controller.productList = list.map{ ProductListInfo(datas: $0) }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.productListPopUPPageCall(list: self.controller.productList)
                        }
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                    self.leadProductCancellable.dispose()
                }.store(in: &leadProductCancellable)
            
        }
    }
    
    
    //MARK: - ========= prioriyAPICall() =============
    func prioriyAPICall(){
        
        let requestMode = RequestMode.shared.LeadPriority
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        
        let fk_company = "\(preference.User_FK_Company)"
        
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           
            let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadPriority,arguMents: arguMents)
            self.parserVm.modelInfoKey = "PriorityDetailsList"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    self.parserVm.progressBar.hideIndicator()
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "PriorityList") as? [NSDictionary] ?? []
                        self.controller.priorityList = []
                        self.controller.priorityList = list.map{ PriorityListInfo(datas: $0) }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.priorityListPopUPPageCall(list: self.controller.priorityList)
                        }
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                    
                    self.leadPriorityCancellable.dispose()
                }.store(in: &leadPriorityCancellable)
        }
    }
    
    
    //MARK: - ========= actionAPICall() ==============
    func actionAPICall(){
        let requestMode = RequestMode.shared.LeadFollowUpAction
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let subMode = SubMode.Shared.leadFollowUpAction
        let fk_company = "\(preference.User_FK_Company)"
        
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           
            let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let esubMode = instanceOfEncryptionPost.encryptUseDES(subMode, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company,"SubMode":esubMode]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadFollowUpAction,arguMents: arguMents)
            self.parserVm.modelInfoKey = "FollowUpActionDetails"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    
                    
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    self.parserVm.progressBar.hideIndicator()
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "FollowUpActionDetailsList") as? [NSDictionary] ?? []
                        
                        self.controller.actionList = []
                        
                        self.controller.actionList = list.map{ FollowUpActionDetailsListInfo(datas: $0) }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                            self.followUPActionListPopUPPageCall(list: self.controller.actionList)
                        }
                        
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                    
                    
                    self.leadProjectStatusCancellable.dispose()
                }.store(in: &leadProjectStatusCancellable)
            
        }
    }
    
    
    //MARK: - ========= followUpTypeAPICall() ==============
    func followUpTypeAPICall(){
        let requestMode = RequestMode.shared.LeadFollowUpActionType
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        
        let fk_company = "\(preference.User_FK_Company)"
        
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           
            let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadFollowUpActionType,arguMents: arguMents)
            self.parserVm.modelInfoKey = "FollowUpTypeDetails"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    
                    self.parserVm.progressBar.hideIndicator()
                    
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "FollowUpTypeDetailsList") as? [NSDictionary] ?? []
                        self.controller.actionTypeList = []
                        self.controller.actionTypeList = list.map{ FollowUpTypeDetailsListInfo(datas: $0) }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.followUPTypeListPopUPPageCall(list: self.controller.actionTypeList)
                        }
                        
                        //print(responseHandler.info)
                    }else{
                        self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    }
                    
                    self.leadFollowUpTypeCancellable.dispose()
                }.store(in: &leadFollowUpTypeCancellable)
        }
    }
    
    
    
    //MARK: - ========== employeeDetailsAPICall() ===========
    func employeeDetailsAPICall(){
        let requestMode = RequestMode.shared.LeadEmployeeDetails
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let ID_Department = "\(self.controller.leadGenerationDefaultValueSettingsInfo!.FK_Department)"
        let fk_company = "\(preference.User_FK_Company)"
        
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           
            let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let eID_Department = instanceOfEncryptionPost.encryptUseDES(ID_Department, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            
               let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company,"ID_Department":eID_Department]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.LeadEmployeeDetails,arguMents: arguMents)
            self.parserVm.modelInfoKey = "EmployeeDetails"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                   .dropFirst()
                   .sink { responseHandler in
                       
                       self.parserVm.progressBar.hideIndicator()
                       let statusCode = responseHandler.statusCode
                       let message = responseHandler.message
                       //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                       if statusCode == 0{
                           let list = responseHandler.info.value(forKey: "EmployeeDetailsList") as? [NSDictionary] ?? []
                           self.controller.employeeList = []
                           self.controller.employeeList = list.map{ EmployeeDetailsListInfo(datas: $0) }
                           
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                               self.employeeListPopUPPageCall(list: self.controller.employeeList)
                           }
                           
                           self.leadEmployeeCancellable.dispose()
                       }else{
                           self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                       }
                       
                   }.store(in: &leadEmployeeCancellable)
               
               
        }
    }
    
    
 
    
    //MARK: - ========= leadGenerationAPICall() ============
    
    func leadGenerationAPICall(){
        
        let fk_customer_info = self.controller.selecteCustomerDetailsInfo.Customer_Type == 1 ? self.controller.selecteCustomerDetailsInfo.ID_Customer : 0
        let fk_customer_other_info = self.controller.selecteCustomerDetailsInfo.Customer_Type == 0 ? self.controller.selecteCustomerDetailsInfo.ID_Customer : 0
        if let setDefaultValueInfo = self.controller.selectedDefaultValue as? SelectedLeadGenerationDefaultValue{
            let bankKey = preference.appBankKey
            let fk_employee = "\(preference.User_Fk_Employee)"
            let UserName = self.controller.selectedUserFromCollectionList.Name
            let TransMode = transMode
            let ID_LeadGenerate = "0"
            let LgLeadDate = DateTimeModel.shared.formattedDateFromString(dateString: self.controller.leadGenerationValidationVM.leadDateString)
            let FK_Customer =  "\(fk_customer_info)"
            
            let FK_SubMedia = self.controller.selectedSubMedia.ID_MediaSubMaster == -1 ? "" : "\(self.controller.selectedSubMedia.ID_MediaSubMaster)"
            let LgCusNameTitle = self.controller.selectedHonorificString
            let LgCusName = self.controller.selecteCustomerDetailsInfo.CusName ?? ""
            let LgCusAddress = self.controller.selecteCustomerDetailsInfo.CusAddress1
            let LgCusAddress2 = self.controller.selecteCustomerDetailsInfo.CusAddress2
            let LgCusMobile = self.controller.selecteCustomerDetailsInfo.CusPhnNo
            let LgCusEmail = self.controller.selecteCustomerDetailsInfo.CusEmail
            let CusCompany = self.controller.selecteCustomerDetailsInfo.Company
            let CusPerson = ""
            let CusPhone = ""
            let FK_Country = "\(setDefaultValueInfo.FK_Country ?? 0)"
            let FK_State = "\(setDefaultValueInfo.FK_States ?? 0)"
            let FK_District =  "\(setDefaultValueInfo.FK_District ?? 0)"
            let FK_Area = "\(setDefaultValueInfo.FK_Area ?? 0)"
            let FK_Post = "\(setDefaultValueInfo.PostID ?? 0)"
            let LastID = "0"
            let FK_LeadFrom = "\(self.controller.selectedLeadSourceInfo.ID_LeadFrom)"
            let FK_LeadBy = "\(self.controller.selectedLeadThrough.ID_LeadThrough)"
            let LeadByName = self.controller.selectedLeadThrough.LeadThroughName
            let FK_MediaMaster = String(describing: self.controller.selectedLeadThrough.ID_LeadThrough)
            let LgCollectedBy = "\(self.controller.selectedUserFromCollectionList.ID_CollectedBy ?? 0)"
            let FK_BranchCodeUser = "\(preference.User_FK_BranchCodeUser)"
            let EntrBy = preference.User_UserCode
            let PreviousID = "0"
            let CusMobileAlternate = self.controller.selecteCustomerDetailsInfo.CusMobileAlternate
            let FK_Category = "\(self.controller.selectedProductDetailInfo.ID_Category ?? 0)"
            let ID_Product = "\(self.controller.selectedProductDetailInfo.ID_Product ?? 0)"
            let ProdName = self.controller.selectedProductDetailInfo.ProductName ?? ""
            let ProjectName = self.controller.selectedProductDetailInfo.ModelString ?? ""
            let LgpPQuantity =  self.controller.selectedProductDetailInfo.quantity ?? "0"
            let FK_Priority = "\(self.controller.selectedProductDetailInfo.ID_Priority ?? 0)"
            let LgpDescription =  self.controller.selectedProductDetailInfo.EnquiryText ?? ""
            let ActStatus = "\(self.controller.selectedProductDetailInfo.Status ?? 0)"
            let FK_NetAction = "\(self.controller.selectedProductDetailInfo.ID_NextAction ?? 0)"
            let FK_ActionType = "\(self.controller.selectedProductDetailInfo.ID_ActionType ?? 0)"
            let naDate = DateTimeModel.shared.formattedDateFromString(dateString: self.controller.selectedProductDetailInfo.date ?? "")
            let NextActionDate = naDate
            let BranchID = "\(self.controller.selectedDefaultValue.ID_Branch ?? 0)"
            let BranchTypeID = "\(self.controller.selectedDefaultValue.ID_BranchType ?? 0)"
            let FK_Departement = "\(self.controller.selectedDefaultValue.FK_Department ?? 0)"
            let AssignEmp = "\(self.controller.selectedProductDetailInfo.ID_Employee ?? 0)"
            let LocLatitude = "\(self.controller.coordinates.lat)"
            let LocLongitude = "\(self.controller.coordinates.lon)"
            let LocationLandMark1 = self.controller.imageStringArray.count > 0 ? self.controller.imageStringArray[0] : ""
            let LocationLandMark2 = self.controller.imageStringArray.count > 1 ? self.controller.imageStringArray[1] : ""
            let FK_CustomerOthers = "\(fk_customer_other_info)"
            
            let token = preference.User_Token
            let fk_company = "\(preference.User_FK_Company)"
            
            //let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
            if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
               let eTransMode = instanceOfEncryptionPost.encryptUseDES(TransMode, key: SKey),
               let eID_LeadGenerate = instanceOfEncryptionPost.encryptUseDES(ID_LeadGenerate, key: SKey),
               let eUserName = instanceOfEncryptionPost.encryptUseDES(UserName, key: SKey),
               let eLgLeadDate = instanceOfEncryptionPost.encryptUseDES(LgLeadDate, key: SKey),
               
               let eFK_Customer = instanceOfEncryptionPost.encryptUseDES(FK_Customer, key: SKey),
               
                let eFK_SubMedia = instanceOfEncryptionPost.encryptUseDES(FK_SubMedia, key: SKey),
               
                let eLgCusNameTitle = instanceOfEncryptionPost.encryptUseDES(LgCusNameTitle, key: SKey),
               
                
                let eLgCusName = instanceOfEncryptionPost.encryptUseDES(LgCusName, key: SKey),
               
                let eLgCusAddress = instanceOfEncryptionPost.encryptUseDES(LgCusAddress, key: SKey),
               
                
                let eLgCusAddress2 = instanceOfEncryptionPost.encryptUseDES(LgCusAddress2, key: SKey),
               
                
                let eLgCusMobile = instanceOfEncryptionPost.encryptUseDES(LgCusMobile, key: SKey),
               
                
                let eLgCusEmail = instanceOfEncryptionPost.encryptUseDES(LgCusEmail, key: SKey),
               
                
                let eCusCompany = instanceOfEncryptionPost.encryptUseDES(CusCompany, key: SKey),
               
                let eCusPerson = instanceOfEncryptionPost.encryptUseDES(CusPerson, key: SKey),
               
                let eCusPhone = instanceOfEncryptionPost.encryptUseDES(CusPhone, key: SKey),
               
                let eFK_Country = instanceOfEncryptionPost.encryptUseDES(FK_Country, key: SKey),
               
                
                let eFK_State = instanceOfEncryptionPost.encryptUseDES(FK_State, key: SKey),
               
                
                let eFK_District = instanceOfEncryptionPost.encryptUseDES(FK_District, key: SKey),
               
                let eFK_Area = instanceOfEncryptionPost.encryptUseDES(FK_Area, key: SKey),
               
                
                let eFK_Post = instanceOfEncryptionPost.encryptUseDES(FK_Post, key: SKey),
               
                
                let eLastID = instanceOfEncryptionPost.encryptUseDES(LastID, key: SKey),
               
                let eFK_LeadFrom = instanceOfEncryptionPost.encryptUseDES(FK_LeadFrom, key: SKey),
               
                let eFK_LeadBy = instanceOfEncryptionPost.encryptUseDES(FK_LeadBy, key: SKey),
               
                let eLeadByName = instanceOfEncryptionPost.encryptUseDES(LeadByName, key: SKey),
               
                let eFK_MediaMaster = instanceOfEncryptionPost.encryptUseDES(FK_MediaMaster, key: SKey),
               
                let eLgCollectedBy = instanceOfEncryptionPost.encryptUseDES(LgCollectedBy, key: SKey),
               
                let eFK_BranchCodeUser = instanceOfEncryptionPost.encryptUseDES(FK_BranchCodeUser, key: SKey),
               
                let eEntrBy = instanceOfEncryptionPost.encryptUseDES(EntrBy, key: SKey),
               
                let ePreviousID = instanceOfEncryptionPost.encryptUseDES(PreviousID, key: SKey),
               
                let eCusMobileAlternate = instanceOfEncryptionPost.encryptUseDES(CusMobileAlternate, key: SKey),
               
                let eFK_Category = instanceOfEncryptionPost.encryptUseDES(FK_Category, key: SKey),
               
                let eID_Product = instanceOfEncryptionPost.encryptUseDES(ID_Product, key: SKey),
               
                let eProdName = instanceOfEncryptionPost.encryptUseDES(ProdName, key: SKey),
               
                let eProjectName = instanceOfEncryptionPost.encryptUseDES(ProjectName, key: SKey),
               
                
                let eLgpPQuantity = instanceOfEncryptionPost.encryptUseDES(LgpPQuantity, key: SKey),
               
                
                let eFK_Priority = instanceOfEncryptionPost.encryptUseDES(FK_Priority, key: SKey),
               
                
                let eLgpDescription = instanceOfEncryptionPost.encryptUseDES(LgpDescription, key: SKey),
               
                
                let eActStatus = instanceOfEncryptionPost.encryptUseDES(ActStatus, key: SKey),
               
                let eFK_NetAction = instanceOfEncryptionPost.encryptUseDES(FK_NetAction, key: SKey),
               
                
                let eFK_ActionType = instanceOfEncryptionPost.encryptUseDES(FK_ActionType, key: SKey),
               
                let eNextActionDate = instanceOfEncryptionPost.encryptUseDES(NextActionDate, key: SKey),
               
                let eBranchID = instanceOfEncryptionPost.encryptUseDES(BranchID, key: SKey),
               
                let eBranchTypeID = instanceOfEncryptionPost.encryptUseDES(BranchTypeID, key: SKey),
               
                
                let eFK_Departement = instanceOfEncryptionPost.encryptUseDES(FK_Departement, key: SKey),
               
                
                let eAssignEmp = instanceOfEncryptionPost.encryptUseDES(AssignEmp, key: SKey),
               
                let eLocLatitude = instanceOfEncryptionPost.encryptUseDES(LocLatitude, key: SKey),
               
                
                let eLocLongitude = instanceOfEncryptionPost.encryptUseDES(LocLongitude, key: SKey),
               
                let eLocationLandMark1 = instanceOfEncryptionPost.encryptUseDES(LocationLandMark1, key: SKey),
               
                let eLocationLandMark2 = instanceOfEncryptionPost.encryptUseDES(LocationLandMark2, key: SKey),
               
                let eFK_CustomerOthers = instanceOfEncryptionPost.encryptUseDES(FK_CustomerOthers, key: SKey),
               
                
              let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
              let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
              let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
                
                
                let arguMents = ["BankKey":ebankKey,"UserName":eUserName,"Token":etoken,"UserAction":"","TransMode":eTransMode,"ID_LeadGenerate":eID_LeadGenerate,"LgLeadDate":eLgLeadDate,"FK_Customer":eFK_Customer,"FK_SubMedia":eFK_SubMedia,"LgCusNameTitle":eLgCusNameTitle,"LgCusName":eLgCusName,"LgCusAddress":eLgCusAddress,"LgCusAddress2":eLgCusAddress2,"LgCusMobile":eLgCusMobile,"LgCusEmail":eLgCusEmail,"CusCompany":eCusCompany,"CusPerson":eCusPerson,"CusPhone":eCusPhone,"FK_Country":eFK_Country,"FK_State":eFK_State,"FK_District":eFK_District,"FK_Area":eFK_Area,"FK_Post":eFK_Post,"LastID":eLastID,"FK_LeadFrom":eFK_LeadFrom,"FK_LeadBy":eFK_LeadBy,"LeadByName":eLeadByName,"FK_MediaMaster":eFK_MediaMaster,"LgCollectedBy":eLgCollectedBy,"FK_Company":efk_company,"FK_BranchCodeUser":eFK_BranchCodeUser,"EntrBy":eEntrBy,"PreviousID":ePreviousID,"CusMobileAlternate":eCusMobileAlternate,"FK_Category":eFK_Category,"ID_Product":eID_Product,"ProdName":eProdName,"ProjectName":eProjectName,"LgpPQuantity":eLgpPQuantity,"FK_Priority":eFK_Priority,"LgpDescription":eLgpDescription,"ActStatus":eActStatus,"FK_NetAction":eFK_NetAction,"FK_ActionType":eFK_ActionType,"NextActionDate":eNextActionDate,"BranchID":eBranchID,"BranchTypeID":eBranchTypeID,"FK_Departement":eFK_Departement,"AssignEmp":eAssignEmp,"LocLatitude":eLocLatitude,"LocLongitude":eLocLongitude,"LocationLandMark1":LocationLandMark1,"LocationLandMark2":LocationLandMark2,"FK_CustomerOthers":eFK_CustomerOthers,"FK_Employee":efk_employee]
             
                print(arguMents)
                
             let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadGeneration,arguMents: arguMents)
             self.parserVm.modelInfoKey = "UpdateLeadGeneration"
             self.parserVm.progressBar.showIndicator()
             self.parserVm.parseApiRequest(request)
             self.parserVm.$responseHandler
                    .dropFirst()
                    .sink { responseHandler in
                        self.parserVm.progressBar.hideIndicator()
                        let statusCode = responseHandler.statusCode
                        let message = responseHandler.message
                        //self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                        if statusCode == 0{
                            let leadNumber = responseHandler.info.value(forKey: "LeadNumber") as? String ?? ""
                            let subMessage = "Lead Number : \(leadNumber)"
                            let successMessage = message + "\n\(subMessage)"
                            self.controller.popupAlert(title: "", message: successMessage, actionTitles: [okTitle], actions: [{action1 in
                                self.controller.navigationController?.popViewController(animated: true)
                            },nil])
                        }else{
                            self.controller.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                        }
                        self.leadGenerationCancellable.dispose()
                    }.store(in: &leadGenerationCancellable)
              
          }

        }
        
        
    }
    
    
    //MARK: - ========== PopUpScreens() ===========
    func categoryListPopUPPageCall(list:[CategoryListInfo]){
        
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.CategoryName
            
            cell.titleLabel.textColor = item.Project == 1 ? AppColor.Shared.color_error : AppColor.Shared.greyText
            
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            
            
            self.controller.selectedProductDetailInfo.ID_Category = item.ID_Category
            self.controller.selectedProductDetailInfo.CategoryName = item.CategoryName
            self.controller.selectedProductDetailInfo.Project = item.Project
            
            
            print(self.controller.selectedProductDetailInfo)
        }
        
        popUpVC.listingTitleString = "CATEGORY"
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popUpVC, animated: false)
        
        
    }
    
    func productListPopUPPageCall(list:[ProductListInfo]){
        
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.ProductName
            
            
            
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            
            self.controller.selectedProductDetailInfo.ID_Product = item.ID_Product
            self.controller.selectedProductDetailInfo.ProductName = item.ProductName
            self.controller.selectedProductDetailInfo.ProductCode = item.ProductCode
            self.controller.selectedProductDetailInfo.ModelString = ""
        
            print(self.controller.selectedProductDetailInfo)
        }
        
        popUpVC.listingTitleString = "PRODUCT"
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popUpVC, animated: false)
        
        
    }
    
    
    func priorityListPopUPPageCall(list:[PriorityListInfo]){
        
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.PriorityName
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            
            self.controller.selectedProductDetailInfo.ID_Priority = item.ID_Priority
            self.controller.selectedProductDetailInfo.PriorityName = item.PriorityName
            
            print(self.controller.selectedProductDetailInfo)
        }
        
        popUpVC.listingTitleString = "PRIORITY"
        
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popUpVC, animated: false)
        
        
    }
    
    
    
    func followUPActionListPopUPPageCall(list:[FollowUpActionDetailsListInfo]){
        
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.NxtActnName
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            
            self.controller.selectedProductDetailInfo.Status = item.Status
            self.controller.selectedProductDetailInfo.NxtActnName = item.NxtActnName
            self.controller.selectedProductDetailInfo.ID_NextAction = item.ID_NextAction
            
            print(self.controller.selectedProductDetailInfo)
        }
        
        popUpVC.listingTitleString = "ACTION"
        
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popUpVC, animated: false)
        
        
    }
    
    
    func followUPTypeListPopUPPageCall(list:[FollowUpTypeDetailsListInfo]){
        
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.ActnTypeName
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            
            self.controller.selectedProductDetailInfo.ActionMode = item.ActionMode
            self.controller.selectedProductDetailInfo.ActnTypeName = item.ActnTypeName
            self.controller.selectedProductDetailInfo.ID_ActionType = item.ID_ActionType
            
            print(self.controller.selectedProductDetailInfo)
        }
        
        popUpVC.listingTitleString = "ACTION TYPE"
        
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popUpVC, animated: false)
        
        
    }
    
    
    func employeeListPopUPPageCall(list:[EmployeeDetailsListInfo]){
        
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.EmpName
            cell.detailsLabel.text = item.DesignationName
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            
            self.controller.selectedProductDetailInfo.ID_Employee = item.ID_Employee
            self.controller.selectedProductDetailInfo.EmpName = item.EmpName
            self.controller.selectedProductDetailInfo.DesignationName = item.DesignationName
            self.controller.selectedProductDetailInfo.DepartmentName = item.DepartmentName
            
            print(self.controller.selectedProductDetailInfo)
        }
        
        popUpVC.listingTitleString = "EMPLOYEE"
        
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.controller.present(popUpVC, animated: false)
        
        
    }
    
    
    
    //MARK: - ========= PROJECT PRODUCT CELL DETAILS ==============
    func project_ProductDetailCell(cell:ProjectProductDetailsTVC,info:SelectedProductDetailsInfo){
        
        
        cell.categoryTextField.dropDownButton.tag = 0
        cell.priorityTextField.dropDownButton.tag = 1
        cell.statusTextField.dropDownButton.tag = 2
        cell.actionTypeTextField.dropDownButton.tag = 3
        cell.nameTextField.dropDownButton.tag = 4
        
        
        
        
        if let item = info as? SelectedProductDetailsInfo{
            
            cell.isZeroProject = item.Project ?? 0
            
            cell.categoryTextField.text = item.CategoryName
            cell.subCategoryTextField.text = item.Project == 0 ? item.ProductName : item.ModelString
            cell.priorityTextField.text = item.PriorityName
            cell.enquiryNoteTextField.text = item.EnquiryText
            cell.statusTextField.text = item.NxtActnName
            cell.actionTypeTextField.text = item.ActnTypeName
            cell.nameTextField.text = item.EmpName
            cell.subCategoryQtyTextField.text = item.quantity == "" ? "" : item.quantity
            cell.dateTextField.text = item.date

        }
    }
    
    
   
    
    
    //MARK: - ================= UPLOAD IMAGE CELL =======================
    
    func uploadImageCell(cell:UploadImageViewTVC){
        
        
     
        
        
        
        
        
        cell.uploadFirstImageView.backgroundColor = AppColor.Shared.greylight
        cell.uploadFirstImageView.isUserInteractionEnabled = true
        
        cell.uploadFirstImageView.contentMode = .scaleAspectFill
       
        cell.uploadSecondImageView.backgroundColor = AppColor.Shared.greylight
        cell.uploadSecondImageView.isUserInteractionEnabled = true
        
        cell.uploadSecondImageView.contentMode = .scaleAspectFill
        
        
        cell.uploadFirstImageView.image = self.controller.uploadImagList.first!
        cell.uploadSecondImageView.image = self.controller.uploadImagList.last!
        
        
        
    }
    
   
 // LEAD REQUEST SECTION
    
    //MARK: - leadWalkingCustomerRequestDetailsList
    func leadWalkingCustomerRequestDetailsList(){
        //leadRequestCancellable
        
        let requestMode = RequestMode.shared.leadWalkCustomer
        let bankKey = preference.appBankKey
        let fk_employee = "\(preference.User_Fk_Employee)"
        let token = preference.User_Token
        let fk_company = "\(preference.User_FK_Company)"
        let subMode = SubMode.Shared.leadWalkCustomer
        let Name = ""
        let Todate = ""
        let Criteria = ""
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           
            let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
           let eName = instanceOfEncryptionPost.encryptUseDES(Name, key: SKey),
           let eTodate = instanceOfEncryptionPost.encryptUseDES(Todate, key: SKey),
           let eCriteria = instanceOfEncryptionPost.encryptUseDES(Criteria, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let esubMode = instanceOfEncryptionPost.encryptUseDES(subMode, key: SKey){
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company,"SubMode":esubMode,"Name":eName,"Todate":eTodate,"criteria":eCriteria]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.leadWalkingCustomer,arguMents: arguMents)
            self.parserVm.modelInfoKey = "WalkingCustomerDetailsList"
            self.parserVm.progressBar.showIndicator()
            self.parserVm.parseApiRequest(request)
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    self.parserVm.progressBar.hideIndicator()
                    let list = responseHandler.info.value(forKey: "WalkingCustomerDetails") as? [NSDictionary] ?? []
                    self.controller.leadWalkingList = []
                    self.controller.leadWalkingList = list.map{ WalkingCustomerDetailsInfo(datas: $0) }
                    
                    
                        self.controller.list[0].list = []
                        self.controller.list[0].list = self.controller.leadWalkingList.map{ $0.Employee }
                    
                        self.controller.list[0].rows = self.controller.leadWalkingList.count
                         
                    
                    
                    
                    if self.controller.leadWalkingList.count > 0{
                        self.controller.expandedSectionHeaderNumber = 0
                        self.controller.leadGenerateTableView.reloadData()
                    }
//                    else{
//                        self.controller.expandedSectionHeaderNumber = -1
//                        self.controller.leadGenerateTableView.reloadData()
//                    }
                    
                    
                    self.leadRequestCancellable.dispose()
                }.store(in: &leadRequestCancellable)
        }
    }
    
}



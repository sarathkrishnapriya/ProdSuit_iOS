//
//  ChartVCViewModels.swift
//  ProdSuit
//
//  Created by MacBook on 27/03/23.
//

import Foundation
import UIKit
import Combine
import Charts
import Foundation

class ChartVCViewModel{
    
    
    var preference = SharedPreference.Shared
    
    lazy var leadsList : [LeadDashBoardDetailsModel] = []
    lazy var leadsStatusList : [LeadDashBoardDetailsModel] = []
    lazy var leadsStageList : [LeadDashBoardDetailsModel] = []
    
    lazy var chartVCController:ChartVC={
        let vc = ChartVC()
        
        return vc
    }()
    
    lazy var parserViewModel : APIParserManager = APIParserManager()
    
    lazy var leadsCancellable = Set<AnyCancellable>()
    
    var parserVM : GlobalAPIViewModel!
    
    init(controller:ChartVC){
        self.chartVCController = controller
        self.parserVM = GlobalAPIViewModel(bgView: self.chartVCController.view)
        
        self.leadChartInfo()
    }
    
    func leadChartInfo(){
        chartLeadsAPICall(SubMode.Shared.leads)
        
        //self.leadsCancellable.dispose()
    }
    
    //MARK: - chartLeadsAPICall()
    fileprivate func resultHandler(_ responseHandler: Published<successErrorHandler>.Publisher.Output,_ submode:String) {
        let message = responseHandler.message
        
        if responseHandler.statusCode == 0{
            
            let totalCount = responseHandler.info.value(forKey: "TotalCount") as? NSNumber ?? 0
            let leadsDashBoardDetailsList = responseHandler.info.value(forKey: "LeadsDashBoardDetailsList") as? [NSDictionary] ?? []
            
            if submode == "1"{
                
                self.leadsList = []
                
                self.leadsList = leadsDashBoardDetailsList.map{ LeadDashBoardDetailsModel(datas: $0) }
                
                self.chartVCController.customizeChart(listInfo: self.leadsList, piechartView: self.chartVCController.leadsView)
                self.chartLeadsAPICall(SubMode.Shared.leadsStatus)
                
            }else if submode == "2"{
                
                self.leadsStatusList = []
                
                self.leadsStatusList = leadsDashBoardDetailsList.map{ LeadDashBoardDetailsModel(datas: $0) }
                
                self.chartVCController.customizeChart(listInfo: self.leadsStatusList, piechartView: self.chartVCController.leadStatusView)
                self.chartLeadsAPICall(SubMode.Shared.leadsStages)
                
            }else{
                
                self.leadsStageList = []
                
                self.leadsStageList = leadsDashBoardDetailsList.map{ LeadDashBoardDetailsModel(datas: $0) }
                
                //self.chartVCController.customizeChart(listInfo: self.leadsStageList)
                self.chartVCController.customBarCharts(listInfo: self.leadsStageList, barchartView: self.chartVCController.leadStagesView)
                
            }
            
            
            
        }else{
            
            self.chartVCController.popupAlert(title: "", message: message, actionTitles: [closeTitle], actions: [{action1 in
                print("leads chart error")
            },nil])
            
        }
    }
    
    func chartLeadsAPICall(_ submode:String = SubMode.Shared.leads){
        
        let requestMode = RequestMode.shared.Chart // "ReqMode"
        let subMode =  submode// "SubMode"
        let bankKey = preference.appBankKey // "BankKey"
        let token  = preference.User_Token // "Token"
        let fk_Employee = preference.User_Fk_Employee // "FK_Employee"
        let fk_Branch = preference.User_FK_Branch // "FK_Branch"
        let fk_Company = preference.User_FK_Company // "FK_Company"
        let fk_branchCodeUser = preference.User_FK_BranchCodeUser // "FK_BranchCodeUser"
        let entrBy = preference.User_UserCode // "EntrBy"
        
        
        if let ereqMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let esubMode = instanceOfEncryptionPost.encryptUseDES(subMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let efk_employee = instanceOfEncryptionPost.encryptUseDES("\(fk_Employee)", key: SKey),
           let efk_branch = instanceOfEncryptionPost.encryptUseDES("\(fk_Branch)", key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES("\(fk_Company)", key: SKey),
           let efk_branchCodeUser = instanceOfEncryptionPost.encryptUseDES("\(fk_branchCodeUser)", key: SKey),
           let eentrBy = instanceOfEncryptionPost.encryptUseDES(entrBy, key: SKey)
        {
            let arguMents = ["ReqMode":ereqMode,"SubMode":esubMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Branch":efk_branch,"FK_Company":efk_company,"FK_BranchCodeUser":efk_branchCodeUser,"EntrBy":eentrBy]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.chart, arguMents: arguMents)
            self.leadsCancellable.dispose()
            self.parserVM.parseApiRequest(request)
            self.parserVM.modelInfoKey = "LeadsDashBoardDetails"
            self.parserVM.$responseHandler
            
                .receive(on: DispatchQueue.main)
            
                .dropFirst()
                 
                .sink { responseHandler in
                    
                    self.resultHandler(responseHandler, submode)
                
                print(responseHandler.info)
                
            }.store(in: &leadsCancellable)
        }
        
        
        
        
    }
    
    
    
    
}


@objc(BarChartFormatter)
public class BarChartFormatter: NSObject, AxisValueFormatter
{
    var names = [String]()

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {
        return names[Int(value)]
    }

    public func setValues(values: [String])
    {
        self.names = values
    }
}

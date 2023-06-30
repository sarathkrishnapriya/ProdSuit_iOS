//
//  LMCListLoadDetailsVC.swift
//  ProdSuit
//
//  Created by MacBook on 19/05/23.
//

import UIKit
import Combine

class LMCListLoadDetailsVC: UIViewController {
    
//    var selectedPage : Int = 0{
//
//    }
    var parserVm : GlobalAPIViewModel!
    lazy var apiParserVm : APIParserManager = APIParserManager()
    lazy var historyCancellable = Set<AnyCancellable>()
    
    lazy var infoList:[LeadActivitiesDetailsModel] = []{
        didSet{
            self.historyTableView.reloadData()
        }
    }
    
    @IBOutlet weak var historyTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.parserVm = GlobalAPIViewModel(bgView: self.view)
        tableInitialisation()
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate func tableInitialisation() {
        self.historyTableView.dataSource = self
        self.historyTableView.delegate = self
        self.historyTableView.separatorStyle = .none
        self.historyTableView.backgroundColor = AppColor.Shared.greylight
        self.historyTableView.contentInset  = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    
    func leadHistoryAPICall(_ ID_LeadGenerateProduct:String,_ ID_ActionType:String,_ fk_employee:String){
        
        let requestMode = RequestMode.shared.leadHistory
        let token = preference.User_Token
        let bankKey = preference.appBankKey
        let fk_company = "\(preference.User_FK_Company)"
        let fk_Employee = fk_employee
        let id_ActionType = ID_ActionType
        let leadGenerateProduct_id = ID_LeadGenerateProduct
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           
            let efk_Employee = instanceOfEncryptionPost.encryptUseDES(fk_Employee, key: SKey),
           let eID_ActionType = instanceOfEncryptionPost.encryptUseDES(id_ActionType, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let eProductId = instanceOfEncryptionPost.encryptUseDES(leadGenerateProduct_id, key: SKey){
           
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Company":efk_company,"ID_LeadGenerateProduct":eProductId,"ID_ActionType":eID_ActionType,"FK_Employee":efk_Employee]
            let request = apiParserVm.request(urlPath: URLPathList.Shared.leadHistory,arguMents: arguMents)
           
                parserVm.modelInfoKey = "ActivitiesDetails"
                //parserVm.progressBar.showIndicator()
                parserVm.parseApiRequest(request)
                parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    //self.parserVm.progressBar.hideIndicator()
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    
                    if statusCode == 0{
                        
                        let list  = responseHandler.info.value(forKey: "ActivitiesDetailsList") as? [NSDictionary] ?? []
                        
                        
                        self.infoList = []
                        
                        self.infoList = list.map{ LeadActivitiesDetailsModel(datas: $0) }
                        self.historyTableView.tableHasItems()
                        
                    }else{
                       print("lead history : \(message)")
                        self.infoList = []
                        self.historyTableView.tableIsEmpty("", message, AppColor.Shared.coloBlack)
                    }
                    
                    print(responseHandler.info)
                    self.historyCancellable.dispose()
                }.store(in: &historyCancellable)
            
        }
        
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension LMCListLoadDetailsVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.shared.leadManagementHistoryCell) as! LeadManagementHistoryTVC
        cell.bgGradient(cell.bgView)
        let info = infoList[indexPath.row]
        cell.vm = info
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
}

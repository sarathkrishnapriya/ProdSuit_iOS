//
//  LMCategoryDetailsInfoVC.swift
//  ProdSuit
//
//  Created by MacBook on 19/05/23.
//

import UIKit
import Combine

class LMCategoryDetailsInfoVC: UIViewController {
    
    @IBOutlet weak var leadInfoTableView: UITableView!
    var parserVm : GlobalAPIViewModel!
    lazy var apiParserVm : APIParserManager = APIParserManager()
    
    lazy var infoCancellable = Set<AnyCancellable>()
    
    var info : LeadInfoDetailsModel!
    
    lazy var infoList : [(pic:UIImage,title:String,value:String)] = []{
        didSet{
            self.leadInfoTableView.reloadData()
        }
    }

    fileprivate func tableInitialisation() {
        self.leadInfoTableView.dataSource = self
        self.leadInfoTableView.delegate = self
        self.leadInfoTableView.separatorStyle = .none
        self.leadInfoTableView.backgroundColor = AppColor.Shared.greylight
        self.leadInfoTableView.contentInset  = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.parserVm = GlobalAPIViewModel(bgView: self.view)
        
        tableInitialisation()
        // Do any additional setup after loading the view.
    }
    
    func leadInfoAPICall(_ ID_LeadGenerateProduct:String,_ branchCode:String){
        
        let requestMode = RequestMode.shared.leadInfo
        let token = preference.User_Token
        let bankKey = preference.appBankKey
        let fk_company = "\(preference.User_FK_Company)"
        let entrBy = preference.User_UserCode
        let branchIndex = branchCode
        let leadGenerateProduct_id = ID_LeadGenerateProduct
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           
            let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let eentrBy = instanceOfEncryptionPost.encryptUseDES(entrBy, key: SKey),
           let eBranchCode = instanceOfEncryptionPost.encryptUseDES(branchIndex, key: SKey),
           let eProductId = instanceOfEncryptionPost.encryptUseDES(leadGenerateProduct_id, key: SKey){
           
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"EntrBy":eentrBy,"FK_Company":efk_company,"ID_LeadGenerateProduct":eProductId,"FK_BranchCodeUser":eBranchCode]
            let request = apiParserVm.request(urlPath: URLPathList.Shared.leadInfo,arguMents: arguMents)
           
                parserVm.modelInfoKey = "LeadInfoDetails"
                //parserVm.progressBar.showIndicator()
                parserVm.parseApiRequest(request)
                parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    //self.parserVm.progressBar.hideIndicator()
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    
                    if statusCode == 0{
                        
                        let datas = responseHandler.info.value(forKey: "LeadInfoDetailsList") as? [NSDictionary] ?? []
                        
                        self.info = LeadInfoDetailsModel(datas: datas[0])
                       // print("info: \(String(describing: self.info))")
                        self.infoList = []
                        if self.info.LeadNo != ""{
                            let image = UIImage(named: "leadNo")!
                            self.infoList.append((pic: image,title: "Lead No", value: self.info.LeadNo))
                        }
                        if self.info.LeadDate != ""{
                            let image = UIImage(named: "leadDate")!
                            self.infoList.append((pic: image,title: "Lead Date", value: self.info.LeadDate))
                        }
                        
                        
                        if self.info.LeadSource != ""{
                            let image = UIImage(named: "leadSource")!
                            self.infoList.append((pic: image,title: "Lead Source", value: self.info.LeadSource))
                        }
                        
                        if self.info.LeadFrom != ""{
                            let image = UIImage(named: "leadFrom")!
                            self.infoList.append((pic: image,title: "Lead From", value: self.info.LeadFrom))
                        }
                        
                        if self.info.Category != ""{
                            let image = UIImage(named: "leadCategory")!
                            self.infoList.append((pic: image,title: "Category", value: self.info.Category))
                        }
                        
                        if self.info.Product != ""{
                            let image = UIImage(named: "leadProduct")!
                            self.infoList.append((pic: image,title: "Product", value: self.info.Product))
                        }
                        
                        if self.info.Action != ""{
                            let image = UIImage(named: "leadAction")!
                            self.infoList.append((pic: image,title: "Action", value: self.info.Action))
                        }
                        
                        if self.info.Customer != ""{
                            let image = UIImage(named: "leadCustomer")!
                            self.infoList.append((pic: image,title: "Customer", value: self.info.Customer))
                        }
                        
                        if self.info.Address != ""{
                            let image = UIImage(named: "leadAddress")!
                            self.infoList.append((pic: image,title: "Address", value: self.info.Address))
                        }
                        
                        if self.info.MobileNumber != ""{
                            let image = UIImage(named: "leadMobile")!
                            self.infoList.append((pic: image,title: "Mobile", value: self.info.MobileNumber))
                        }
                        
                        if self.info.Email != ""{
                            let image = UIImage(named: "leadEmail")!
                            self.infoList.append((pic: image,title: "Email", value: self.info.Email))
                        }
                        
                        if self.info.CollectedBy != ""{
                            let image = UIImage(named: "leadCollectedBy")!
                            self.infoList.append((pic: image,title: "Collected By", value: self.info.CollectedBy))
                        }
                        
                        if self.info.AssignedTo != ""{
                            let image = UIImage(named: "leadAssignedTo")!
                            self.infoList.append((pic: image,title: "Assigned To", value: self.info.AssignedTo))
                        }
                        
                        if self.info.TargetDate != ""{
                            let image = UIImage(named: "leadTargetDate")!
                            self.infoList.append((pic: image,title: "Target Date", value: self.info.TargetDate))
                        }
                        
                        
                        self.leadInfoTableView.tableHasItems()
                        
                        
                        
                        
                    }else{
                       print("lead info : \(message)")
                        self.infoList = []
                        self.leadInfoTableView.tableIsEmpty("", message, AppColor.Shared.coloBlack)
                    }
                    
                    print(responseHandler.info)
                    self.infoCancellable.dispose()
                }.store(in: &infoCancellable)
            
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


extension LMCategoryDetailsInfoVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.infoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.shared.leadManagementInfoCell) as! LeadManagementInfoTVC
        
        let info = self.infoList[indexPath.item]
        cell.vm = info
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}

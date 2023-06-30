//
//  LManagementCategoryListVC.swift
//  ProdSuit
//
//  Created by MacBook on 10/05/23.
//

import UIKit
import CallKit

class LManagementCategoryListVC: UIViewController, CXCallObserverDelegate {
    
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        if call.hasEnded{
            let followUpPage = AppVC.Shared.lmCDFollowUpPage
            
            DispatchQueue.main.async {[weak self] in
                if !(self?.allControllers.contains(followUpPage))!{
                    followUpPage.actionTypeValue = 1
                    self?.navigationController?.pushViewController(followUpPage, animated: true)
                }else{
                    print("all ready contain")
                }
            }
            print("call disconnected successfully")
        }
    }
    
    
    var fromViewController = "todo"
    @IBOutlet weak var lmListTableView: UITableView!
    @IBOutlet weak var toggleView: RoundCornerView!
    @IBOutlet weak var navTitle: UILabel!
    
    var callObserver:CXCallObserver!
    weak var lmanageCategoryListVm : LMCategoryListViewModel!
    var subMode : String = "1"
    var selectedBellIndex : [Int] = []
    var selectedReminderList : [Int] = []
    var fk_Employee:String = ""
    var selectedEmployee : EmployeeAllDetails!
    var leadGenerationDefaultValueSettingsInfo : LeadGenerationDefaultValueModel!
    let bellClickedImg = UIImage(named: "svg_bell_remove")
    let bellUnClickedImg = UIImage(named: "svg_bell_add")
    
    lazy var list : [LeadManagementDetailsInfo] = []{
        didSet{
            
            self.lmListTableView.reloadData()
            
        }
    }

    fileprivate func tableInitialize() {
        self.lmListTableView.delegate = self
        self.lmListTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableInitialize()
        callObserver = CXCallObserver()
        callObserver.setDelegate(self, queue: nil)
        self.lmListTableView.contentInset = UIEdgeInsets(top: 15,left: 0,bottom: 15,right: 0)
        self.lmListTableView.separatorStyle = .none
        self.lmListTableView.setBGColor(color: AppColor.Shared.leadManageListTableBG)
           
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lmListTableView.reloadSections(IndexSet(integer: 0), with: .fade)
        
        UIView.animate(withDuration: 0.5) {
            self.lmListTableView.layoutIfNeeded()
        }

        self.navTitle.text = fromViewController == "todo" ? "TO-DO LIST" : fromViewController == "overdue" ? "OVER DUE" : fromViewController == "upcoming" ? "UPCOMING TASKS" : "MY LEADS"
        
        self.lmanageCategoryListVm = LMCategoryListViewModel(controller: self, submode: subMode, branchCode: "\(preference.User_FK_Branch)",fk_employee:fk_Employee)
        
        
        
      }
    
    
    func callAction(number:String)  {
        if let url = URL(string: "tel://\(number)"),
          UIApplication.shared.canOpenURL(url) {
             if #available(iOS 10, *) {
               UIApplication.shared.open(url, options: [:], completionHandler:nil)
              } else {
                  UIApplication.shared.openURL(url)
              }
          } else {
                   // add error message here
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
    
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        let filterVC = AppVC.Shared.lmCategoryListFilter
        filterVC.modalTransitionStyle = .coverVertical
        filterVC.modalPresentationStyle = .overCurrentContext
        filterVC.filterDelegate = self
        filterVC.selectedEmployee = selectedEmployee
        self.present(filterVC, animated: true, completion: nil)
    }
    
    @IBAction func backButtonAction(_ sender: BackButtonCC) {
        self.list = []
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func setReminderButtonAction(_ sender: UIButton) {
        
        if self.selectedBellIndex.count == 0{
            self.popupAlert(title: "", message: "Select Atleast One Reminder", actionTitles: [okTitle], actions: [{action1 in
                
            },nil])
        }else{
            let reminderPopUPVC = AppVC.Shared.ReminderPage
            
            var messageString = ""
            for (index,value) in self.selectedBellIndex.enumerated(){
                let prodProjname = self.list[index].ProdName == "" ? "Project Name : \(self.list[index].ProdName)" : "Product Name : \(self.list[index].ProdName)"
                
                let nextActionDate = self.list[index].NextActionDate == "" ? "" : ", Next Action Date : \(self.list[index].NextActionDate) "
                
                if messageString == ""{
                    messageString += "\(index + 1). \(prodProjname)"
                }else{
                    messageString += ",\(index + 1). \(prodProjname)"
                }
                
                if messageString != ""{
                    messageString += "\(nextActionDate)"
                }
            }
            
            reminderPopUPVC.otherMessage = messageString
            reminderPopUPVC.reminderDelegate = self
            reminderPopUPVC.modalTransitionStyle = .crossDissolve
            reminderPopUPVC.modalPresentationStyle = .overCurrentContext
            self.present(reminderPopUPVC, animated: true)
        }
        
        
    }
    
    func reminderBellReset(){
        self.selectedBellIndex = []
        self.selectedReminderList = []
        for index in self.list{
            self.selectedReminderList.append(0)
        }
        self.lmListTableView.reloadData()
    }
    
    
    
}


extension LManagementCategoryListVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.shared.leadManagementCategoryListCell) as! LeadManagementCategoryListTVC
        cell.fromItem = fromViewController
        
        let info  = list[indexPath.item]
        cell.viewModelInfo = info
        cell.bellImageView.image = self.selectedReminderList[indexPath.row]  == 1 ? bellClickedImg : bellUnClickedImg
         

        
        cell.callButton.tag = indexPath.row
        cell.callButton.addTarget(self, action: #selector(callButtonAction(_:)), for: .touchUpInside)
        cell.bellButton.tag = indexPath.row
        cell.bellButton.addTarget(self, action: #selector(bellButtonAction(_:)), for: .touchUpInside)
        cell.messageButton.tag = indexPath.row
        cell.messageButton.addTarget(self, action: #selector(messageButtonAction(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.list.count
       
        self.navTitle.addCountLabel(mainView: self.navTitle.superview!,count: "\(count)")
        return count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.shared.leadManagementCategoryListCell) as! LeadManagementCategoryListTVC
        
         var cellHeight : CGFloat = 0
        let yPos = (cell.secondView.subviews.map { $0.frame.height }).reduce(40, +)
    
        cellHeight = yPos 
         print("cell height : \(yPos)")
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedListInfo = self.list[indexPath.row]
        
        //print("Selected Info : \(selectedListInfo)")
        
        let detailPage = AppVC.Shared.lmTodoCategoryListDetailPage
       
        DispatchQueue.main.async {[weak self] in
            detailPage.from = self!.fromViewController
            detailPage.info = selectedListInfo
            detailPage.fk_employee = selectedListInfo.FK_Employee
            if !(self?.allControllers.contains(detailPage))!{
                self?.navigationController?.pushViewController(detailPage, animated: true)
            }else{
                print("all ready contain")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.shared.leadManagementCategoryListCell) as! LeadManagementCategoryListTVC

    }
    
    @objc func callButtonAction(_ sender: UIButton){
        let number = self.list[sender.tag].LgCusMobile
        print("mobile number: +91\(number)")
        self.callAction(number: "+91\(number)")
    }
    
    @objc func bellButtonAction(_ sender: UIButton){
        let selectedData = self.list[sender.tag].LeadNo
        if !self.selectedBellIndex.contains(sender.tag){
            self.selectedBellIndex.append(sender.tag)
            self.selectedReminderList[sender.tag] = 1
        }else{
            self.selectedReminderList[sender.tag] = 0
            self.selectedBellIndex = self.selectedBellIndex.filter{ $0 != sender.tag }
        }
       // let indexPosition = IndexPath(row: sender.tag, section: 0)
        self.lmListTableView.reloadData()
        print("lead number: \(selectedData)")
    }
    
    @objc func messageButtonAction(_ sender : UIButton){
        
        
        let messageVc = AppVC.Shared.lmTodoMessagePage
        messageVc.modalTransitionStyle = .coverVertical
        messageVc.modalPresentationStyle = .overCurrentContext
        DispatchQueue.main.async {[weak self] in
            self?.present(messageVc, animated: true, completion: nil)
        }
        
        
    }
    
}

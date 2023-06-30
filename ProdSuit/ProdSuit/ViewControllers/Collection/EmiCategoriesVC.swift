//
//  EmiCategoriesVC.swift
//  ProdSuit
//
//  Created by MacBook on 06/06/23.
//

import UIKit
import Combine

class EmiCategoriesVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var demandView: UIView!{
        didSet{
            self.demandView.setCornerRadius(size: self.demandView.bounds.width/2)
        }
    }
    
    @IBOutlet weak var todoCountLbl: UILabel!
    
    @IBOutlet weak var overDueView: UIView!{
        didSet{
            self.overDueView.setCornerRadius(size: self.overDueView.bounds.width/2)
            
        }
    }
    
    @IBOutlet weak var overDueCountLbl: UILabel!
    
    @IBOutlet weak var todoView: UIView!{
        didSet{
            self.todoView.setCornerRadius(size: self.todoView.bounds.width/2)
        }
    }
    
    @IBOutlet weak var demandCountLbl: UILabel!
    @IBOutlet weak var popUPView: UIView!
    
    @IBOutlet weak var popUPBGView: UIView!
    
    @IBOutlet weak var popUpstackView: UIStackView!
    
    @IBOutlet weak var financialPlanTF: UITextField!
    
    @IBOutlet weak var dateView: TransDateView!{
        didSet{
            dateView.HeaderDetailTF.setBorder(width: 0.6, borderColor: AppColor.Shared.coloBlack)
            dateView.leftSideImageView.image = UIImage.init(named: "icon_emi_duedays")
            
            dateView.HeaderNameLabel.setLabelValue(" As On Date")
        }
    }
    
    @IBOutlet weak var categoryTF: UITextField!
    
    @IBOutlet weak var demandTF: UITextField!{
        didSet{
            demandTF.addDonButton()
            demandTF.delegate = self
            demandTF.tintColor = AppColor.Shared.coloBlack
            demandTF.keyboardType = .numberPad
            
        }
    }
    @IBOutlet weak var areaTF: UITextField!
    
    var isPopUpHidden:Bool = true{
        didSet{
            self.showHidePopupView(isShow: isPopUpHidden)
        }
    }
    
    //MARK: - VARIABLES
    var dateString : String = ""
    var demandString = "30"
    var fromPrevious : Bool = false
    var emiFinanceList : [FinancePlanTypeDetailsModel] = []
    var categoryList : [CategoryListInfo]  = []
    
    var category_id:NSNumber = 0
    var financePlanType_id:String = "0"
    var fk_area : NSNumber = 0
    var fk_project : NSNumber = 0
    var fk_product : NSNumber = 0
    var areaDetailsList : [AreaDetailsListInfo] = []
    
    lazy var keyboardCancellable = Set<AnyCancellable>()
    var filtered_Info : FilterEmiReportCount?
    lazy var keyboardManager = KeyboardHeightPublisher
    
    //Network Call ViewModel
    let commonNetworkVM = SharedNetworkCall.Shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isPopUpHidden = true
        defaultValue()
        if fromPrevious == true{
            self.emiCountAPICall(filterParam: nil)
        }
        //layoutMargins
        keyboardHandler()
     
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fromPrevious = false
    }
    
    fileprivate func keyboardHandler() {
        
        keyboardManager
          
          .sink { completed in
            print(completed)
        } receiveValue: { height in
            print(height)
          
            self.popUpstackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            self.popUpstackView.isLayoutMarginsRelativeArrangement = true

            
        }.store(in: &keyboardCancellable)
    }
    
    func defaultValue(hasFilter:Bool=false){
        
        if hasFilter == false{
        let currentDate = DateTimeModel.shared.stringDateFromDate(Date())
        self.dateString = currentDate
        self.demandString = "30"
            self.fk_product = 0
            self.fk_product = 0
            self.fk_area = 0
            self.financePlanType_id = "0"
        }
        self.dateView.HeaderDetailTF.setTextFieldValue(self.dateString)
        
        self.demandTF.setTextFieldValue(self.demandString)
        
        self.financialPlanTF.setTextFieldValue("")
        self.category_id = 0
        self.categoryTF.setTextFieldValue("")
        
        self.areaTF.setTextFieldValue("")
        self.view.endEditing(true)
    }
    
    
    //MARK: - EMI REPORT COUNT
    func emiCountAPICall(hasFilter:Bool=false,filterParam:FilterEmiReportCount?){
        
        commonNetworkVM.collectionAPIManager?.emiCollectionReportCountAPICall(hasFilter:hasFilter,filterParam: filterParam, self.dateString, self.dateString,Demand: demandString) { responseHandler in
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            
            if statusCode == 0{
                let reportcount = EMICollectionReportCountModel.init(datas: info)
                self.reportCountSet(countLabel: self.todoCountLbl, count: reportcount.ToDoList)
                self.reportCountSet(countLabel: self.overDueCountLbl, count: reportcount.OverDue)
                self.reportCountSet(countLabel: self.demandCountLbl, count: reportcount.Upcoming)
                if hasFilter == true{
                    self.isPopUpHidden = hasFilter
                    self.commonNetworkVM.parserVm.mainThreadCall {
                        self.defaultValue(hasFilter: hasFilter)
                        
                    }
                }
            
            }else{
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
            
            
        }
    }
    
    //MARK: - emiFinancePlanAPICall()
    func emiFinancePlanAPICall(){
        commonNetworkVM.collectionAPIManager?.emiFinancePlanTypeAPICall({[unowned self] responseHandler in
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            if statusCode == 0{
                let list = info.value(forKey: "FinancePlanTypeDetailsList") as? [NSDictionary] ?? []
                
                self.emiFinanceList = []
                self.emiFinanceList = list.map{ FinancePlanTypeDetailsModel.init(datas: $0) }
                
                self.commonNetworkVM.parserVm.mainThreadCall {
                    
                    self.financeTypePopUp()
                    
                }
                
                
                
            }else{
                self.popupAlert(title: "Finance Plan Type", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
        })
    }
    
    func financeTypePopUp(){
        weak var popupTableVC = ReusableTableVC(items:self.emiFinanceList) { (cell:SubtitleTableViewCell, item, table) in
            
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.FinanceName
            
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
            
        } selectHandler: { selectedItem in
            
            self.financePlanType_id = selectedItem.ID_FinancePlanType
            self.financialPlanTF.setTextFieldValue(selectedItem.FinanceName)
                    
        }
        
        popupTableVC?.listingTitleString = "FINANCE PLAN TYPE"
        popupTableVC?.modalTransitionStyle = .coverVertical
        popupTableVC?.modalPresentationStyle = .overCurrentContext
        self.present(popupTableVC!, animated: true)
    }
    
    deinit {
        
        print("deallocate list pop up")
        
    }
    
    //MARK: - emiCategoryAPICall()
    func emiCategoryAPICall(){
        commonNetworkVM.collectionAPIManager?.emiCategoryAPICall({[unowned self] responseHandler in
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            if statusCode == 0{
                
                let list = info.value(forKey: "CategoryList") as? [NSDictionary] ?? []
                self.categoryList = []
                
                self.categoryList = list.map{ CategoryListInfo(datas: $0) }
                
                self.commonNetworkVM.parserVm.mainThreadCall {
                    self.categroyPopUP()
                }
                
                
            }else{
                self.popupAlert(title: "Category", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
        })
    }
    
    func categroyPopUP(){
        weak var popupTableVC = ReusableTableVC(items:self.categoryList) { (cell:SubtitleTableViewCell, item, table) in
            
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
            
        } selectHandler: { selectedItem in
            
            self.category_id = selectedItem.ID_Category
            self.categoryTF.setTextFieldValue(selectedItem.CategoryName)
                    
        }
        
        popupTableVC?.listingTitleString = "CATEGORY"
        popupTableVC?.modalTransitionStyle = .coverVertical
        popupTableVC?.modalPresentationStyle = .overCurrentContext
        self.present(popupTableVC!, animated: true)
    }
    
    //MARK: - emiAreaAPICall()
    func emiAreaAPICall(){
        commonNetworkVM.collectionAPIManager?.emiAreaAPICall({[unowned self] responseHandler in
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            if statusCode == 0{
                let list = info.value(forKey: "AreaDetailsList") as? [NSDictionary] ?? []
                
                
                self.areaDetailsList = []
                
                self.areaDetailsList = list.map{ AreaDetailsListInfo(datas: $0) }
                
                self.commonNetworkVM.parserVm.mainThreadCall {
                    self.areaPopUp()
                }
                
            }else{
                self.popupAlert(title: "Area", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
        })
    }
    
    func areaPopUp(){
        weak var popupTableVC = ReusableTableVC(items:self.areaDetailsList) { (cell:SubtitleTableViewCell, item, table) in
            
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
            
        } selectHandler: { selectedItem in
            
            self.fk_area = selectedItem.FK_Area
            self.areaTF.setTextFieldValue(selectedItem.Area)
                    
        }
        
        popupTableVC?.listingTitleString = "AREA"
        popupTableVC?.modalTransitionStyle = .coverVertical
        popupTableVC?.modalPresentationStyle = .overCurrentContext
        self.present(popupTableVC!, animated: true)
    }
    
    
    
    func reportCountSet(countLabel:UILabel,count:NSNumber){
        DispatchQueue.main.async {
            countLabel.setLabelValue("\(count)")
        }
    }
    

    @IBAction func backButtonAction(_ sender: BackButtonCC) {
        let emiVC = AppVC.Shared.emiCategories
        if self.allControllers.contains(emiVC){
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func todoButtonAction(_ sender: UIButton) {
        
        let todoListingVC = AppVC.Shared.emiCategoriesListing
        todoListingVC.submode = SubMode.Shared.emiReportTodo
        todoListingVC.dateString = dateString
        todoListingVC.demandString = demandString
        todoListingVC.fk_area = fk_area
        todoListingVC.financePlanType_id = financePlanType_id
        todoListingVC.fk_product = fk_product
        todoListingVC.fk_project = fk_project
        todoListingVC.filteredList = []
        
        DispatchQueue.main.async {[unowned self] in
            if !(self.allControllers.contains(todoListingVC)){
                let todoCount = self.todoCountLbl.text ?? "0"
                if todoCount != "0"{
                self.navigationController?.pushViewController(todoListingVC, animated: true)
                }else{
                    self.popupAlert(title: "", message: noDataString, actionTitles: [okTitle], actions: [{action1 in },nil])
                }
            }else{
                print("all ready contain")
            }
        }
        
    }
    
    
    @IBAction func overDueButtonAction(_ sender: UIButton) {
        
        let overDueListingVC = AppVC.Shared.emiCategoriesListing
        overDueListingVC.submode = SubMode.Shared.emiReportOverDue
        overDueListingVC.demandString = demandString
        overDueListingVC.dateString = dateString
        
        overDueListingVC.fk_area = fk_area
        overDueListingVC.financePlanType_id = financePlanType_id
        overDueListingVC.fk_product = fk_product
        overDueListingVC.fk_project = fk_project
        overDueListingVC.filteredList = []
        
        DispatchQueue.main.async {[unowned self] in
            if !(self.allControllers.contains(overDueListingVC)){
                
                
                let overdueCount = self.overDueCountLbl.text ?? "0"
                if overdueCount != "0"{
                    self.navigationController?.pushViewController(overDueListingVC, animated: true)
                }else{
                    self.popupAlert(title: "", message: noDataString, actionTitles: [okTitle], actions: [{action1 in },nil])
                }
                
            }else{
                print("all ready contain")
            }
        }
    }
    
    @IBAction func demandButtonAction(_ sender: Any) {
        
        let demandListingVC = AppVC.Shared.emiCategoriesListing
        demandListingVC.submode = SubMode.Shared.emiReportDemand
        demandListingVC.dateString = dateString
        demandListingVC.demandString = demandString
        
        demandListingVC.fk_area = fk_area
        demandListingVC.financePlanType_id = financePlanType_id
        demandListingVC.fk_product = fk_product
        demandListingVC.fk_project = fk_project
        demandListingVC.filteredList = []
        
        DispatchQueue.main.async {[unowned self] in
            if !(self.allControllers.contains(demandListingVC)){
                let demandCount = self.demandCountLbl.text ?? "0"
                if demandCount != "0"{
                    self.navigationController?.pushViewController(demandListingVC, animated: true)
                }else{
                    self.popupAlert(title: "", message: noDataString, actionTitles: [okTitle], actions: [{action1 in },nil])
                }

            }else{
                print("all ready contain")
            }
        }
    }
    
    
    @IBAction func filterButtonClickedAction(_ sender: UIButton) {
        
        self.isPopUpHidden = false
    }
    
    
    @IBAction func financialPlanButtonAction(_ sender: UIButton) {
        self.emiFinancePlanAPICall()
    }
    
    @IBAction func categoryButtonAction(_ sender: UIButton) {
        self.emiCategoryAPICall()
    }
    
    @IBAction func areaButtonAction(_ sender: UIButton) {
        emiAreaAPICall()
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        
        let currentDate = DateTimeModel.shared.stringDateFromDate(Date())
        let asOnDateString = self.dateView.HeaderDetailTF.text ?? currentDate
        self.dateString = asOnDateString
        let getDemand = self.demandTF.text ?? "30"
        self.demandString = getDemand
        let selectedProject = self.categoryList.filter{ return $0.ID_Category == self.category_id}
        if selectedProject.count > 0{
        fk_project = selectedProject.first?.Project == 1 ? selectedProject.first!.ID_Category : 0
        fk_product = selectedProject.first?.Project == 0 ? selectedProject.first!.ID_Category : 0
        }
        self.filtered_Info = FilterEmiReportCount.init(FK_FinancePlanType: financePlanType_id, FK_Product: fk_product, FK_Area: fk_area, FK_Category: fk_project)
        print(filtered_Info)
        
        
        self.emiCountAPICall(hasFilter: true, filterParam: filtered_Info)
        
        
    
    }
    
    @IBAction func clearButtonAction(_ sender: UIButton) {
        defaultValue()
    }
    
    func showHidePopupView(isShow:Bool=true){
        
        self.popUPView.map{$0.isHidden = isShow}
        self.popUPView.isHidden = isShow
        
        UIView.transition(with: self.view, duration: 0.5,
                          options: [.curveEaseOut, .transitionCrossDissolve],
          animations: {
            
            self.view.layoutIfNeeded()
            
          },
          completion: nil
        )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == popUPBGView{
            isPopUpHidden = true
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == demandTF{
            if textField.text?.count == 0{
                self.demandString = "30"
                self.demandTF.setTextFieldValue(self.demandString)
            }
        }
    }

}

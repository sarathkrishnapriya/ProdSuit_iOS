//
//  EmiCategoriesListingVC.swift
//  ProdSuit
//
//  Created by MacBook on 06/06/23.
//

import UIKit
import Combine

class EmiCategoriesListingVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet var emiCategoriesListingTableView: UITableView!
    @IBOutlet weak var customerTF: UITextField!{
        didSet{
            self.customerTF.addDonButton()
            self.customerTF.delegate = self
            self.customerTF.setBorder(width: 1, borderColor: AppColor.Shared.coloBlack)
            self.customerTF.keyboardType = .default
            self.customerTF.setCornerRadius(size: 5)
        }
    }
    @IBOutlet weak var mobileTF: UITextField!{
        didSet{
            self.mobileTF.addDonButton()
            self.mobileTF.delegate = self
            self.mobileTF.setBorder(width: 1, borderColor: AppColor.Shared.coloBlack)
            self.mobileTF.keyboardType = .numberPad
            self.mobileTF.setCornerRadius(size: 5)
            
            
        }
    }
    @IBOutlet weak var areaTF: UITextField!{
        didSet{
            self.areaTF.addDonButton()
            self.areaTF.delegate = self
            self.areaTF.setBorder(width: 1, borderColor: AppColor.Shared.coloBlack)
            self.areaTF.keyboardType = .default
            self.areaTF.setCornerRadius(size: 5)
        }
    }
    @IBOutlet weak var dueAmountTF: UITextField!{
        didSet{
            self.dueAmountTF.addDonButton()
            self.dueAmountTF.delegate = self
            self.dueAmountTF.setBorder(width: 1, borderColor: AppColor.Shared.coloBlack)
            self.dueAmountTF.keyboardType = .decimalPad
            self.dueAmountTF.setCornerRadius(size: 5)
        }
    }
    @IBOutlet weak var popupStackView: UIStackView!
    // MARK: - VARIABLES
    var isPopUPShow:Bool = false{
        didSet{
            isPopUPShow == false ? removePopUPView() : addPopUPView()
        }
    }
   
    var submode:String = "1"
    var demandString = "30"
    var financePlanType_id:String = "0"
    var fk_area : NSNumber = 0
    var fk_project : NSNumber = 0
    var fk_product : NSNumber = 0
    var dateString : String = ""
    var mobileValidator :  MobileValidator!
    var mobileNumber = ""
    
    
    lazy var keyboardCancellable = Set<AnyCancellable>()
    lazy var keyboardManager = KeyboardHeightPublisher

    
    var collectionReportList : [EMICollectionReportModel] = []
    var filteredList = [EMICollectionReportModel]()
    

    let commonNetworkVM = SharedNetworkCall.Shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emiCategoriesListingTableView.dataSource = self
        emiCategoriesListingTableView.delegate = self
        emiCategoriesListingTableView.showsVerticalScrollIndicator = false
        emiCategoriesListingTableView.showsHorizontalScrollIndicator = false
        emiCategoriesListingTableView.separatorStyle = .none
        
         
        emiCategoriesListingTableView.contentInset = UIEdgeInsets.init(top: 5, left: 0, bottom: 5, right: 0)
        emiCategoriesListingTableView.backgroundColor = AppColor.Shared.greylight
        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        
        swipeGestureRecognizerDown.direction = .down
        self.popUpView.addGestureRecognizer(swipeGestureRecognizerDown)
        
        keyboardHandler()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func keyboardHandler() {
        
        keyboardManager
          
          .sink { completed in
            print(completed)
        } receiveValue: { height in
            print(height)
          
            self.popupStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            self.popupStackView.isLayoutMarginsRelativeArrangement = true

            
        }.store(in: &keyboardCancellable)
    }
    
  
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {

        self.isPopUPShow = false

           UIView.animate(withDuration: 0.25) {
               self.view.layoutIfNeeded()
           }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let titleString =  submode == "1" ? "TODO" : submode == "2" ? "OVER DUE" : "DEMAND"
        self.titleLabel.setLabelValue(titleString)
        
        
    
       
        isPopUPShow = false
        self.collectionEMIReportAPICall()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.collectionReportList = []
        self.emiCategoriesListingTableView.reloadData()
    }
    
    func defaultValues(){
        self.mobileNumber = ""
        self.customerTF.setTextFieldValue("")
        self.mobileTF.setTextFieldValue("")
        self.areaTF.setTextFieldValue("")
        self.dueAmountTF.setTextFieldValue("")
    }
    
    
    func removePopUPView(){
        
        self.view.sendSubviewToBack(self.popUpView)
        UIView.transition(with: self.view, duration: 0.5,
                          options: [.curveEaseOut, .transitionCrossDissolve],
          animations: {
            
            self.view.layoutIfNeeded()
            
          },
          completion: nil
        )
    }
    
    func addPopUPView(){
        
        self.view.bringSubviewToFront(self.popUpView)
        UIView.transition(with: self.view,
           duration: 0.5,
           options: [.curveEaseOut, .transitionCrossDissolve],
           animations: {
           
            self.view.layoutIfNeeded()

            
           },
           completion: nil
         )
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        
        self.isPopUPShow = !isPopUPShow
        
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.defaultValues()
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        
        isPopUPShow = false
        
        self.view.endEditing(true)
        self.mobileNumber = self.mobileTF.text ?? ""
        let customerName = self.customerTF.text ?? ""
        let areaName = self.areaTF.text ?? ""
        let dueAmount = self.dueAmountTF.text ?? ""
        
        
        self.filteredList = []
        
        var conditions: [(EMICollectionReportModel) -> Bool] = []

        if customerName.count != 0{
            conditions.append({$0.customer.range(of:customerName, options: .caseInsensitive) != nil })
        }
        
        if self.mobileNumber.count != 0{
            conditions.append({$0.mobile.range(of:self.mobileNumber, options: .caseInsensitive) != nil})
        }
        
        if areaName.count != 0{
            conditions.append({$0.area.range(of:areaName, options: .caseInsensitive) != nil})
        }
        
        if dueAmount.count != 0{
            conditions.append({$0.dueAmount.range(of:dueAmount, options: .caseInsensitive) != nil})
        }
        
        filteredList = self.collectionReportList.filter{
            item in
            conditions.reduce(true){ $0 && $1(item) }
        }
        
        
         
        
        self.commonNetworkVM.parserVm.mainThreadCall {
            self.defaultValues()
            self.emiCategoriesListingTableView.reloadData()
        }
        
    }
    
    
    
    @IBAction func backButtonAction(_ sender: BackButtonCC) {
        
        weak var vc = AppVC.Shared.emiCategoriesListing
        
        if self.allControllers.contains(vc!){
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    //MARK:- collectionEMIReportAPICall()
    func collectionEMIReportAPICall(){
        
        let filterInfo = FilterEmiReportCount(FK_FinancePlanType: financePlanType_id, FK_Product: fk_product, FK_Area: fk_area, FK_Category: fk_project)
        
        let details = EMIReportParamModel.init(fromDateString: dateString, toDateString: dateString, demandString: demandString, submode: submode,filterdInfo: filterInfo)
        
        self.commonNetworkVM.collectionAPIManager?.collectionEMIReportAPICall(details: details, { responseHandler in
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            
            if statusCode == 0{
                let list = info.value(forKey: "EMICollectionReportList") as? [NSDictionary] ?? []
                
                self.collectionReportList = []
                
                self.collectionReportList = list.map{ EMICollectionReportModel(datas: $0) }
                
                self.commonNetworkVM.parserVm.mainThreadCall {
                    self.titleLabel.addCountLabel(mainView: self.titleLabel.superview!,count: "\(self.collectionReportList.count)")
                    self.emiCategoriesListingTableView.reloadData()
                }
                
                
            }else{
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
            
            print(info)
        })
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

extension EmiCategoriesListingVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.filteredList.count > 0 ? self.filteredList.count : self.collectionReportList.count
        self.titleLabel.addCountLabel(mainView: self.titleLabel.superview!,count: "\(count)")
        return self.filteredList.count > 0 ? self.filteredList.count : self.collectionReportList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.shared.emiCategoriesListingCell) as! EMICategoriesListingTVC
        
       
        
        let infoModel = self.filteredList.count > 0 ? self.filteredList[indexPath.row] : self.collectionReportList[indexPath.row]
        cell.infoModel = infoModel
        let color = submode == "1" ? AppColor.Shared.todolist_Color : submode == "2" ? AppColor.Shared.overdue_Color : AppColor.Shared.upcomung_Color
        cell.emiNoBGView.setBGColor(color: color)
        UIView.animate(withDuration: 0) {
            
            cell.emiNoBGView.layoutIfNeeded()
        }
        cell.selectionStyle = .gray
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedInfo = self.filteredList.count > 0 ? self.filteredList[indexPath.row] : self.collectionReportList[indexPath.row]
        
        
        let emiCollectionInfoPage = AppVC.Shared.emiCollectionDetails
        emiCollectionInfoPage.infoModel = selectedInfo
        
        DispatchQueue.main.async {[weak self] in
            if !(self?.allControllers.contains(emiCollectionInfoPage))!{
                self?.navigationController?.pushViewController(emiCollectionInfoPage, animated: true)
            }else{
                print("all ready contain")
            }
        }
    }
    
    
}

extension EmiCategoriesListingVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField{
        case mobileTF:
            textField.displayTooltip("Mobile")
            textField.keyboardType = .numberPad
            mobileValidator =  MobileValidator.init(textField: textField, length: 12)
                print(mobileValidator.numberString)
        case areaTF:
            textField.displayTooltip("Area")
            textField.keyboardType = .default
        case dueAmountTF:
            textField.displayTooltip("Due Amount")
            textField.keyboardType = .decimalPad
        default:
            textField.displayTooltip("Customer")
            textField.keyboardType = .default
        }
    }
    
   
}

//
//  WalkingCustomerVC.swift
//  ProdSuit
//
//  Created by MacBook on 12/06/23.
//

import UIKit
import Combine

class WalkingCustomerVC: UIViewController {

    @IBOutlet weak var customerTF: LSideImageViewTF!{
        didSet{
            customerTF.addDonButton()
            customerTF.autocorrectionType = .no
            customerTF.keyboardType = .default
            customerTF.tintColor = AppColor.Shared.coloBlack
            
        }
    }
    
    @IBOutlet weak var phoneTF: UITextField!{
        didSet{
            
            
            phoneTF.addDonButton()
            phoneTF.delegate = self
            phoneTF.keyboardType = .asciiCapableNumberPad
            phoneTF.tintColor = AppColor.Shared.coloBlack
        }
    }
    
    @IBOutlet weak var assignedToTF: LRSideImageViewTF!{
        didSet{
            assignedToTF.tintColor = UIColor.clear
        }
    }
    
    
    @IBOutlet weak var wcScrollView: UIScrollView!
    
    
    @IBOutlet weak var assignedDateView: TransDateView!{
        didSet{
            assignedDateView.HeaderDetailTF.setBorder(width: 0.6, borderColor: AppColor.Shared.coloBlack)
            self.assignedDateView.datePickerView.minimumDate = Date()
            assignedDateView.leftSideImageView.image = UIImage.init(named: "icon_emi_duedays")
            assignedDateView.HeaderDetailTF.tintColor = AppColor.Shared.coloBlack
            assignedDateView.HeaderNameLabel.setLabelValue(" Assigned Date *")
        }
    }
    @IBOutlet weak var wcTextView: UITextView!{
        didSet{
            wcTextView.delegate = self
            wcTextView.tintColor = AppColor.Shared.coloBlack
            wcTextView.addDonButton()
        }
    }
    @IBOutlet weak var wcInfoStackView: UIStackView!
    
    
    lazy var keyboardManager = KeyboardHeightPublisher
    lazy var keyboardCancellable = Set<AnyCancellable>()
    lazy var wcTextViewCancellable = Set<AnyCancellable>()
    lazy var mobileTextCancellable = Set<AnyCancellable>()
    
    var wCTxt = "Description"
    
    var mobileValidator :  MobileValidator!
    var mobileNumber = ""
    
    let commonNetworkLayer = SharedNetworkCall.Shared
    
    lazy var assignedToList : [EmployeeDetailsListInfo] = []
    
    var selectedAssignedTo:EmployeeDetailsListInfo?
    
    private var validationVm : WCValidationViewModel = WCValidationViewModel.init(brockenRules: [])
    
    fileprivate func textDescriptionChange() {
        textViewPublisher.sink { text in
            self.wCTxt = text
        }.store(in: &wcTextViewCancellable)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        keyboardHandler()
        mobileTextDidChange()
        textDescriptionChange()
        // Do any additional setup after loading the view.
    }
    
    func mobileTextDidChange(){
        textFieldPublisher.sink { text in
            self.mobileNumber = text
            print(self.mobileNumber)

        }.store(in: &mobileTextCancellable)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaultFormValue()
        employeeAPICall()
    }
    
    //MARK: - employeeAPICall()
    func employeeAPICall(){
        
        self.commonNetworkLayer.leadMangeAPIManager?.walk_in_customer_APICall(RequestMode.shared.walkInCustomer, {  responseHandler in
            
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            
            
            if statusCode == 0{
                
                let list = info.value(forKey: "EmployeeDetailsList") as? [NSDictionary] ?? []
                
                self.assignedToList = []
                self.assignedToList = list.map{ EmployeeDetailsListInfo(datas: $0) }
                
                print(self.assignedToList)
        
            }else{
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
            
        })
        
    }
    
    
    func assignedToAction(){
       //print("user select from list")
       
       let popupTableVC = ReusableTableVC(items: self.assignedToList) { (cell:SubtitleTableViewCell, collectData, table) in
           
           cell.addcontentView(cell: cell)
           
           //let indexLevel = table.indexPath(for: cell)
           if let index = cell.tag as? Int{
               cell.indexLabel.text = "\(index + 1)"
               
           }
           cell.titleLabel.text = collectData.EmpName
           cell.detailsLabel.text = collectData.DesignationName
           cell.accessoryType = .disclosureIndicator
           UIView.animate(withDuration: 0.1) {
               cell.layoutIfNeeded()
           }
           
       } selectHandler: { collectData in
           
       
               self.selectedAssignedTo = collectData
               self.assignedToTF.setTextFieldValue(self.selectedAssignedTo?.EmpName ?? "")
               print(self.selectedAssignedTo?.EmpName ?? "")
           
           
           
       }
       
        popupTableVC.listingTitleString = "Assigned To"
       popupTableVC.modalTransitionStyle = .coverVertical
       popupTableVC.modalPresentationStyle = .overCurrentContext
       self.present(popupTableVC, animated: true)
       
   }
    
    fileprivate func keyboardHandler() {
        keyboardManager
          
          .sink { completed in
            print(completed)
        } receiveValue: { height in
            print(height)
            
            self.wcScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            
            
        }.store(in: &keyboardCancellable)
    }
    
    func defaultFormValue(){
        
        let currentDate =  DateTimeModel.shared.stringDateFromDate(Date())
        
        self.assignedDateView.HeaderDetailTF.setTextFieldValue(currentDate)
        self.customerTF.setTextFieldValue("")
        self.phoneTF.setTextFieldValue("")
        self.assignedToTF.setTextFieldValue("")
        wCTxt = "Description"
        self.wcTextView.setValue(wCTxt)
        self.wcTextView.setTextColor(UIColor.lightGray)
        self.mobileNumber = ""
        
        self.selectedAssignedTo  = EmployeeDetailsListInfo.init(datas: [:])
        
    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        let walkingCustomerVc = AppVC.Shared.walkingCustomerPage
        DispatchQueue.main.async {
            if self.allControllers.contains(walkingCustomerVc){
            self.navigationController?.popViewController(animated: true)
            }
        }
    
    }
    
    @IBAction func assignedByButtonAction(_ sender: UIButton) {
        assignedToAction()
    }
    
    //MARK: - walkInCustomerUpdatAPICall()
    func walkInCustomerUpdatAPICall(vm:WCValidationViewModel) {
       let descriptions = wCTxt == "Description" ? "" : wCTxt
        commonNetworkLayer.leadMangeAPIManager?.walk_in_customer_Updation(id_CustomerAssignment: "\(vm.selectedAssinedToID)", name: vm.customername, mobile: mobileNumber, date: vm.assignedDateString, description: descriptions, { responseHandler in
            
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            //let info = responseHandler.info
            
            if statusCode == 0{
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in
                    
                    self.defaultFormValue()
                    
                },nil])
            }else{
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }

        })
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        
        sender.flash(animation: .opacity, withDutation: 0.4, repeatCount: 0)
    
        validationVm.selectedAssinedToID = self.selectedAssignedTo?.ID_Employee ?? -1
        validationVm.customername = self.customerTF.text ?? ""
        
        validationVm.assignedDateString =  DateTimeModel.shared.formattedDateFromString(dateString: self.assignedDateView.HeaderDetailTF.text ?? "", withFormat: "yyyy-MM-dd")!
        
        if validationVm.isValid == true{
            print("submit api ")
            
            self.walkInCustomerUpdatAPICall(vm: validationVm)
        }
        else{
            self.popupAlert(title: "", message: self.validationVm.brockenRules.first!.message, actionTitles: [okTitle], actions: [{action1 in },nil])
        }
        
        
        
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        sender.flash(animation: .opacity, withDutation: 0.4, repeatCount: 0)
        defaultFormValue()
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

extension WalkingCustomerVC:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneTF{

        mobileValidator =  MobileValidator.init(textField: textField, length: 12)

           
            print(mobileValidator.numberString)
        }
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == phoneTF{
//
//        mobileValidator =  MobileValidator.init(textField: textField, length: 12)
//
//            self.mobileNumber = mobileValidator.numberString
//            print(self.mobileNumber)
//
//        }
//    }
    
    
    
    
    
}


extension WalkingCustomerVC:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        
        UIView.animate(withDuration: 0.1, delay: 0) {
            self.wcTextView.layoutIfNeeded()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = AppColor.Shared.coloBlack
            
            
        }
        UIView.animate(withDuration: 0.1, delay: 0) {
            self.wcTextView.layoutIfNeeded()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == wcTextView{
            if textView.text.isEmpty {
                wCTxt = "Description"
                textView.setValue(wCTxt)
                textView.setTextColor(UIColor.lightGray)
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView == wcTextView{
            
            
            let currentString : NSString = wCTxt  as NSString
            let newString  : NSString = currentString.replacingCharacters(in: range, with: text) as NSString
            if newString.length == messageMaxLength{
                self.view.endEditing(true)
            }
            return newString.length <= messageMaxLength
        }
    
            return true
        
        
    }
}

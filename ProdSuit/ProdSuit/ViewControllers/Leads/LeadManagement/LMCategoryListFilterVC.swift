//
//  LMCategoryListFilterVC.swift
//  ProdSuit
//
//  Created by MacBook on 15/05/23.
//

import UIKit
import Combine

protocol FilterCategoryListDelegate:AnyObject{
    func filteredData(_ result:(NSNumber,String,String))
}

class LMCategoryListFilterVC: UIViewController,UITextFieldDelegate {
    
    lazy var apiParserVm : APIParserManager = APIParserManager()
    
    var parserVm : GlobalAPIViewModel!

    @IBOutlet weak var filterBGView: UIView!
    
    @IBOutlet weak var employeeTF: FilterListTF!
    
    @IBOutlet weak var leadDetailsTF: FilterRightViewTF!
    
    @IBOutlet weak var leadDetailNameTF: FilterListTF!{
        didSet{
            self.leadDetailNameTF.addDonButton()
        }
    }
    

    var selectedEmployee : EmployeeAllDetails!
    var lmSelectedTodoLeadDetails:(NSNumber,String,String) = (0,"Lead Details","")
    var list : [LMLeadDetails]  = []
    weak var filterDelegate:FilterCategoryListDelegate?
    lazy var keyboardManager = KeyboardHeightPublisher
    lazy var keyboardCancellable = Set<AnyCancellable>()
    lazy var lmTodoLeadDetailsCancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        
           keyboardHandler()
        self.leadDetailNameTF.delegate = self
        self.parserVm = GlobalAPIViewModel(bgView: self.view)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let info = self.selectedEmployee{
            self.employeeTF.text = info.EmpName
            
        }
    }
    
    fileprivate func keyboardHandler() {
        keyboardManager
          
          .sink { completed in
            print(completed)
        } receiveValue: { height in
            print(height)
            
            
            
            self.view.frame.origin.y = height > 0 ? -height : 0
            
        }.store(in: &keyboardCancellable)
    }
    
    @IBAction func employeeButtonAction(_ sender: UIButton) {
        
        
        
    }
    
    
    @IBAction func leadDetailsButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if let info = self.selectedEmployee{
            self.todoListLeadDetailsAPICall(fk_employee: "\(info.ID_Employee)")
        }
        
//        self.leadDetailsPopUpPage(list: self.list)
        
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        self.dismiss(animated: true)
        
    }
    
    
    
    @IBAction func okButtonAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if self.lmSelectedTodoLeadDetails.0 == 0 || self.list.count == 0{
            self.popupAlert(title: "", message: "Select \(self.lmSelectedTodoLeadDetails.1)", actionTitles: [okTitle], actions: [{action1 in
                print("no data found")
            },nil])
        }else{
            if self.lmSelectedTodoLeadDetails.2 == ""{
                self.popupAlert(title: "", message: "\(self.lmSelectedTodoLeadDetails.1) Cannot be blank", actionTitles: [okTitle], actions: [{action1 in
                    print("no data found")
                },nil])
            }else{
                self.filterDelegate?.filteredData((self.lmSelectedTodoLeadDetails.0, self.lmSelectedTodoLeadDetails.1, self.lmSelectedTodoLeadDetails.2))
                  self.dismiss(animated: true)
            }
        }
       
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.list = []
        self.leadDetailsTF.text = ""
        self.leadDetailNameTF.text = ""
        self.lmSelectedTodoLeadDetails = (0,"Lead Details","")
    }
    
    
    func leadDetailsPopUpPage(list:[LMLeadDetails]){
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            
            cell.titleLabel.text = item.TodoListLeadDetailsName
           
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            
            
            print(item)
            self.leadDetailsTF.text = item.TodoListLeadDetailsName
            self.leadDetailNameTF.text = ""
            self.leadDetailNameTF.customPlaceholder(color: AppColor.Shared.hintTextColor, text: "\(item.TodoListLeadDetailsName)")
            self.leadDetailNameTF.keyboardType = (item.TodoListLeadDetailsName == "Customer Name" || item.TodoListLeadDetailsName == "Lead Number") ? .default : .numberPad
            self.leadDetailNameTF.autocorrectionType = .no
            self.lmSelectedTodoLeadDetails.0 = item.ID_TodoListLeadDetails
            self.lmSelectedTodoLeadDetails.1 = item.TodoListLeadDetailsName
        }
        
        popUpVC.listingTitleString = "LEAD DETAIL"
        
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.present(popUpVC, animated: false)
    }
    
    //MARK: - todoListLeadDetailsAPICall()
    func todoListLeadDetailsAPICall(fk_employee:String){
        
        let requestMode = RequestMode.shared.lmTodoListLeadDetails
        let bankKey = preference.appBankKey
        let fk_employee = fk_employee
        let token = preference.User_Token
        let fk_company = "\(preference.User_FK_Company)"
        
         if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
            let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
            let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
            let efk_employee = instanceOfEncryptionPost.encryptUseDES(fk_employee, key: SKey),
            let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Employee":efk_employee,"FK_Company":efk_company]
            
             let request = apiParserVm.request(urlPath: URLPathList.Shared.lmTodoListLeadDetails,arguMents: arguMents)
             self.parserVm.modelInfoKey = "TodoListLeadDetails"
             self.parserVm.progressBar.showIndicator()
             self.parserVm.parseApiRequest(request)
                 
             self.parserVm.$responseHandler
                 .dropFirst()
                 .sink { responseHandler in
                     self.parserVm.progressBar.hideIndicator()
                     let statusCode = responseHandler.statusCode
                     let message = responseHandler.message
                     
                     if statusCode == 0{
                         
                         let list = responseHandler.info.value(forKey: "TodoListLeadDetailsList") as? [NSDictionary] ?? []
                         
                         self.list = []
                         self.list = list.map{ LMLeadDetails(datas: $0) }
                         
                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                             self.leadDetailsPopUpPage(list: self.list)
                         }
                         
                     }else{
                         self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in
                             print("no data found")
                         },nil])
                     }
                     print(responseHandler.info)
                     self.lmTodoLeadDetailsCancellable.dispose()
                 }.store(in: &lmTodoLeadDetailsCancellable)
         }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString : NSString = textField.text!  as NSString
        let newString : NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        self.lmSelectedTodoLeadDetails.2 = newString as String
        let id = lmSelectedTodoLeadDetails.0
        return id == 1 ? newString.length <= 20 : id == 2 ? newString.length <= mobileNumberMaxLength :  newString.length <= 20
        
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


extension LManagementCategoryListVC:FilterCategoryListDelegate{
    func filteredData(_ result: (NSNumber, String, String)) {
        self.lmanageCategoryListVm.leadMangeDetailListAPICall(subMode: subMode, branchCode: "\(preference.User_FK_Branch)", name: result.2, id: "\(result.0)", criteria: "", fk_employee: fk_Employee)
    }
    
    
}

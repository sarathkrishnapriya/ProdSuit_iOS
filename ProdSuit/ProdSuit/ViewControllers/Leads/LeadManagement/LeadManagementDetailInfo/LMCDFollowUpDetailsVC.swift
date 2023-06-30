//
//  LMCDFollowUpDetailsVC.swift
//  ProdSuit
//
//  Created by MacBook on 23/05/23.
//

import UIKit
import Combine


class LMCDFollowUpDetailsVC: UIViewController {
    
    // next action section
    
    
    @IBOutlet weak var nxtActionEmployeeTF: NextActionEmployeeTF!
    @IBOutlet weak var nextActionDepartmentTF: NextActionDepartMentTF!
    @IBOutlet weak var nxtActionPriorityTF: NextActionPriorityTF!
    @IBOutlet weak var nxtActionFollowUpDateTF: NextActionDateTF!
    @IBOutlet weak var nxtActionTypeTF: FollowUpActionTypeTF!
    @IBOutlet weak var nxtActionTF: NextActionTF!
    
    
    @IBOutlet weak var nextActionView: UIView!
    
    @IBOutlet weak var nextActionSubView: UIView!
    
    @IBOutlet weak var nextActionStackView: UIStackView!
    
    
    
    
    // follow up section
 
    @IBOutlet weak var uploadImageViewTwo: UIImageView!
    
    @IBOutlet weak var uploadImagViewOne: UIImageView!
    
    @IBOutlet weak var imageUploadView: UIView!
    
    @IBOutlet weak var longitudeTF: UITextField!
    @IBOutlet weak var latitudeTF: UITextField!
    
    @IBOutlet weak var locationView: UIView!
    
    lazy var keyboardManager = KeyboardHeightPublisher
    lazy var keyboardCancellable = Set<AnyCancellable>()
    
    //MARK: - FOLLOWUP VIEWMODEL
    var followUpVm:FollowUpViewModel!
    
    
    @IBOutlet weak var employeeRemarkTV: UITextView!{
        didSet{
            self.employeeRemarkTV.addDonButton()
            self.employeeRemarkTV.autocorrectionType = .no
            
        }
    }
    @IBOutlet weak var employeeRemarkLabel: UILabel!{
        didSet{
            self.employeeRemarkLabel.setTextColor(UIColor.clear)
            self.employeeRemarkLabel.setFontSize(13, font: .regular)
        }
    }
    @IBOutlet weak var employeeRemarkView: UIView!{
        didSet{
            self.employeeRemarkView.setBorder(width: 0.6, borderColor: AppColor.Shared.coloBlack)
            self.employeeRemarkView.setCornerRadius(size: 5)
        }
    }
    
    @IBOutlet weak var customerRemarkTV: UITextView!{
        didSet{
            self.customerRemarkTV.addDonButton()
            self.customerRemarkTV.autocorrectionType = .no
        }
    }
    @IBOutlet weak var customerRemarkLabel: UILabel!{
        didSet{
            self.customerRemarkLabel.setTextColor(UIColor.clear)
            self.customerRemarkLabel.setFontSize(13, font: .regular)
        }
    }
    @IBOutlet weak var customerRemarkView: UIView!{
        didSet{
            self.customerRemarkView.setBorder(width: 0.6, borderColor: AppColor.Shared.coloBlack)
            self.customerRemarkView.setCornerRadius(size: 5)
        }
    }
    
    
    // Action Type Details Outlets
    @IBOutlet weak var statusDetailsView: UIView!
    @IBOutlet weak var statusDetailsTF: UITextField!
    
    
    // Date  Outlets
    @IBOutlet weak var dateBGView: UIView!
    
    @IBOutlet weak var dateTF: UITextField!
    
    
    // Status By Outlets
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusTF: UITextField!
    
    
    // Follow By Outlets
    @IBOutlet weak var followByBGView: UIView!
    
    @IBOutlet weak var followByTF: UITextField!
    
    
// Action Type Outlets
    @IBOutlet weak var actionTypeTF: UITextField!
    @IBOutlet weak var actionTypeBGView: UIView!
    
    
    
    @IBOutlet weak var followUpSegmentControl: UISegmentedControl!
    
    var selectedSegmentValue:Int=0{
        didSet{
            switch selectedSegmentValue{
            case 1:
                let titleString = self.followUpSegmentControl.titleForSegment(at: selectedSegmentValue)
                
                self.selectedLabel.setLabelValue(titleString ?? "")
            default:
                let titleString = self.followUpSegmentControl.titleForSegment(at: selectedSegmentValue)
             
                self.selectedLabel.setLabelValue(titleString ?? "")
            }
            self.changeSegmentedControlLinePosition(segmentedControl: followUpSegmentControl)
            self.hideFollowUpNextActionView(selectedSegmentValue)
        }
    }
    
    @IBOutlet weak var followUpView: UIView!
    @IBOutlet weak var followUpSubView: UIView!
    @IBOutlet weak var followUpStackView: UIStackView!
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var selectedLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var customerRemarkTxt = "Customer Remark"
    var employeeRemarkTxt = "Employee Remark"
    
    lazy var actionTypeList : [FollowUpTypeDetailsListInfo] = []
    var selectedActionType : FollowUpTypeDetailsListInfo?
    var selectedNextActionType : FollowUpTypeDetailsListInfo?
    
    lazy var followUpByInfoList : [EmployeeDetailsListInfo] = []
    var selectedFollowUpBy:EmployeeDetailsListInfo?
    var selectedEmployee:EmployeeDetailsListInfo?
    
    var statusList : [StatusDetailsInfoModel] = []
    var selectedStatusInfo:StatusDetailsInfoModel?
    var callStatusList : [StatusDetailsInfoModel] = []
    var selectedCallStatusInfo:StatusDetailsInfoModel?
    var selectedfollowUpByIndex = -1
    var selectedNxtEmployeeIndex = -1
    var deviceLocationService = DeviceLocationService.Shared
    var coordinates: (lat: Double, lon: Double) = (0, 0)
    lazy var locationtokens = Set<AnyCancellable>()
    lazy var imagePickerVm : ImagePickerManager = ImagePickerManager()
    
    lazy var imageStringArray : [String] = []{
        didSet{
            print(imageStringArray)
        }
    }
    
    lazy var actionList : [FollowUpActionDetailsListInfo] = []
    
    var selectedAction : FollowUpActionDetailsListInfo?
    
    lazy var priorityList : [PriorityListInfo] = []
    var selectedPriority : PriorityListInfo?
    
    lazy var departmentList : [DepartmentDetailsInfoModel] = []
    var selectedDepartment : DepartmentDetailsInfoModel?
    
    var followUpValidationVm:FollowUpValidationViewModel = FollowUpValidationViewModel.init(brockenRules: [])
    var imageDataString1 = ""
    var imageDataString2 = ""
    
    var actionTypeValue:NSNumber=0
    var id_LeadGenerateProduct = ""
    var id_LeadGenerate = ""
    
    
    private lazy var bottomUnderlineView: UIView = {
           let underlineView = UIView()
           underlineView.backgroundColor = AppColor.Shared.purple_200
           underlineView.translatesAutoresizingMaskIntoConstraints = false
           return underlineView
       }()
    
    private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
           return bottomUnderlineView.leftAnchor.constraint(equalTo: followUpSegmentControl.leftAnchor)
       }()
    
    lazy var employeeCancellable = Set<AnyCancellable>()
    lazy var customerCancellable = Set<AnyCancellable>()
    
    fileprivate func segmentBottomViewAdd() {
        setShadowEffect(selectedView: mainStackView , parentView: scrollView)
        
        
        
        self.followUpSegmentControl.backgroundColor = AppColor.Shared.lmTabColor
        
        
        self.followUpSegmentControl.addSubview(bottomUnderlineView)
        NSLayoutConstraint.activate([
            bottomUnderlineView.bottomAnchor.constraint(equalTo: followUpSegmentControl.bottomAnchor),
            bottomUnderlineView.heightAnchor.constraint(equalToConstant: 2),
            leadingDistanceConstraint,
            bottomUnderlineView.widthAnchor.constraint(equalTo: followUpSegmentControl.widthAnchor, multiplier: 1 / CGFloat(followUpSegmentControl.numberOfSegments))
        ])
    }
    
    fileprivate func followUpViewSubViewHideBasedOnActionType(_ actionType:NSNumber){
        
        self.actionTypeValue = actionType
        
        switch  actionType{
        case 1:
            if let positionView = locationView, let uploadView = imageUploadView,let callView = statusDetailsView{
                
                positionView.subviews.map{ $0.isHidden = true }
                positionView.isHidden = true
                
                uploadView.subviews.map{ $0.isHidden = true }
                uploadView.isHidden = true
                
                
                callView.subviews.map{ $0.isHidden = false }
                callView.isHidden = false
                
                
                UIView.animate(withDuration: 0.2, delay: 0) {
                    if let sv = self.followUpSubView{
                        sv.layoutIfNeeded()
                    }
                }
                
            }
        case 2:
            
            if let positionView = locationView, let uploadView = imageUploadView, let callView = statusDetailsView{
                
                callView.subviews.map{ $0.isHidden = true }
                callView.isHidden = true
                
                positionView.subviews.map{ $0.isHidden = false }
                positionView.isHidden = false
                
                uploadView.subviews.map{ $0.isHidden = false }
                uploadView.isHidden = false

                
                UIView.animate(withDuration: 0.2, delay: 0) {
                    if let sv = self.followUpSubView{
                        sv.layoutIfNeeded()
                    }
                }
            
            }
            
            
        default:
            if let positionView = locationView, let uploadView = imageUploadView,let callView = statusDetailsView{
                positionView.subviews.map{ $0.isHidden = true }
                positionView.isHidden = true
                
                uploadView.subviews.map{ $0.isHidden = true }
                uploadView.isHidden = true
                
                callView.subviews.map{ $0.isHidden = true }
                callView.isHidden = true
                UIView.animate(withDuration: 0.2, delay: 0) {
                    if let sv = self.followUpSubView{
                        sv.layoutIfNeeded()
                    }
                }
            }
        }
        
        
       
        
    }
    
    fileprivate func textViewInitialize() {
        self.customerRemarkLabel.setLabelValue(customerRemarkTxt)
        self.employeeRemarkLabel.setLabelValue(employeeRemarkTxt)
        self.customerRemarkTV.setValue(customerRemarkTxt)
        self.employeeRemarkTV.setValue(employeeRemarkTxt)
        customerRemarkTV.setTextColor(UIColor.lightGray)
        employeeRemarkTV.setTextColor(UIColor.lightGray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentBottomViewAdd()
        
        self.followUpVm = FollowUpViewModel(vc: self)
        textViewInitialize()
        keyboardHandler()
        didChangeCustomerMessage()
        didChangeEmployeeMessage()
        
        
       // scrollHeightCalculate()
        // Do any additional setup after loading the view.
        
    }
    
    fileprivate func keyboardHandler() {
        keyboardManager
          
          .sink { completed in
            print(completed)
        } receiveValue: { height in
            print(height)
            
            
            
            self.view.frame.origin.y = height > 0 ? -(height)+60 : 0
            
        }.store(in: &keyboardCancellable)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
        
      
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
       
    }
    
    func resetPageSegmentZero(){
        
        if actionTypeValue == 0{
            self.selectedActionType = FollowUpTypeDetailsListInfo(datas: [:])
            
            self.actionTypeTF.setTextFieldValue("")
        }
        
        customerRemarkTxt = "Customer Remark"
        employeeRemarkTxt = "Employee Remark"
        textViewInitialize()
        self.selectedStatusInfo = StatusDetailsInfoModel(datas: [:])
        
        self.statusTF.setTextFieldValue(self.selectedStatusInfo?.StatusName ?? "")
        self.selectedCallStatusInfo = StatusDetailsInfoModel(datas: [:])
        self.statusDetailsTF.setTextFieldValue(self.selectedCallStatusInfo?.StatusName ?? "")
        initializeInfo()
        self.coordinates = (0, 0)
        self.latitudeTF.text = ""
        self.longitudeTF.text = ""
        imageDataString1 = ""
        imageDataString2 = ""
        self.locationtokens.dispose()
        self.latitudeTF.setTextFieldValue("")
        self.longitudeTF.setTextFieldValue("")
        self.uploadImagViewOne.image = UIImage.init(named: "fd_uploads")
        self.uploadImageViewTwo.image = UIImage.init(named: "fd_uploads")
        self.dateTF.setTextFieldValue( DateTimeModel.shared.stringDateFromDate(Date()))
    }
    
    func didChangeCustomerMessage(){
        
        self.customerRemarkTV.delegate = self
//        textViewPublisher
//            .eraseToAnyPublisher()
//            .sink { text in
//            self.customerRemarkTxt = text
//            print(self.customerRemarkTxt)
//        }.store(in: &customerCancellable)
    }
    
    private func changeSegmentedControlLinePosition(segmentedControl:UISegmentedControl) {
           let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
           let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
           let leadingDistance = segmentWidth * segmentIndex
           UIView.animate(withDuration: 0.3, animations: { [weak self] in
               self?.leadingDistanceConstraint.constant = leadingDistance
               self?.mainStackView.layoutIfNeeded()
           })
       }
    
    
    func didChangeEmployeeMessage(){

        
        self.employeeRemarkTV.delegate = self
//        textViewPublisher.sink { text in
//            self.employeeRemarkTxt = text
//            print(self.employeeRemarkTxt)
//        }.store(in: &employeeCancellable)

    }
    
    //MARK: - VIEW_WILL_APPEAR()
    fileprivate func initializeInfo() {
        followUpSegmentControl.selectedSegmentIndex = 0
        selectedSegmentValue = followUpSegmentControl.selectedSegmentIndex
        followUpViewSubViewHideBasedOnActionType(actionTypeValue)
        
        followUPActionTypeListingMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initializeInfo()
        
        defer{
            self.nextActionDepartmentListingAPICall()
        }
                
        
    }
    
    //MARK: - followUPActionTypeListingMethod()
    func followUPActionTypeListingMethod(){
        self.followUpVm.followUpActionTypeAPICall { responseHandler in
            
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            
            if statusCode == 0{
                
                let list = info.value(forKey: "FollowUpTypeDetailsList") as? [NSDictionary] ?? []
                
                self.actionTypeList = []
                
                self.actionTypeList = list.map{FollowUpTypeDetailsListInfo(datas: $0)}
                
                
                if let actionTypeIndex = self.actionTypeList.firstIndex(where: { $0.ActionMode == self.actionTypeValue }) {
                    self.selectedActionType = self.actionTypeList[actionTypeIndex]
                    //print(self.selectedActionType!)
                    self.actionTypeTF.setTextFieldValue(self.selectedActionType?.ActnTypeName ?? "")
                }
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2) {
                    self.followUP_UserByListingMethod()
                }
                
            }else{
                
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    
                }}

    }
    
    // ED-54
    //MARK: - followUPByAction()
    func followUP_UserByListingMethod(section:String="followup"){
        self.followUpVm.followUp_ByAPICall { responseHandler in
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            
            if statusCode == 0{
                
                let list = info.value(forKey: "EmployeeDetailsList") as? [NSDictionary] ?? []
                
                self.followUpByInfoList = []
                self.followUpByInfoList = list.map{ EmployeeDetailsListInfo(datas: $0) }
                
                    if let followUpByIndex = self.followUpByInfoList.firstIndex(where: {$0.ID_Employee == preference.User_Fk_Employee}){
                        self.selectedfollowUpByIndex = followUpByIndex
                        self.selectedFollowUpBy = self.followUpByInfoList[self.selectedfollowUpByIndex]
                        self.followByTF.setTextFieldValue(self.selectedFollowUpBy?.EmpName ?? "")
                    }
               
                    
                    if let selectedEmployeeIndex = self.followUpByInfoList.firstIndex(where: {$0.ID_Employee == preference.User_Fk_Employee}){
                        self.selectedNxtEmployeeIndex = selectedEmployeeIndex
                        self.selectedEmployee = self.followUpByInfoList[self.selectedNxtEmployeeIndex]
                        self.nxtActionEmployeeTF.setTextFieldValue(self.selectedEmployee?.EmpName ?? "")
                    
                    
                }
               
                 
            }else{
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
        }
    }
    
   
    func followUPByAction(section:String="followup"){
       //print("user select from list")
       
       let popupTableVC = ReusableTableVC(items: self.followUpByInfoList) { (cell:SubtitleTableViewCell, collectData, table) in
           
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
           
           if section == "followup"{
               self.selectedFollowUpBy = collectData
               self.followByTF.setTextFieldValue(self.selectedFollowUpBy?.EmpName ?? "")
               print(self.selectedFollowUpBy?.EmpName ?? "")
           }else{
               self.selectedEmployee = collectData
               self.nxtActionEmployeeTF.setTextFieldValue(self.selectedEmployee?.EmpName ?? "")
               print(self.selectedEmployee?.EmpName ?? "")
           }
           
           
       }
       
        popupTableVC.listingTitleString = section == "followup" ? "FOLLOW UP BY" : "EMPLOYEE"
       popupTableVC.modalTransitionStyle = .coverVertical
       popupTableVC.modalPresentationStyle = .overCurrentContext
       self.present(popupTableVC, animated: true)
       
   }
    
    //FUSAC-613
    //MARK: - followUp_statusGetMethod()
    func followUp_statusGetMethod(){
        self.followUpVm.followUp_StatusAPICall { responseHandler in
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            
            if statusCode == 0{
                
                let list = info.value(forKey: "StatusList") as? [NSDictionary] ?? []
                
                self.statusList = []
                
                self.statusList = list.map{ StatusDetailsInfoModel(datas: $0) }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                    self.populateStatusListingPopUp(list: self.statusList)
                }
                
            }else{
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
        }
    }
    
    
    //FUCSAC-6313
    //MARK: - followUp_callStatusGetMethod()
    func followUp_callStatusGetMethod(){
        self.followUpVm.followUp_CallStatusAPICall { responseHandler in
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            
            if statusCode == 0{
                
                let list = info.value(forKey: "StatusList") as? [NSDictionary] ?? []
                
                self.callStatusList = []
                
                self.callStatusList = list.map{ StatusDetailsInfoModel(datas: $0) }
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                    self.populateStatusListingPopUp(list: self.callStatusList,from: "call")
                }
                
            }else{
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
        }
    }
    
    
    
    
    func hideFollowUpNextActionView(_ segmentSelected:Int){
        
        switch segmentSelected{
        case 1:
            let views = self.followUpView.subviews
            views.map{ $0.isHidden = true }
            self.followUpView.isHidden = true
            
            let nextviews = self.nextActionView.subviews
            nextviews.map{ $0.isHidden = false }
            self.nextActionView.isHidden = false
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .showHideTransitionViews, animations: {
                self.mainStackView.layoutIfNeeded()
            }, completion: nil)
            
        default:
            let views = self.nextActionView.subviews
            views.map{ $0.isHidden = true }
            self.nextActionView.isHidden = true
            
            let followviews = self.followUpView.subviews
            followviews.map{ $0.isHidden = false }
            self.followUpView.isHidden = false
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .showHideTransitionViews, animations: {
                self.mainStackView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    
    private func setShadowEffect(selectedView:UIView,parentView:UIView,size:CGSize=CGSize(width: 0, height: 0)){
        selectedView.layer.masksToBounds = false
        selectedView.layer.shadowRadius = 2
        selectedView.layer.shadowOpacity = 0.6
        selectedView.layer.shadowColor = AppColor.Shared.greydark.cgColor
        selectedView.layer.shadowOffset = size
        selectedView.setCornerRadius(size: 5)
        
        UIView.animate(withDuration: 0.2) {
           parentView.layoutIfNeeded()
        }
    }
    
    // NAAL-1112
    //NEXT ACTION BUTTON ACTION
    fileprivate func nextActionListingMethode() {
        followUpVm.nextActionActionListingAPICall { responseHandler in
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            
            if statusCode == 0{
                let list = info.value(forKey: "FollowUpActionDetailsList") as? [NSDictionary] ?? []
                
                self.actionList = []
                
                self.actionList = list.map{ FollowUpActionDetailsListInfo(datas: $0) }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                    self.followUPActionListPopUPPageCall(list: self.actionList)
                }
                
            }else{
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
        }
    }
    
    // NAPL-1411
    //MARK: - ========= prioriyAPICall() =============
    func nextActionPriorityListingAPICall(){
        self.followUpVm.nextActionPriorityListingAPICall { responseHandler in
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            if statusCode == 0{
                let list = info.value(forKey: "PriorityList") as? [NSDictionary] ?? []
                self.priorityList = []
                self.priorityList = list.map{ PriorityListInfo(datas: $0) }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.priorityListPopUPPageCall(list: self.priorityList)
                }
            }else{
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
        }
        
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
         
            self.selectedPriority = item
            self.nxtActionPriorityTF.setTextFieldValue(self.selectedPriority?.PriorityName ?? "")
            print(item.PriorityName)
        }
        
        popUpVC.listingTitleString = "PRIORITY"
        
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.present(popUpVC, animated: false)
        
        
    }
    
    // NADL-141412
    //MARK: - ========= nextActionDepartmentListingAPICall() =============
    func nextActionDepartmentListingAPICall(){
        self.followUpVm.nextActionDepartmentListingAPICall { responseHandler in
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            if statusCode == 0{
                let list = info.value(forKey: "DepartmentDetailsList") as? [NSDictionary] ?? []
                self.departmentList = []
                self.departmentList = list.map{ DepartmentDetailsInfoModel(datas: $0) }
                
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    let departmentID =  fk_department
                    if let departmentIndex = self.departmentList.firstIndex(where:{ "\($0.ID_Department)" == departmentID}){
                        self.selectedDepartment = self.departmentList[departmentIndex]
                        self.nextActionDepartmentTF.setTextFieldValue(self.selectedDepartment?.DeptName ?? "")
                    }
                    
                }
            }else{
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
        }
    }
    
    
    func departmentListPopUPPageCall(list:[DepartmentDetailsInfoModel]){
        
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.DeptName
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
         
            self.selectedDepartment = item
            self.nextActionDepartmentTF.setTextFieldValue(self.selectedDepartment?.DeptName ?? "")
            print(item.DeptName)
        }
        
        popUpVC.listingTitleString = "DEPARTMENT"
        
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.present(popUpVC, animated: false)
        
        
    }
    
    @IBAction func nextActionButtonAction(_ sender: UIButton) {
        nextActionListingMethode()
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
            
            self.selectedAction = item
            self.nxtActionTF.setTextFieldValue(self.selectedAction?.NxtActnName ?? "")
            
            print(item)
        }
        
        popUpVC.listingTitleString = "ACTION"
        
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.present(popUpVC, animated: false)
        
        
    }
    
    @IBAction func nextActionTypeButtonAction(_ sender: Any) {
        
        self.populateActionTypeListingPopUp(section: "NextAction")
    }
    
    @IBAction func nextActionPriorityButtonAction(_ sender: UIButton) {
        self.nextActionPriorityListingAPICall()
    }
    
    @IBAction func nextActionDepartmentButtonAction(_ sender: UIButton) {
        
        self.departmentListPopUPPageCall(list: self.departmentList)
        
        
    }
    
    @IBAction func nextActionEmployeeButtonAction(_ sender: UIButton) {
        
        self.followUPByAction(section: "nextaction")
        
    }
    //FOLLOW UP BUTTON ACTION
    @IBAction func backButtonAction(_ sender: UIButton) {
        actionTypeValue = 0
        selectedfollowUpByIndex = -1
        self.actionTypeTF.setTextFieldValue("")
        self.selectedActionType = FollowUpTypeDetailsListInfo.init(datas: [:])
        self.selectedFollowUpBy = EmployeeDetailsListInfo(datas: [:])
        resetPageSegmentZero()
        self.selectedNxtEmployeeIndex = -1
        self.resetPageSegmentOne()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectedSegmentAction(_ sender: UISegmentedControl) {
        selectedSegmentValue = sender.selectedSegmentIndex
        
    }
    
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
     
        selectedSegmentValue == 0 ? resetPageSegmentZero() : resetPageSegmentOne()
    }
    
    
    func resetPageSegmentOne(){
        
        self.selectedAction = FollowUpActionDetailsListInfo(datas: [:])
        self.nxtActionTF.setTextFieldValue("")
        self.selectedNextActionType = FollowUpTypeDetailsListInfo(datas: [:])
        self.nxtActionTypeTF.setTextFieldValue("")
        self.nxtActionFollowUpDateTF.setTextFieldValue("")
        self.selectedPriority = PriorityListInfo(datas: [:])
        self.nxtActionPriorityTF.setTextFieldValue("")
        self.selectedDepartment = DepartmentDetailsInfoModel(datas: [:])
        self.nextActionDepartmentTF.setTextFieldValue(self.selectedDepartment?.DeptName ?? "")
        self.nxtActionFollowUpDateTF.datePickerView.date = Date()
        
        
    }
    
    func saveFollowUpDetails(_ actionType:String,_ info: FollowUpParamValidation){
        self.followUpVm.saveFollowUpDetailsAPICall(actionType: actionType,info: info) { responseHandler in
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            if statusCode == 0{
                self.actionTypeValue  = 0
                let LeadNo = info.value(forKey: "LeadNo") as? String ?? ""
                let leadNoGenerateMessage = "Lead No : \(LeadNo)"
                self.resetPageSegmentZero()
                self.resetPageSegmentOne()
                let successMessage = "\(message)\n\(leadNoGenerateMessage)"
                self.popupAlert(title: "", message: successMessage, actionTitles: [okTitle], actions: [{action1 in
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2) {
                        self.popToViewController(ofClass: LManagementCategoryListVC.self, controllers: self.allControllers)
                    }
                    
                    
                    
                    
                },nil])
            }else{
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
        }
    }
    
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        
        
        let nextFollowUpDateString = self.self.nxtActionFollowUpDateTF.text ?? ""
        let convertDateString = DateTimeModel.shared.formattedDateFromString(dateString: self.dateTF.text ?? "", withFormat: "yyyy-MM-dd")!
        self.followUpValidationVm.actionTypeValue = actionTypeValue
        self.followUpValidationVm.selectedSegment = selectedSegmentValue
        self.followUpValidationVm.followUpParamValidation = FollowUpParamValidation(siteActionType: "\(actionTypeValue)",
            followUPby: "\(self.selectedFollowUpBy?.ID_Employee ?? 0)",
            statusId: "\(self.selectedStatusInfo?.ID_Status ?? 0)",
            date: convertDateString,
            customerRemark: customerRemarkTxt,
            employeeRemark: employeeRemarkTxt,
            coordinates: coordinates,
            uploadImageOne: imageDataString1,
            uploadImageTwo: imageDataString2,
            callStatusId:"\(self.selectedCallStatusInfo?.ID_Status ?? 0)",
            nextActionID: "\(self.selectedAction?.ID_NextAction ?? 0)",
            nextActionTypeID: "\(selectedNextActionType?.ID_ActionType ?? 0)",
            nextActionFollowUpdate: nextFollowUpDateString,
            nextActionPriorityID: "\(selectedPriority?.ID_Priority ?? 0)",
            departMentID:"\(selectedDepartment?.ID_Department ?? 0)",
            employee_ID: "\(self.selectedEmployee?.ID_Employee ?? 0)",
            id_LeadGenerateProduct:id_LeadGenerateProduct,
            id_LeadGenerate:id_LeadGenerate
                                                                                
        )
        
        if let params = followUpValidationVm.followUpParamValidation{
        let followUpInfo = FollowUpParamValidation(siteActionType: "\(followUpValidationVm.actionTypeValue)",
           followUPby: params.followUPby ,
           statusId: params.statusId ,
           date: params.date ,
           
           customerRemark: params.customerRemark ,
           employeeRemark: params.employeeRemark ,
           coordinates: params.coordinates,
           
           uploadImageOne: params.uploadImageOne ,
           uploadImageTwo: params.uploadImageTwo ,
           
           callStatusId: params.callStatusId ,
           nextActionID: params.nextActionID ,
           
                                                   
           nextActionTypeID: params.nextActionTypeID ,
           nextActionFollowUpdate: params.nextActionFollowUpdate ,
           nextActionPriorityID: params.nextActionPriorityID ,
           departMentID: params.departMentID ,
           employee_ID: params.employee_ID ,
           id_LeadGenerateProduct: params.id_LeadGenerateProduct ,
           id_LeadGenerate: params.id_LeadGenerate )
        
        if !followUpValidationVm.isValid{
            
            
            
            
            self.saveFollowUpDetails("\(self.followUpValidationVm.actionTypeValue)",followUpInfo)
            
        }else{
            self.popupAlert(title: "", message: followUpValidationVm.brockenRules.first?.message, actionTitles: [okTitle], actions: [{action1 in
                
            },nil])
        }
      }
    }
    
    
    func populateActionTypeListingPopUp(section:String="followup"){
        let popUpVC = ReusableTableVC(items: self.actionTypeList) { (cell:SubtitleTableViewCell, item, table )in
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
        } selectHandler: { actionType in
            if section == "followup"{
            self.selectedActionType = actionType
            self.actionTypeTF.setTextFieldValue(self.selectedActionType!.ActnTypeName)
            self.followUpViewSubViewHideBasedOnActionType(self.selectedActionType!.ActionMode)
            }else{
                self.selectedNextActionType = actionType
                self.nxtActionTypeTF.setTextFieldValue(self.selectedNextActionType?.ActnTypeName ?? "")
            }
        }
        
        popUpVC.listingTitleString = "ACTION TYPE"
        
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.present(popUpVC, animated: false)
    }
    
    func populateStatusListingPopUp(list:[StatusDetailsInfoModel],from:String="status"){
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.StatusName
        
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { status in
            
            switch from{
            case "status":
                self.selectedStatusInfo = status
                self.statusTF.text = self.selectedStatusInfo?.StatusName
            default:
                self.selectedCallStatusInfo = status
                self.statusDetailsTF.text = self.selectedCallStatusInfo?.StatusName
            }
            
        }
        
        popUpVC.listingTitleString = from == "status" ? "STATUS" : "CALL STATUS"
        
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.present(popUpVC, animated: false)
    }
    
    
    
    @IBAction func actionTypeButtonAction(_ sender: UIButton) {
        
        if actionTypeValue == 0 {
           
            populateActionTypeListingPopUp()
            
            
        }
    }
    
    
    @IBAction func followByButtonAction(_ sender: UIButton) {
        
        followUPByAction()
        
    }
    
    
    @IBAction func statusButtonAction(_ sender: UIButton) {
        followUp_statusGetMethod()
    }
    
    @IBAction func dateButtonAction(_ sender: UIButton) {
    }
    
    
    @IBAction func statusDetailsButtonAction(_ sender: UIButton) {
        followUp_callStatusGetMethod()
    }
    
    @IBAction func locationFetchButtonAction(_ sender: UIButton) {
        locationCoordinateUpdates()
        deniedLocationAccess()
        deviceLocationService.requestLocationUpdates()
    }
    
    func locationCoordinateUpdates() {
        deviceLocationService.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Handle \(completion) for error and finished subscription.")
            } receiveValue: { coordinates in
               // print("location coordinates:\(coordinates.latitude)= \(coordinates.longitude)")
                self.coordinates = (coordinates.latitude, coordinates.longitude)
                //print(self.allControllers)
                self.latitudeTF.text = "\(self.coordinates.lat.rounded(toPlaces: 5))"
                self.longitudeTF.text = "\(self.coordinates.lon.rounded(toPlaces: 5))"
                
            }.store(in: &locationtokens)

    }
    
    func deniedLocationAccess(){
        deviceLocationService.deniedLocationAccessPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                print("Handle access denied event, possibly with an alert.")
                self.popupAlert(title: "Location Service", message: locationLoginMessage, actionTitles: [closeTitle], actions: [{action1 in
                    print("login location pop up closed")
                },nil])
            }
            .store(in: &locationtokens)
    }
    
    @IBAction func imageUploadButtonActionOne(_ sender: UIButton) {
        imagePickerVm.pickImage(self) { selectedImage,filename in
            if let imageData = selectedImage.jpeg(.low) {
                let base64String = imageData.base64EncodedString()
                self.uploadImagViewOne.image = selectedImage
                
                self.imageDataString1 = base64String
            }
        }
    }
    
    @IBAction func imageUploadButtonActionTwo(_ sender: UIButton) {
        imagePickerVm.pickImage(self) { selectedImage,filename in
            if let imageData = selectedImage.jpeg(.low) {
                print(selectedImage.getFileSizeInfo())
                let base64String = imageData.base64EncodedString()
                self.uploadImageViewTwo.image = selectedImage
                self.imageDataString2 = base64String

                
            }
        }
    }
    
    
//    func scrollHeightCalculate(){
//        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
//            rect = rect.union(view.frame)
//        }
//        scrollView.contentSize = contentRect.size
//    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //scrollHeightCalculate()
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


extension LMCDFollowUpDetailsVC : UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView == customerRemarkTV{
            
            
            let currentString : NSString = customerRemarkTxt  as NSString
            let newString  : NSString = currentString.replacingCharacters(in: range, with: text) as NSString
            if newString.length == messageMaxLength{
                self.view.endEditing(true)
            }
            return newString.length <= messageMaxLength
        }
        
        if textView == employeeRemarkTV{
            
          
            let currentString : NSString = employeeRemarkTxt as NSString
            let newString  : NSString = currentString.replacingCharacters(in: range, with: text) as NSString
            if newString.length == messageMaxLength{
                self.view.endEditing(true)
            }
            return newString.length <= messageMaxLength
        }
        
     
            return false
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = AppColor.Shared.greydark
            
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == customerRemarkTV{
            if textView.text.isEmpty {
                customerRemarkTxt = "Customer Remark"
                
                textView.text = customerRemarkTxt
                textView.textColor = UIColor.lightGray
            }else{
                customerRemarkTxt = textView.text ?? ""
            }
        }else{
            if textView.text.isEmpty {
                employeeRemarkTxt = "Employee Remark"
                
                textView.text = employeeRemarkTxt
                textView.textColor = UIColor.lightGray
            }else{
                employeeRemarkTxt = textView.text ?? ""
            }
        }
        
            

    }
}

//
//  EmiCollectionDetailsVC.swift
//  ProdSuit
//
//  Created by MacBook on 08/06/23.
//

import UIKit
import Combine


let currentDateString = DateTimeModel.shared.stringDateFromDate(Date())
class EmiCollectionDetailsVC: UIViewController {
    
    
    @IBOutlet weak var collectionSegmentControl: UISegmentedControl!{
        didSet{
            let background = UIColor.clear
            let selectedColor = AppColor.Shared.collectionSelectedSegment

            if #available(iOS 13.0, *)
            {
                collectionSegmentControl.tintColor = background
                collectionSegmentControl.backgroundColor = background
                collectionSegmentControl.selectedSegmentTintColor = selectedColor
                collectionSegmentControl.setTitleTextAttributes([.foregroundColor: AppColor.Shared.coloBlack as Any], for: .normal)
                collectionSegmentControl.setTitleTextAttributes([.foregroundColor: AppColor.Shared.colorWhite as Any], for: .selected)
            }
            else
            {
                collectionSegmentControl.tintColor = background
                collectionSegmentControl.backgroundColor = selectedColor
                collectionSegmentControl.layer.cornerRadius = 4
            }
        }
    }
    
    
    
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var emiSegmentHandleStackView: UIStackView!
    
    
    
    @IBOutlet weak var transDateView: TransDateView!{
        didSet{
            
           
            transDateView.HeaderNameLabel.setLabelValue(" Trans Date *")
            transDateView.datePickerView.tintColor = AppColor.Shared.coloBlack
            transDateView.leftSideImageView.image = UIImage.init(named: "icon_emi_duedays")
        
            
            
        }
    }
    
    @IBOutlet weak var collectionDateView: TransDateView!{
        didSet{
            
           
            collectionDateView.HeaderNameLabel.setLabelValue(" Collection Date *")
            collectionDateView.datePickerView.tintColor = AppColor.Shared.coloBlack
            collectionDateView.leftSideImageView.image = UIImage.init(named: "ic_emi_todate")
            
        }
    }
    
    @IBOutlet weak var collectedByView: TextFieldWithNameView!{
        didSet{
            
            collectedByView.HeaderNameLabel.setLabelValue(" Collected By *")
            collectedByView.HeaderDetailTF.tintColor = UIColor.clear
            collectedByView.HeaderDetailTF.inputView = UIView()
            collectedByView.leftSideImageView.image = UIImage.init(named: "ic_emi_customer")
            collectedByView.leftSideImageView.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
        }}
    
    @IBOutlet weak var installMentView: TextFieldWithNameView!{
        didSet{
            
            
            installMentView.HeaderNameLabel.setLabelValue(" Installment Amount")
            installMentView.HeaderDetailTF.keyboardType = .decimalPad
            
            installMentView.HeaderDetailTF.tintColor = AppColor.Shared.coloBlack
            installMentView.HeaderDetailTF.delegate = self
            installMentView.leftSideImageView.image = UIImage.init(named: "ic_emi_amount")
          
            installMentView.leftSideImageView.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
            installMentView.HeaderDetailTF.addDonButton()
        }
    }
    
    @IBOutlet weak var fineView: TextFieldWithNameView!{
        didSet{
            
           
            fineView.HeaderNameLabel.setLabelValue(" Fine")
            fineView.HeaderDetailTF.keyboardType = .decimalPad
            fineView.HeaderDetailTF.tintColor = AppColor.Shared.coloBlack
            fineView.HeaderDetailTF.delegate = self
            fineView.leftSideImageView.image = UIImage.init(named: "ic_emi_expense")
            fineView.leftSideImageView.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
            fineView.HeaderDetailTF.addDonButton()
        }
    }
    
    
    var selectedSegment : Int = 0 {
        didSet{
            
            switch selectedSegment{
            case 1:
                self.emiAccountCustomerDetailsAPICall()
                infoAndCollectionView(informationView, collectionView, true)
            default:
                
                infoAndCollectionView(collectionView, informationView, true)
            }
            
        }
    }
    @IBOutlet weak var emiCollectionScrollView: UIScrollView!
    
    
    @IBOutlet weak var customerImageView: UIImageView!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var balanceView: BalanceView!{
        didSet{
            balanceView.closeBalanceDelegate = self
        }
    }
    @IBOutlet weak var netAmountView: NetAmountView!{
        didSet{
            netAmountView.superview?.setNeedsLayout()
            netAmountView.superview?.layoutIfNeeded()
            netAmountView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        }
    }
    
    @IBOutlet weak var paymentView: UIView!
    
    @IBOutlet weak var paymentMethodView: TextFieldWithNameView!{
        didSet{
            paymentMethodView.HeaderNameLabel.setLabelValue(" Method *")
            paymentMethodView.HeaderDetailTF.tintColor = AppColor.Shared.coloBlack
            paymentMethodView.HeaderDetailTF.isUserInteractionEnabled = false
            paymentMethodView.HeaderDetailTF.setBorder(width: 1, borderColor: AppColor.Shared.D6D6D6)
            paymentMethodView.leftSideImageView.image = UIImage.init(named: "ic_emi_expense")
            paymentMethodView.leftSideImageView.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
        }
    }
    
    @IBOutlet weak var referenceNoView: TextFieldWithNameView!{
        didSet{
            referenceNoView.HeaderNameLabel.setLabelValue(" Ref No.")
            referenceNoView.HeaderDetailTF.keyboardType = .default
            
            referenceNoView.HeaderDetailTF.tintColor = AppColor.Shared.coloBlack
            
            referenceNoView.leftSideImageView.image = UIImage.init(named: "ic_emi_amount")
            referenceNoView.leftSideImageView.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
            referenceNoView.HeaderDetailTF.addDonButton()
        }
    }
    
    @IBOutlet weak var paymentAmountView: TextFieldWithNameView!{
        didSet{
            paymentAmountView.HeaderNameLabel.setLabelValue(" Amount *")
            paymentAmountView.HeaderDetailTF.keyboardType = .decimalPad
            paymentAmountView.HeaderDetailTF.delegate = self
            paymentAmountView.HeaderDetailTF.tintColor = AppColor.Shared.coloBlack
            
            paymentAmountView.leftSideImageView.image = UIImage.init(named: "ic_emi_amount")
            paymentAmountView.leftSideImageView.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
            paymentAmountView.HeaderDetailTF.addDonButton()
        }
    }
    
    @IBOutlet weak var paymentBalanceView: TextFieldWithNameView!{
        didSet{
            paymentBalanceView.HeaderNameLabel.setLabelValue(" Balance")
            paymentBalanceView.HeaderDetailTF.tintColor = AppColor.Shared.coloBlack
            paymentBalanceView.HeaderDetailTF.isUserInteractionEnabled = false
            paymentBalanceView.HeaderDetailTF.setBorder(width: 1, borderColor: AppColor.Shared.colorWhite)
            paymentBalanceView.HeaderNameLabel.setTextColor(AppColor.Shared.red)
            paymentBalanceView.HeaderNameLabel.setFontSize(15, font: .medium)
            paymentBalanceView.leftSideView.frame = CGRect.init(x: 0, y: 0, width: 26, height: 40)
            paymentBalanceView.leftSideImageView.image = UIImage.init(named: "ic_emi_expense")
            
            paymentBalanceView.leftSideImageView.transform = CGAffineTransform.init(scaleX: 0.65, y: 0.65)
        }
    }
    
    var paymentAmountBalance:String = "0.00"{
        didSet{
            paymentBalanceView.HeaderDetailTF.setTextFieldValue(paymentAmountBalance)
        }
    }
    
    @IBOutlet weak var paymentTableView: UITableView!
    
    
    
    
    
    
    fileprivate func paymentPopupShowHide() {
        self.paymentView.subviews.map{ $0.isHidden = paymentViewVisible }
        self.paymentView.isHidden = paymentViewVisible
        UIView.animate(withDuration: 0.5, delay: 0, options:  UIView.AnimationOptions.transitionCurlDown) {
            self.view.layoutIfNeeded()
        }

    }
    
    var paymentViewVisible:Bool = true{
        didSet{
            paymentPopupShowHide()
        }
    }
    
    let commonNetworkVM = SharedNetworkCall.Shared
    
    var infoViewList : [(title:String,value:String)] = []{
        didSet{
            self.infoTableView.reloadData()
        }
    }
    
    var collectionCalculatorVm : CollectionCalculator?
    var paymentCalculateVm : PaymentCalculateViewmodel?
    lazy var employeeList : [EmployeeDetailsListInfo] = []
    var selectedEmployee:EmployeeDetailsListInfo?
    var coordinates: (lat: Double, lon: Double) = (0, 0)
    
    
    
    
    
    fileprivate func collectionDetailsListing(model:EMICollectionReportModel) {
        self.infoViewList = []
        if model.eMINo != ""{
            self.infoViewList.append((title: "EMI No.", value: model.eMINo))
        }
        if model.product != ""{
            self.infoViewList.append((title: "Product", value: model.product))
        }
        
        if model.financePlan != ""{
            self.infoViewList.append((title: "Finance Plan", value: model.financePlan))
        }
        
        if model.dueAmount != ""{
            self.infoViewList.append((title: "Due Amount", value: model.dueAmount))
        }
        
        if model.fineAmount != ""{
            self.infoViewList.append((title: "Fine Amount", value: model.fineAmount))
        }
        
        if model.balance != ""{
            self.infoViewList.append((title: "Balance", value: model.balance))
        }
        
        if model.dueDate != ""{
            
            let duedatestring = model.dueDate.prefix(10)
            self.infoViewList.append((title: "Due Date", value: String.init(duedatestring)))
        }
        
        if model.nextEMIDate != ""{
            let nextEMIstring = model.nextEMIDate.prefix(10)
            self.infoViewList.append((title: "Next EMI Date", value: String.init(nextEMIstring)))
        }
        
        if model.instNo != ""{
            self.infoViewList.append((title: "Inst No", value: model.instNo))
        }
        
//        collectionCalculatorVm = CollectionCalculator.init(openigBalance: model.balance, installment_amount: model.dueAmount, fine_amount: model.fineAmount, closing: false)
//
//        if let balanceString = collectionCalculatorVm?.calculateBalance() as? String,let netamountString = collectionCalculatorVm?.calculateNetAmount() as? String{
//            self.balanceView.balanceAmountLbl.setLabelValue(balanceString)
//            self.netAmountView.NetAmountLabel.setLabelValue(netamountString)
//            if let wordAmountString = collectionCalculatorVm?.toWords(number: netamountString){
//                self.netAmountView.NetAmountWordLabel.setLabelValue("(\(wordAmountString))")
//            }
//
//        }
    }
    
    
    
    
    var infoModel:EMICollectionReportModel?{
        didSet{
            if let model = infoModel{
                commonNetworkVM.parserVm.mainThreadCall {
                    
                    self.collectionDetailsListing(model: model)
                    
                }
            }
        }
    }
    
  
    
    var closing:Bool = false{
       didSet{
           
           
           print("===== Balance : \(collectionCalculatorVm?.calculateBalance() ?? "0") - Net Amount : \(collectionCalculatorVm?.calculateNetAmount() ?? "0") =====")
           
       }
   }
    
    var emiAccountDetailsModel : EMIAccountDetailsModel = EMIAccountDetailsModel(datas: [:]){
        didSet{
            let model = emiAccountDetailsModel.EMIAccountDetailsList.first!
            let customerInfo = emiAccountDetailsModel.CustomerInformationList.first!
            
            self.nameLbl.setLabelValue(customerInfo.cusName)
            self.mobileLbl.setLabelValue(customerInfo.mobile)
            self.areaLbl.setLabelValue(customerInfo.address)
            let fineString = Double(model.fine)!.format(f: ".2")
            self.fineView.HeaderDetailTF.setTextFieldValue(fineString)
            collectionCalculatorVm = CollectionCalculator.init(openigBalance: model.balance, installment_amount: model.amount, fine_amount: model.fine, closing: closing)
            
            let amountString = Double(closing == true ? collectionCalculatorVm!.openigBalance : model.amount)!.format(f: ".2")
            
            
            self.installMentView.HeaderDetailTF.setTextFieldValue(amountString)
            
            
            if let balanceString = collectionCalculatorVm?.calculateBalance() as? String,let netamountString = collectionCalculatorVm?.calculateNetAmount() as? String{
                self.balanceView.balanceAmountLbl.setLabelValue(balanceString)
                self.netAmountView.NetAmountLabel.setLabelValue(netamountString)
                if let wordAmountString = collectionCalculatorVm?.toWords(number: netamountString){
                    self.netAmountView.NetAmountWordLabel.setLabelValue("(\(wordAmountString))")
                }}
        }
    }
    
    lazy var paymentMethodList : [FollowUpPaymentMethodModel] = []
   
    
    var selectedPaymentMethod : FollowUpPaymentMethodModel?
    var firstInitialise : Bool = true
    
    lazy var payment_added_list : [(method:FollowUpPaymentMethodModel,amount:String,reference_no:String)]=[]
    
    lazy var keyboardManager = KeyboardHeightPublisher
    lazy var keyboardCancellable = Set<AnyCancellable>()
    
    var selectedEditingIndex = -1
    var selectedRemoveIndex = -1
    
    lazy var paymentMethodVM:PaymentMethodValidationModel = PaymentMethodValidationModel(brockenRules: [])
    
    lazy var paymentApplyValidationVM:PaymentApplyValidationModel = PaymentApplyValidationModel(brockenRules: [])
    
    lazy var paymentSubmitValidationVM:PaymentSubmitAPIDetailsVM = PaymentSubmitAPIDetailsVM(brockenRules: [])
     
    lazy var locationServiceVm : LocationFetchViewModel = LocationFetchViewModel(service: DeviceLocationService.Shared)
    
    var location_address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        infoTableView.dataSource = self
        infoTableView.delegate = self
        paymentTableView.delegate = self
        paymentTableView.dataSource = self
        let tableHeaderView = TableHeaderView(frame: CGRect.init(x: 0, y: 0, width: paymentTableView.bounds.width, height: 30))
        
        
        paymentTableView.tableHeaderView = tableHeaderView
        
        locationFetch()
        locationDenialService()
        
        
        
        
        defaultValues()
        keyboardHandler()
        
        
        
        
        
//        let paymentViewTap = UITapGestureRecognizer.init(target: self, action: #selector(paymentMethodListingAction(_:)))
//        paymentViewTap.numberOfTapsRequired = 1
//
//        self.paymentView.isUserInteractionEnabled = true
//        self.paymentView.addGestureRecognizer(paymentViewTap)

        // Do any additional setup after loading the view.
    }
    
//    @objc func paymentMethodListingAction(_ gesture:UITapGestureRecognizer){
//        self.paymentMethodAPICall()
//    }
    
    
    
    
    func locationFetch(){
        locationServiceVm.locationCoordinateUpdates(vc: self) { coordinates in
            print(coordinates)
            self.coordinates = (coordinates.latitude,coordinates.longitude)
            self.locationAddressFetch()
        }
    }
    
    func locationDenialService(){
        locationServiceVm.deniedLocationAccess { locationErrorString in
            self.popupAlert(title: "", message: locationErrorString, actionTitles: [okTitle], actions: [{action1 in },nil])
        }
    }
    
    
    func locationAddressFetch(){
        locationServiceVm.getAddress(location: self.coordinates) { locationAddress in
            
            self.location_address = locationAddress
            self.locationServiceVm.locationServiceToken.dispose()
        }
    }
    
    
    
    fileprivate func keyboardHandler() {
        keyboardManager
          
          .sink { completed in
            print(completed)
        } receiveValue: { height in
            print(height)
            
            self.emiCollectionScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            
            
        }.store(in: &keyboardCancellable)
    }
    
    fileprivate func paymentTableShowHideView() {
        self.commonNetworkVM.parserVm.mainThreadCall {
            self.paymentTableView.isHidden =  self.payment_added_list.count > 0 ? false : true
            self.paymentTableView.setBorder(width: 1, borderColor: AppColor.Shared.colorPrimary)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        paymentTableShowHideView()
       
        
        
        if firstInitialise == true{
            self.employeeAPICall()
        }
          self.selectedSegment = self.collectionSegmentControl.selectedSegmentIndex
          
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationServiceVm.deviceLoctionService.requestLocationUpdates()
    }
    
    func defaultValues(){
        
        self.transDateView.datePickerView.date = Date()
        self.collectionDateView.datePickerView.date = Date()
        self.transDateView.HeaderDetailTF.setTextFieldValue(currentDateString)
        self.collectionDateView.HeaderDetailTF.setTextFieldValue(currentDateString)
        
        if let selectedEmployeeIndex = self.employeeList.firstIndex(where: {$0.ID_Employee == preference.User_Fk_Employee}){
            
            self.selectedEmployee = self.employeeList[selectedEmployeeIndex]
            self.collectedByView.HeaderDetailTF.setTextFieldValue(self.selectedEmployee?.EmpName ?? "")
        
        }
        
        
        self.collectedByView.HeaderDetailTF.setTextFieldValue(self.selectedEmployee?.EmpName ?? "")
        self.paymentViewVisible = true
        
        
    }
    
    func infoAndCollectionView(_ hideView:UIView,_ showView:UIView,_ wantHide:Bool){
        
        hideView.subviews.map{ $0.isHidden = wantHide }
        
        hideView.isHidden = wantHide
        
        showView.subviews.map{ $0.isHidden = !wantHide }
        
        showView.isHidden = !wantHide
        
        UIView.animate(withDuration: 0.2) {
            self.emiSegmentHandleStackView.layoutIfNeeded()
        }
        
        
        
    }
    
    //MARK: - employeeAPICall()
    func employeeAPICall(){
        
        self.commonNetworkVM.collectionAPIManager?.employeeListDetailsAPICall(RequestMode.shared.emiET, {  responseHandler in
            
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            
            
            if statusCode == 0{
                
                let list = info.value(forKey: "EmployeeDetailsList") as? [NSDictionary] ?? []
                
                self.employeeList = []
                self.employeeList = list.map{ EmployeeDetailsListInfo(datas: $0) }
                
                print(self.employeeList)
                
                if let selectedEmployeeIndex = self.employeeList.firstIndex(where: {$0.ID_Employee == preference.User_Fk_Employee}){
                    
                    self.selectedEmployee = self.employeeList[selectedEmployeeIndex]
                    self.collectedByView.HeaderDetailTF.setTextFieldValue(self.selectedEmployee?.EmpName ?? "")
                
                }
                
                
        
            }else{
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
            
        })
        
    }
    
    //MARK: - emiAccountCustomerDetailsAPICall()
    func emiAccountCustomerDetailsAPICall(){
        let transDate = self.transDateView.HeaderDetailTF.text ?? currentDateString
        if let model = self.infoModel{
        commonNetworkVM.collectionAPIManager?.emiAccountCustomerDetailsAPICall(transDate: transDate, model: model, { responseHandler in
            
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
                
            if statusCode == 0{
                self.emiAccountDetailsModel = EMIAccountDetailsModel(datas: info)
            }else{
                
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                
            }
            
           })
        }
    }
    
    func employeeButtonAction(){
       //print("user select from list")
       
       let popupTableVC = ReusableTableVC(items: self.employeeList) { (cell:SubtitleTableViewCell, details, table) in
           
           cell.addcontentView(cell: cell)
           
           //let indexLevel = table.indexPath(for: cell)
           if let index = cell.tag as? Int{
               cell.indexLabel.text = "\(index + 1)"
               
           }
           cell.titleLabel.text = details.EmpName
           cell.detailsLabel.text = details.DesignationName
           cell.accessoryType = .disclosureIndicator
           UIView.animate(withDuration: 0.1) {
               cell.layoutIfNeeded()
           }
           
       } selectHandler: { details in
           
       
           self.selectedEmployee = details
           self.collectedByView.HeaderDetailTF.setTextFieldValue(self.selectedEmployee?.EmpName ?? "")
          
           
           
           
       }
       
        popupTableVC.listingTitleString = "Employee"
       popupTableVC.modalTransitionStyle = .coverVertical
       popupTableVC.modalPresentationStyle = .overCurrentContext
       self.present(popupTableVC, animated: true)
       
   }
    
    
    func paymentMethodPopUpAction(){
       //print("user select from list")
       
       let popupTableVC = ReusableTableVC(items: self.paymentMethodList) { (cell:SubtitleTableViewCell, details, table) in
           
           cell.addcontentView(cell: cell)
           
           //let indexLevel = table.indexPath(for: cell)
           if let index = cell.tag as? Int{
               cell.indexLabel.text = "\(index + 1)"
               
           }
           cell.titleLabel.text = details.paymentName
           
           cell.accessoryType = .disclosureIndicator
           UIView.animate(withDuration: 0.1) {
               cell.layoutIfNeeded()
           }
           
       } selectHandler: { details in
           
       
           self.selectedPaymentMethod = details
           self.paymentMethodView.HeaderDetailTF.setTextFieldValue(self.selectedPaymentMethod?.paymentName ?? "")
           
           
           
           
       }
       
       popupTableVC.listingTitleString = "Payment Method"
       popupTableVC.modalTransitionStyle = .coverVertical
       popupTableVC.modalPresentationStyle = .overCurrentContext
       self.present(popupTableVC, animated: true)
       
   }
    
    
    @IBAction func collectionSegementControlAction(_ sender: UISegmentedControl) {
        
        self.selectedSegment = sender.selectedSegmentIndex
        
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        
        self.selectedSegment = 0
        self.collectionSegmentControl.selectedSegmentIndex = self.selectedSegment
        self.defaultValues()
        let emiCollectionInfoPage = AppVC.Shared.emiCollectionDetails
        
        if allControllers.contains(emiCollectionInfoPage){
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func getPaymentSubmitInfo() -> PaymentParmaInfoModel{
        let transDate = self.transDateView.HeaderDetailTF.text ?? currentDateString
        
        let collectDate = self.collectionDateView.HeaderDetailTF.text ?? currentDateString
        
        let emiInfo = emiAccountDetailsModel.EMIAccountDetailsList.first!
        let customerInfo = emiAccountDetailsModel.CustomerInformationList.first!
        let net_amount = self.netAmountView.NetAmountLabel.text ?? "0.00"
        let fine_amount = self.fineView.HeaderDetailTF.text ?? "0.00"
        
        let emiDetails = PaymentParamEmiDetailsModel(fk_CustomerWiseEMI: emiInfo.fk_customerWiseEMI, cusTrDetPayAmount: net_amount, cusTrDetFineAmount: fine_amount, total: net_amount, balance: emiInfo.balance, fk_Closed: self.closing == true ? "1" : "0")
        
         var paymentInfoList = [PaymentParamPaymentDetailsModel]()
        
        paymentInfoList = payment_added_list.map{ PaymentParamPaymentDetailsModel(paymentMethod: "\($0.method.id_PaymentMethod)", pamount: $0.amount, refno: $0.reference_no) }
        
        let latitude = coordinates.lat.format(f: ".6")
        let longitude = coordinates.lon.format(f: ".6")
        
        let info = PaymentParmaInfoModel(transdate: transDate, collectdate: collectDate, accountmode: "2", id_customerwiseEMI: customerInfo.id_CustomerWiseEMI, totalamount: net_amount, fineamount: fine_amount, netamount: net_amount, emi_details: emiDetails, paymentDetailsList: paymentInfoList, location_lat: latitude, location_long: longitude, location_name: location_address, location_enteredTime: DateTimeModel.shared.fetchTime(timeFormate: "hh:mm:ssa"))
        return info
    }
    
    fileprivate func submitEmiPaymentMethod(_ info: PaymentParmaInfoModel) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            self.commonNetworkVM.collectionAPIManager?.updateEMICollection(info: info, { responseHandler in
                
                let statusCode = responseHandler.statusCode
                let message = responseHandler.message
                let info = responseHandler.info
                
                if statusCode == 0{
                    
                    let success_message = info.value(forKey: "Message") as? String ?? ""
                    
                    self.popupAlert(title: "", message: success_message, actionTitles: [okTitle], actions: [{action1 in
                        self.payment_added_list = []
                        self.paymentFieldRefresh()
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2) {
                            self.popToViewController(ofClass: EmiCategoriesListingVC.self, controllers: self.allControllers)
                            
                        }
                    },nil])
                    
                }else{
                    
                    self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                    
                }
                
            })
        }
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        sender.opacityAnimation(duration:0.25)
        self.view.endEditing(true)
        
        let installment_amount = self.installMentView.HeaderDetailTF.text ?? "0.00"
        let fine_amount = self.fineView.HeaderDetailTF.text ?? "0.00"
        
        paymentSubmitValidationVM.fineAmountString = fine_amount
        paymentSubmitValidationVM.installMentString = installment_amount
        paymentSubmitValidationVM.closing = closing
        paymentSubmitValidationVM.paymentListCount = self.payment_added_list.count
        
        if paymentSubmitValidationVM.isValid == true{
            let info = getPaymentSubmitInfo()
            submitEmiPaymentMethod(info)
        }else{
            let message = self.paymentSubmitValidationVM.brockenRules.first!.message
            self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
        }
        
        
    }
    @IBAction func clearButtonAction(_ sender: UIButton) {
        sender.opacityAnimation(duration:0.25)
        self.view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            self.defaultValues()
        }
        
    }
    
    @IBAction func collectedByButtonAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        firstInitialise = false
        self.employeeButtonAction()
        
    }
    
    @IBAction func paymentMethodButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        let superView = sender.superview!
        superView.opacityAnimation(duration:0.25)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            if let model = self.collectionCalculatorVm{
                // initial balance in payment view
                if self.payment_added_list.count == 0{
                self.paymentAmountBalance = model.calculateNetAmount()
                }
            }
            
            self.paymentViewVisible = !self.paymentViewVisible
        }
        
    }
    
    func paymentMethodAPICall(){
        commonNetworkVM.collectionAPIManager?.paymentMethodAPICall(){ responseHandler in
            let statusCode = responseHandler.statusCode
            let message = responseHandler.message
            let info = responseHandler.info
            
            
            if statusCode == 0{
                
                let list  = info.value(forKey: "FollowUpPaymentMethodList") as? [NSDictionary] ?? []
                
                self.paymentMethodList = []
                self.paymentMethodList = list.map{ FollowUpPaymentMethodModel.init(datas: $0) }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                    self.paymentMethodPopUpAction()
                }
                
            }else{
              
                self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in },nil])
                
            }
        }
    }
    
    
    
    @IBAction func callButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            if let model = self.infoModel as? EMICollectionReportModel{
                self.callAction(number: "+91\(model.mobile)")
            }
        }
       
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
    
    @IBAction func locationButtonAction(_ sender: UIButton) {
        let superView = sender.superview!
        superView.opacityAnimation(duration:0.25)
        self.view.endEditing(true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            weak var mapViewPage = AppVC.Shared.mapViewPage
            mapViewPage?.isFetchLocation = true
            
            
            mapViewPage?.modalTransitionStyle = .crossDissolve
            mapViewPage?.modalPresentationStyle = .overCurrentContext
            self.navigationController?.present(mapViewPage!, animated: false, completion: nil)
        }
    
    }
    
    @IBAction func messageButtonAction(_ sender: UIButton) {
        let superView = sender.superview!
        superView.opacityAnimation(duration:0.25)
        self.view.endEditing(true)
        
    }
    
    
    fileprivate func paymentApplyValidation() {
        let netamountString =  self.netAmountView.NetAmountLabel.text ?? "0.00"
        
        paymentApplyValidationVM.netAmoutString = netamountString
        paymentApplyValidationVM.paymentArryCount = payment_added_list.count
        paymentApplyValidationVM.payableAmount = paymentAmountBalance
        
        if paymentApplyValidationVM.isValid == true{
            print(paymentAmountBalance)
            self.paymentViewVisible = !self.paymentViewVisible
        }else{
            let catchMessage =  self.paymentApplyValidationVM.brockenRules.first!.message
            self.popupAlert(title: "", message: catchMessage, actionTitles: [okTitle], actions: [{action1 in },nil])
        }
    }
    
    @IBAction func paymentApplyButtonAction(_ sender: UIButton) {
        let superView = sender.superview!
        superView.opacityAnimation(duration:0.25)
        self.view.endEditing(true)
        
        paymentApplyValidation()
    }
    
    @IBAction func paymentMethodTypeAction(_ sender: UIButton) {
        self.paymentMethodAPICall()
        
    }
    
    @IBAction func paymentBackButtonAction(_ sender: UIButton) {
        let superView = sender.superview!
        superView.opacityAnimation(duration:0.25)
        self.view.endEditing(true)
        self.payment_added_list = []
        self.paymentFieldRefresh()
        self.paymentTableView.reloadData()
      
        self.paymentViewVisible = !self.paymentViewVisible
    }
    
    
    @IBAction func paymentAddButtonAction(_ sender: UIButton) {
        let superView = sender.superview!
        superView.opacityAnimation(duration:0.25)
        self.view.endEditing(true)
        let amountString = paymentAmountView.HeaderDetailTF.text ?? "0.00"
        let balanceString = paymentBalanceView.HeaderDetailTF.text ?? "0.00"
        let referenceNumber = referenceNoView.HeaderDetailTF.text == "" ? "" : referenceNoView.HeaderDetailTF.text!
        self.paymentMethodVM.balanceString = balanceString
        self.paymentMethodVM.amountString = amountString
        self.paymentMethodVM.id_PaymentMethod = self.selectedPaymentMethod?.id_PaymentMethod ?? 0
        
        var isAddedPayment : [Bool] = []
        isAddedPayment = self.payment_added_list.map{ $0.method.id_PaymentMethod != self.paymentMethodVM.id_PaymentMethod }
        
        
        
        let hasCollectPayment = self.payment_added_list.count == 0 ? true : selectedEditingIndex != -1 ? true : !isAddedPayment.contains(false)
        
        if self.paymentMethodVM.isValid == true && hasCollectPayment == true{
          
              
           
            if selectedEditingIndex == -1{
                
                
                
                self.payment_added_list.append((method: self.selectedPaymentMethod!, amount: amountString, reference_no: referenceNumber))
                
            addPaymentCalculate(amountString:self.paymentMethodVM.amountString, balanceString: balanceString)
            
            
            commonNetworkVM.parserVm.mainThreadCall {
                
                self.paymentTableView.reloadData()
                self.paymentFieldRefresh()
                
            }
            }else{
                
                let indexpath = IndexPath.init(row: selectedEditingIndex, section: 0)
                let cell = paymentTableView.cellForRow(at: indexpath) as! PaymentMethodAddTVC
                cell.editButton.isEnabled = true
                self.payment_added_list[selectedEditingIndex].method = self.selectedPaymentMethod!
                self.payment_added_list[selectedEditingIndex].reference_no = referenceNumber
                self.payment_added_list[selectedEditingIndex].amount = amountString
                
                self.addPaymentCalculate(amountString:self.paymentMethodVM.amountString, balanceString: balanceString)
                self.commonNetworkVM.parserVm.mainThreadCall {
                    let indexPath = IndexPath.init(row: self.selectedEditingIndex, section: 0)
                    self.paymentTableView.reloadRows(at: [indexPath], with: .none)
                    self.selectedEditingIndex = -1
                    self.paymentFieldRefresh()
                }
            }
        
            self.paymentTableShowHideView()
            
        }else{
            
            let message = "This payment method already used"
            let catchMessage = self.paymentMethodVM.brockenRules.count == 0 ? message : self.paymentMethodVM.brockenRules.first!.message
            self.popupAlert(title: "", message: catchMessage, actionTitles: [okTitle], actions: [{action1 in },nil])
               
        }
        
    }
    
    func paymentFieldRefresh(){
        
        self.paymentMethodView.HeaderDetailTF.setTextFieldValue("")
        self.paymentAmountView.HeaderDetailTF.setTextFieldValue("")
        self.referenceNoView.HeaderDetailTF.setTextFieldValue("")
        self.selectedPaymentMethod = FollowUpPaymentMethodModel.init(datas: [:])
        if selectedEditingIndex != -1{
            let indexPath = IndexPath.init(row: self.selectedEditingIndex, section: 0)
            self.paymentTableView.reloadRows(at: [indexPath], with: .none)
            selectedEditingIndex = -1
            if let model = self.collectionCalculatorVm{
                // initial balance in payment view
                 
                self.payment_added_list.map{ addPaymentCalculate(amountString: $0.amount, balanceString: model.calculateBalance()) }
                
            }
            
        }
        
        
        
        commonNetworkVM.parserVm.mainThreadCall {
            self.commonNetworkVM.parserVm.progressBar.showIndicator()
            self.paymentTableView.reloadData()
            self.commonNetworkVM.parserVm.progressBar.hideIndicator()
        }
            
       
        
        self.paymentTableShowHideView()
     
    }
    
    func addPaymentCalculate(amountString:String,balanceString:String){
       
        paymentCalculateVm = PaymentCalculateViewmodel(balance: balanceString, amount: amountString)
        
        
        paymentCalculateVm?.calculateBalance { balance, error, statusCode in
                print("\(balance) - \(error)")
            if statusCode == 0{
                  paymentAmountBalance = balance
                  
            }else{
                self.popupAlert(title: "", message: error, actionTitles: [okTitle], actions: [{action1 in },nil])
            }
            }
    }
    
    @IBAction func paymentResetButtonAction(_ sender: UIButton) {
        let superView = sender.superview!
        superView.opacityAnimation(duration:0.25)
        self.paymentFieldRefresh()
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


extension EmiCollectionDetailsVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == paymentTableView ? self.payment_added_list.count : self.infoViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView{
        case paymentTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.shared.emiPaymentMethodCell) as! PaymentMethodAddTVC
            
            let info = payment_added_list[indexPath.row]
            
            cell.balanceView.HeaderDetailTF.setTextFieldValue(info.amount)
            cell.referenceView.HeaderDetailTF.setTextFieldValue(info.reference_no)
            cell.methodView.HeaderDetailTF.setTextFieldValue(info.method.paymentName)
            
            cell.editButton.isEnabled = true
            cell.editButton.tag = indexPath.row
            cell.editButton.addTarget(self, action: #selector(editPaymentMethod(_:)), for: .touchDragInside)
            
            cell.removeButton.tag = indexPath.row
            cell.removeButton.addTarget(self, action: #selector(removePaymentMethod(_:)), for: .touchDragInside)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.shared.emiDetailsCell) as! EMIDetailsTVC
            
            
            let info = self.infoViewList[indexPath.row]
            cell.viewModel = info
            
            cell.selectionStyle = .none
            return cell
        }
        
    }
   
    
    @objc func removePaymentMethod(_ sender : UIButton){
        self.selectedRemoveIndex = sender.tag
        if self.payment_added_list.count > 0 && self.selectedRemoveIndex != -1{
        
        let balanceString = paymentBalanceView.HeaderDetailTF.text ?? "0.00"
            
            if self.payment_added_list.indices.contains(selectedRemoveIndex) && self.selectedRemoveIndex != -1{
                
                
                let catchMessage = "Are you sure want to delete ?"
                self.popupAlert(title: "Delete", message: catchMessage, actionTitles: [no_cancel_title,yesTitle], actions: [{ action1 in
                    print("no")
                   
                },{action2 in
                    print("yes")
                    self.payment_added_list.map{ self.addPaymentCalculate(amountString: "-\($0.amount)", balanceString: balanceString) }
                    
                    let method_id = self.payment_added_list[self.selectedRemoveIndex].method.id_PaymentMethod
                        
                        self.payment_added_list = self.payment_added_list.filter{ $0.method.id_PaymentMethod != method_id }
                    
                    self.selectedRemoveIndex = -1
                    self.paymentFieldRefresh()
                },nil])
                
            }
            
                // initial balance in payment view
                 
                
                
    
            
            
            
        }
        
    }
    @objc func editPaymentMethod(_ sender : UIButton){
        print(sender.tag)
        
        selectedPaymentMethod = self.payment_added_list[sender.tag].method
        let amountString = self.payment_added_list[sender.tag].amount
        let reference = self.payment_added_list[sender.tag].reference_no
        let balance = Double(paymentBalanceView.HeaderDetailTF.text ?? "0.00")! + Double(self.payment_added_list[sender.tag].amount)!
        let balanceString = balance.format(f: ".2")
        self.selectedEditingIndex = sender.tag
        commonNetworkVM.parserVm.mainThreadCall {
            self.paymentMethodView.HeaderDetailTF.setTextFieldValue(self.selectedPaymentMethod?.paymentName ?? "")
            self.paymentAmountView.HeaderDetailTF.setTextFieldValue(amountString)
            self.referenceNoView.HeaderDetailTF.setTextFieldValue(reference)
//            self.paymentCalculateVm = PaymentCalculateViewmodel(balance: balanceString, amount: "-\(amountString)")
//            self.paymentCalculateVm?.calculateBalance(completion: { balance, error, statusCode in
                self.paymentAmountBalance = balanceString
            
                self.paymentAmountView.HeaderDetailTF.becomeFirstResponder()
                sender.isEnabled = false
            //})
        }

        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView == paymentTableView ? 126 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}


extension EmiCollectionDetailsVC:ClosingDelegate{
    func hasCloseBalance(closed: Bool) {
        self.closing = closed
        
       
        collectionCalculatorVm?.closing = closing
        if let collectioncalmodel = collectionCalculatorVm,let balanceString = collectionCalculatorVm?.calculateBalance() as? String,let netamountString =  collectionCalculatorVm?.calculateNetAmount() as? String{
        self.balanceView.balanceAmountLbl.setLabelValue(balanceString)
        self.netAmountView.NetAmountLabel.setLabelValue(netamountString)
            if self.closing == true{
                let installmentAmount = Double(collectioncalmodel.openigBalance)!.format(f: ".2")
                self.installMentView.HeaderDetailTF.setTextFieldValue(installmentAmount)
                self.installMentView.HeaderDetailTF.setTextColor(AppColor.Shared.grey_dark)
                self.installMentView.isUserInteractionEnabled = false
            }else{
                let model = self.emiAccountDetailsModel.EMIAccountDetailsList.first!
                let installMentAmount = Double(model.amount)!.format(f: ".2")
                self.installMentView.HeaderDetailTF.setTextFieldValue(installMentAmount)
                self.installMentView.HeaderDetailTF.setTextColor(AppColor.Shared.coloBlack)
                self.installMentView.isUserInteractionEnabled = true
            }
        self.paymentAmountBalance = netamountString
        if let wordAmountString = collectionCalculatorVm?.toWords(number: netamountString){
            self.netAmountView.NetAmountWordLabel.setLabelValue("(\(wordAmountString))")
          }
        }
    }
    
    
}

extension EmiCollectionDetailsVC : UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == fineView.HeaderDetailTF{
            let model = emiAccountDetailsModel.EMIAccountDetailsList.first!
            let installMentAmount = Double(installMentView.HeaderDetailTF.text ?? "0.00")!.format(f: ".2")
            let fineAmount = Double(textField.text ?? "0.00")!.format(f: ".2")
            collectionCalculatorVm = CollectionCalculator.init(openigBalance: model.balance, installment_amount: installMentAmount, fine_amount: fineAmount, closing: closing)
            
            if  let netamountString = collectionCalculatorVm?.calculateNetAmount() as? String{
                
                self.netAmountView.NetAmountLabel.setLabelValue(netamountString)
                
            }
        }
        
        if textField == installMentView.HeaderDetailTF{
            
            let model = emiAccountDetailsModel.EMIAccountDetailsList.first!
            let installMentAmount = Double(textField.text ?? "0.00")!.format(f: ".2")
            let fineAmount = Double(fineView.HeaderDetailTF.text ?? "0.00")!.format(f: ".2")
            collectionCalculatorVm = CollectionCalculator.init(openigBalance: model.balance, installment_amount: installMentAmount, fine_amount: fineAmount, closing: closing)
            
            if  let netamountString = collectionCalculatorVm?.calculateNetAmount() as? String{
                
                self.netAmountView.NetAmountLabel.setLabelValue(netamountString)
                
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }

        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1

        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
    }
}

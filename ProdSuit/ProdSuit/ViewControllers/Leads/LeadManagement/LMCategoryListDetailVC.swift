//
//  LMCategoryListDetailVC.swift
//  ProdSuit
//
//  Created by MacBook on 19/05/23.
//

import UIKit
import Combine
import CallKit

class LMCategoryListDetailVC: UIViewController,TabLayoutDelegate,CXCallObserverDelegate{
    
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        if call.hasEnded{
            let id_LeadGenerateProduct = "\(self.info.ID_LeadGenerateProduct)"
            let id_LeadGenerate = "\(info.ID_LeadGenerate)"
            
            let followUpPage = AppVC.Shared.lmCDFollowUpPage
            followUpPage.id_LeadGenerateProduct = id_LeadGenerateProduct
            followUpPage.id_LeadGenerate = id_LeadGenerate
            
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

    var from : String = ""
    var info : LeadManagementDetailsInfo!
    var fk_employee : String = ""
    var callObserver:CXCallObserver!
    var parserVm: GlobalAPIViewModel!
    
    var apiParserVm: APIParserManager = APIParserManager()
    lazy var uploadCancellable = Set<AnyCancellable>()
    
    var docBtnRotate:Bool=false{
        didSet{
            UIView.animate(withDuration: 0.2) {
                
                self.docView.transform =  self.docBtnRotate ==  false ? CGAffineTransform.identity : CGAffineTransform(rotationAngle: CGFloat.pi/4)
                
                self.docAddView.transform = self.docBtnRotate ==  false ? CGAffineTransform.init(scaleX: 0, y: 0) : CGAffineTransform.identity
                
                
                
            }
        }
    }
    
    @IBOutlet weak var docView: UIView!{
        didSet{
            self.docView.setBGColor(color: AppColor.Shared.colorPrimary)
            docView.layer.masksToBounds = false
            docView.layer.shadowRadius = 2
            docView.layer.shadowOpacity = 0.45
            docView.layer.shadowColor = AppColor.Shared.greydark.cgColor
            docView.layer.shadowOffset = CGSize(width: 0 , height:2)

            self.docView.setCornerRadius(size: self.docView.frame.width/2)
        }
    }
    @IBOutlet weak var contactView: UIView!{
        didSet{
            
            contactView.layer.masksToBounds = false
            contactView.layer.shadowRadius = 2
            contactView.layer.shadowOpacity = 0.75
            contactView.layer.shadowColor = AppColor.Shared.greydark.cgColor
            contactView.layer.shadowOffset = CGSize(width: 0 , height:3)
            contactView.setCornerRadius(size: 6)
            
                        
        }
    }
    @IBOutlet weak var cardView: UIView!{
        didSet{
            cardView.setCornerRadius(size: 5)
        }
    }
    @IBOutlet weak var mobileNumberLbl: UILabel!{
        didSet{
            self.mobileNumberLbl.setTextColor(AppColor.Shared.colorWhite)
            self.mobileNumberLbl.setFontSize(12, font: .regular,autoScale: true)
            
        }
    }
    @IBOutlet weak var addressLbl: UILabel!{
        didSet{
            
            self.addressLbl.setTextColor(AppColor.Shared.colorWhite)
            self.addressLbl.setFontSize(12, font: .regular,autoScale: true)
           
        }
    }
    @IBOutlet weak var nameLbl: UILabel!{
        didSet{
            self.nameLbl.setTextColor(AppColor.Shared.colorWhite)
            self.nameLbl.setFontSize(15, font: .medium,autoScale: true)
           
        }
    }
    
    
    @IBOutlet weak var docAddView: UIView!
    
    @IBOutlet weak var leadImageView: UIImageView!
    @IBOutlet weak var tabLayout: TabLayout!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        self.parserVm = GlobalAPIViewModel(bgView: self.view)
        callObserver = CXCallObserver()
        callObserver.setDelegate(self, queue: nil)
        tabLayout.tabLayoutDelegate = self
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.docBtnRotate = false
        self.mobileNumberLbl.text = info.LgCusMobile
        self.addressLbl.text = info.CusAddress
        self.nameLbl.text = info.LgCusName.capitalized
        
        let page1 = AppVC.Shared.lmDetailsInfoPage
        let id_LeadGenerateProduct = "\(self.info.ID_LeadGenerateProduct)"
        let branchCode = "\(preference.User_FK_Branch)"
        DispatchQueue.main.async {
            page1.leadInfoAPICall(id_LeadGenerateProduct, branchCode)
        }
      
        
        let page2 = AppVC.Shared.lmDetailsLoadPage
        let id_actionType = "\(info.ID_NextAction)"
        fk_employee = info.FK_Employee
        DispatchQueue.main.async {
            page2.leadHistoryAPICall(id_LeadGenerateProduct, id_actionType, self.fk_employee)
        }
       
        let page3 = AppVC.Shared.lmDetailsLocationPage
        let id_LeadGenerate = "\(info.ID_LeadGenerate)"
        DispatchQueue.main.async {
            page3.locationImageAPICall(id_LeadGenerate, id_LeadGenerateProduct, self.fk_employee)
        }
        
        let page4 = AppVC.Shared.lmDetailsImagePage
        DispatchQueue.main.async {
            page4.locationImageAPICall(id_LeadGenerate, id_LeadGenerateProduct, self.fk_employee)
        }
        
        let page5 = AppVC.Shared.lmDetailsDocumentPage
        DispatchQueue.main.async {
          
            page5.documentAPICall(id_LeadGenerate, id_LeadGenerateProduct)
            page5.ID_LeadGenerate = id_LeadGenerate
            page5.ID_LeadGenerateProduct = id_LeadGenerateProduct
        }
        
        if from != "mylead"{
            tabLayout.addTabs(tabs: [
                        ("INFO", nil, page1),
                        ("HISTORY", nil, page2),
                        ("LOCATION", nil, page3),
                        ("IMAGES", nil, page4),
                        ("DOCUMENTS", nil, page5)
                        ])
        }else{
            tabLayout.addTabs(tabs: [
                        ("INFO", nil, page1),
                        ("HISTORY", nil, page2)
                        ])
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
    
    
    
    @IBAction func callButtonAction(_ sender: Any) {
        let number  = info.LgCusMobile
        self.callAction(number: "+91\(number)")
    }
    
    
    @IBAction func siteVisitButtonAction(_ sender: UIButton) {
        
        let id_LeadGenerateProduct = "\(self.info.ID_LeadGenerateProduct)"
        let id_LeadGenerate = "\(info.ID_LeadGenerate)"
        
        let followUpPage = AppVC.Shared.lmCDFollowUpPage
        followUpPage.id_LeadGenerateProduct = id_LeadGenerateProduct
        followUpPage.id_LeadGenerate = id_LeadGenerate
        
        DispatchQueue.main.async {[weak self] in
            if !(self?.allControllers.contains(followUpPage))!{
                followUpPage.actionTypeValue = 2
                self?.navigationController?.pushViewController(followUpPage, animated: true)
            }else{
                print("all ready contain")
            }
        }

    }
    
    
    @IBAction func messageButtonAction(_ sender: UIButton) {
        
        let messageVc = AppVC.Shared.lmTodoMessagePage
        messageVc.modalTransitionStyle = .coverVertical
        messageVc.modalPresentationStyle = .overCurrentContext
        DispatchQueue.main.async {[weak self] in
            self?.present(messageVc, animated: true, completion: nil)
        }
        
    }
    
  
    
    @IBAction func docAddButtonAction(_ sender: UIButton) {
        self.docBtnRotate = !self.docBtnRotate
    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
       
        let detailVc = AppVC.Shared.lmTodoCategoryListDetailPage
        DispatchQueue.main.async {
            if self.allControllers.contains(detailVc){
            self.navigationController?.popViewController(animated: true)
            }
        }
       
    }
    
    @IBAction func followUpButtonAction(_ sender: UIButton) {
        
        let id_LeadGenerateProduct = "\(self.info.ID_LeadGenerateProduct)"
        let id_LeadGenerate = "\(info.ID_LeadGenerate)"
        
        let followUpPage = AppVC.Shared.lmCDFollowUpPage
        followUpPage.id_LeadGenerateProduct = id_LeadGenerateProduct
        followUpPage.id_LeadGenerate = id_LeadGenerate
        followUpPage.actionTypeValue = 0
       
        DispatchQueue.main.async {[weak self] in
            if !(self?.allControllers.contains(followUpPage))!{
                self?.navigationController?.pushViewController(followUpPage, animated: true)
            }else{
                print("all ready contain")
            }
        }
        
    }
    
    @IBAction func attachFileButtonAction(_ sender: UIButton) {
        
        let docUploadPage = AppVC.Shared.lmCDDocUploadPage
        DispatchQueue.main.async {[weak self] in
            
            if !(self?.allControllers.contains(docUploadPage))!{
                docUploadPage.uploadDetailsDelegate = self
                self?.navigationController?.pushViewController(docUploadPage, animated: true)
            }else{
                print("all ready contain")
            }
            
        }
        
    }
    
    
    
    
    func tabLayout(tablayout: TabLayout, index: Int) {
        print("selected index : \(index)")
        

        
        let id_actionType = "\(info.ID_NextAction)"
        let branchCode = "\(preference.User_FK_Branch)"
        let id_LeadGenerateProduct = "\(self.info.ID_LeadGenerateProduct)"
        let id_LeadGenerate = "\(info.ID_LeadGenerate)"
        
        switch index{
        case 1:
            let historyPage = AppVC.Shared.lmDetailsLoadPage
            
            DispatchQueue.main.async {
                historyPage.leadHistoryAPICall(id_LeadGenerateProduct, id_actionType, self.fk_employee)
            }
        case 2:
            
            let locationPage = AppVC.Shared.lmDetailsLocationPage
            
            DispatchQueue.main.async {
                locationPage.locationImageAPICall(id_LeadGenerate, id_LeadGenerateProduct, self.fk_employee)
            }
            
        case 3:
            
            let imagePage = AppVC.Shared.lmDetailsImagePage
            
            DispatchQueue.main.async {
                imagePage.locationImageAPICall(id_LeadGenerate, id_LeadGenerateProduct, self.fk_employee)
            }
            
        case 4:
            let documentPage = AppVC.Shared.lmDetailsDocumentPage
            DispatchQueue.main.async {
                documentPage.documentAPICall(id_LeadGenerate, id_LeadGenerateProduct)
                documentPage.ID_LeadGenerate = id_LeadGenerate
                documentPage.ID_LeadGenerateProduct = id_LeadGenerateProduct
            }
            
        
        default:
            let loadPage = AppVC.Shared.lmDetailsInfoPage
           
            DispatchQueue.main.async {
                loadPage.leadInfoAPICall(id_LeadGenerateProduct, branchCode)
            }
            
        }
        
    }
    
    func documentUploadAPICall(data:String,subject:String,description:String,date:String,formate:String){
        let bankKey = preference.appBankKey
        let ID_LeadGenerateProduct = "\(info.ID_LeadGenerateProduct)"
        let token = preference.User_Token
        let fk_company = "\(preference.User_FK_Company)"
        let entrBy = preference.User_UserCode
        let DocumentImage = data
        let Doc_Subject = subject
        let Doc_Description = description
        let DocImageFormat = formate
        let Doc_Date = DateTimeModel.shared.formattedDateFromString(dateString: date)
       
        
         if let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
            let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
            let eID_LeadGenerateProduct = instanceOfEncryptionPost.encryptUseDES(ID_LeadGenerateProduct, key: SKey),
            let eentrBy = instanceOfEncryptionPost.encryptUseDES(entrBy, key: SKey),
            let eDoc_Date = instanceOfEncryptionPost.encryptUseDES(Doc_Date, key: SKey),
            let eDocumentImage = instanceOfEncryptionPost.encryptUseDES(DocumentImage, key: SKey),
            let eDoc_Subject = instanceOfEncryptionPost.encryptUseDES(Doc_Subject, key: SKey),
            let eDoc_Description = instanceOfEncryptionPost.encryptUseDES(Doc_Description, key: SKey),
            let eDocImageFormat = instanceOfEncryptionPost.encryptUseDES(DocImageFormat, key: SKey),
                
            let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey){
             let arguMents = ["BankKey":ebankKey,"Token":etoken,"EntrBy":eentrBy,"ID_LeadGenerateProduct":eID_LeadGenerateProduct,"FK_Company":efk_company,"DocumentImage":DocumentImage,"Doc_Subject":eDoc_Subject,"Doc_Description":eDoc_Description,"DocImageFormat":eDocImageFormat,"Doc_Date":eDoc_Date]
            
             let request = apiParserVm.request(urlPath: URLPathList.Shared.leadUploadDocuments,arguMents: arguMents)
             self.parserVm.modelInfoKey = ""
             self.parserVm.progressBar.showIndicator()
             self.parserVm.parseApiRequest(request)
                
             self.parserVm.$responseHandler
                 .dropFirst()
                 .sink { responseHandler in
                 self.parserVm.progressBar.hideIndicator()
                 let statusCode = responseHandler.statusCode
                 let message = responseHandler.message
                 
                 if statusCode == 0{
                     self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in
                         let documentPage = AppVC.Shared.lmDetailsDocumentPage
                         DispatchQueue.main.async {
                             let ID_LeadGenerate = "\(self.info.ID_LeadGenerate)"
                             documentPage.documentAPICall(ID_LeadGenerate, ID_LeadGenerateProduct)
                             documentPage.ID_LeadGenerate = ID_LeadGenerate
                             documentPage.ID_LeadGenerateProduct = ID_LeadGenerateProduct
                         }
                     },nil])
                 }else{
                     self.popupAlert(title: "", message: message, actionTitles: [okTitle], actions: [{action1 in
                         print("no data found")
                     },nil])
                 }
                 
                 self.uploadCancellable.dispose()
             }.store(in: &uploadCancellable)
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

extension LMCategoryListDetailVC:UploadDocumentDelegate{
   
    
    func uploadDocumentDetails(date: String, subject: String, description: String, dataString: String,formate: String) {
        documentUploadAPICall(data: dataString, subject: subject, description: description,date: date,formate: formate)
    }
    
    
}

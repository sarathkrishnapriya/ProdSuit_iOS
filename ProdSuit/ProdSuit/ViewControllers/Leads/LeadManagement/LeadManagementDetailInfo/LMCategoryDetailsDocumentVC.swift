//
//  LMCategoryDetailsDocumentVC.swift
//  ProdSuit
//
//  Created by MacBook on 19/05/23.
//

import UIKit
import Combine
import PDFKit

protocol DocumentsApiDelegate:AnyObject {
    
    var parserVm:GlobalAPIViewModel! { get set }
    var apiParserVm :  APIParserManager! { get set }
    
    func documentAPICall(_ ID_LeadGenerate:String,_ ID_LeadGenerateProduct:String)
}

class LMCategoryDetailsDocumentVC: UIViewController,DocumentsApiDelegate,UIDocumentInteractionControllerDelegate{
    
    @IBOutlet weak var documentTableView: UITableView!
    
    var parserVm: GlobalAPIViewModel!
    
    var ID_LeadGenerate:String = ""
    var ID_LeadGenerateProduct:String = ""
    var documentController: UIDocumentInteractionController = UIDocumentInteractionController()
    var apiParserVm: APIParserManager!
    
    var infoList : [LMDDocumentDetailsModel] = []{
        didSet{
            self.documentTableView.reloadData()
        }
    }
    
    lazy var documentCancellable = Set<AnyCancellable>()
    lazy var documentDownLoadCancellable = Set<AnyCancellable>()
    
    func documentAPICall(_ ID_LeadGenerate:String,_ ID_LeadGenerateProduct:String) {
        
        let requestMode = RequestMode.shared.leadDocumentDetails
        let token = preference.User_Token
        let bankKey = preference.appBankKey
        let fk_company = "\(preference.User_FK_Company)"
       
        //let id_LeadDocumentDetails = ID_LeadDocumentDetails
        let id_LeadGenerate = ID_LeadGenerate
        let leadGenerateProduct_id = ID_LeadGenerateProduct
        
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           
           
            let eid_LeadGenerate = instanceOfEncryptionPost.encryptUseDES(id_LeadGenerate, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let eProductId = instanceOfEncryptionPost.encryptUseDES(leadGenerateProduct_id, key: SKey){
           
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Company":efk_company,"ID_LeadGenerateProduct":eProductId,"ID_LeadGenerate":eid_LeadGenerate]
            let request = apiParserVm.request(urlPath: URLPathList.Shared.leadDocumentDetails,arguMents: arguMents)
           
                parserVm.modelInfoKey = "DocumentDetails"
                //parserVm.progressBar.showIndicator()
                parserVm.parseApiRequest(request)
                parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    //self.parserVm.progressBar.hideIndicator()
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    
                    if statusCode == 0{
                        let list = responseHandler.info.value(forKey: "DocumentDetailsList") as? [NSDictionary] ?? []
                        self.infoList = []
                        self.infoList = list.map{ LMDDocumentDetailsModel(datas: $0) }
                        self.documentTableView.tableHasItems()
                    }else{
                       print("lead info : \(message)")
                        self.infoList = []
                        self.documentTableView.tableIsEmpty("", message, AppColor.Shared.coloBlack)
                    }
                    
                    print(responseHandler.info)
                    self.documentCancellable.dispose()
                }.store(in: &documentCancellable)
            
        }

    }
    
    func downLoadDocumentAPICall(_ ID_LeadGenerate:String,_ ID_LeadGenerateProduct:String,_ ID_LeadDocumentDetails:String,_ pathExtension:String) {
        let requestMode = RequestMode.shared.leadDocumentDetails
        let token = preference.User_Token
        let bankKey = preference.appBankKey
        let fk_company = "\(preference.User_FK_Company)"
       
        let id_LeadDocumentDetails = ID_LeadDocumentDetails
        let id_LeadGenerate = ID_LeadGenerate
        let leadGenerateProduct_id = ID_LeadGenerateProduct
        
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let eID_LeadDocumentDetails = instanceOfEncryptionPost.encryptUseDES(id_LeadDocumentDetails, key: SKey),
           
           let eid_LeadGenerate = instanceOfEncryptionPost.encryptUseDES(id_LeadGenerate, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let eProductId = instanceOfEncryptionPost.encryptUseDES(leadGenerateProduct_id, key: SKey){
           
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Company":efk_company,"ID_LeadGenerateProduct":eProductId,"ID_LeadGenerate":eid_LeadGenerate,"ID_LeadDocumentDetails":eID_LeadDocumentDetails]
            let request = apiParserVm.request(urlPath: URLPathList.Shared.leadManageDocumentDownLoad,arguMents: arguMents)
           
                parserVm.modelInfoKey = "DocumentImageDetails"
                parserVm.progressBar.showIndicator()
                parserVm.parseApiRequest(request)
                parserVm.$responseHandler
                .dropFirst()
                .sink { [self] responseHandler in
                    self.parserVm.progressBar.hideIndicator()
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    
                    if statusCode == 0{
                        
                        let documentString = responseHandler.info.value(forKey: "DocumentImage") as? String ?? ""
                
                        if let mutableData = NSMutableData.init(base64Encoded: documentString){
                           // let url = self.saveAndOpenFile(data: mutableData, fileName: "Upload")
//                            print(url)
                            
                            
                            
                            
                            guard let data = Data(base64Encoded: documentString, options: .ignoreUnknownCharacters) else {
                                print("unable to convert base 64 string to data")
                                return
                            }
                            
                            let date  = Date()
                            let fileName = date.millisecondsSince1970
                            let extensionType = pathExtension.deletingPrefix(".")
                            let endPath = "\(fileName).\(extensionType)"
                            print("file Name : \(endPath)")
                            
                            
                            
                            let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                            
                            
                            let destinationUrl = documentUrl.appendingPathComponent(endPath)
                            
                            if FileManager.default.fileExists(atPath: (destinationUrl.path)){
                                try! FileManager.default.removeItem(at: destinationUrl)
                            }
                            
                            do{
                                try data.write(to: destinationUrl, options: .atomic)
                                    let contents = try FileManager.default.contentsOfDirectory(at: documentUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                                
                                let getContent =  contents.filter{ return $0.lastPathComponent == destinationUrl.lastPathComponent }
                                
                                self.openSelectedDocumentFromURL(documentURLString: getContent[0])
                             
                            }catch{
                                print("get error")
                            }
                           
                            
                        }else{
                            print("error")
                        }
                      
                    }else{
                       print("lead info : \(message)")
                   
                    }
                    
                    print(responseHandler.info)
                    self.documentDownLoadCancellable.dispose()
                }.store(in: &documentDownLoadCancellable)
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.apiParserVm = APIParserManager()
        self.parserVm = GlobalAPIViewModel(bgView: self.view)
        tableInitialisation()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func tableInitialisation() {
        self.documentTableView.dataSource = self
        self.documentTableView.delegate = self
        self.documentTableView.separatorStyle = .none
        self.documentTableView.backgroundColor = AppColor.Shared.greylight
        self.documentTableView.contentInset  = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func exportAsPdfFromView(data:NSMutableData) -> String {

        let pdfPageFrame = self.view.bounds
        let pdfData = data
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return "" }
        self.view.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        return self.saveViewPdf(data: pdfData)

    }

    // Save pdf file in document directory
    func saveViewPdf(data: NSMutableData) -> String {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      let docDirectoryPath = paths[0]
      let pdfPath = docDirectoryPath.appendingPathComponent("viewPdf.pdf")
      if data.write(to: pdfPath, atomically: true) {
          return pdfPath.path
      } else {
          return ""
      }
    }
    
    func openSelectedDocumentFromURL(documentURLString: URL)
    {
        DispatchQueue.main.async {
            self.documentController  = UIDocumentInteractionController.init(url: documentURLString)
           
            self.documentController.delegate = self
            //self.documentController.name = documentURLString.lastPathComponent
            self.documentController.presentPreview(animated: false)
            self.documentController.presentOptionsMenu(from: self.view.frame,
                                                       in: self.view,
                                                       animated: true)
         
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        
        UINavigationBar.appearance().tintColor = UIColor.black


       return self
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


extension LMCategoryDetailsDocumentVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.infoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.shared.leadManagementDocumentUploadCell) as! LMDDocumentUploadTVC
        cell.bgGradient(cell.bgView)
       
        let info = infoList[indexPath.item]
        cell.vm = info
        cell.downLoadButton.tag = indexPath.row
        cell.downLoadButton.addTarget(self, action: #selector(saveFilesInMobileButtonAction(_:)), for: .touchDragInside)
        
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func saveFilesInMobileButtonAction(_ sender : UIButton){
        print(sender.tag)
        let ID_LeadDocumentDetails = "\(self.infoList[sender.tag].ID_LeadDocumentDetails)"
        downLoadDocumentAPICall(ID_LeadGenerate, ID_LeadGenerateProduct, ID_LeadDocumentDetails, self.infoList[sender.tag].DocumentImageFormat)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

//
//  LMCDAttachDocVC.swift
//  ProdSuit
//
//  Created by MacBook on 23/05/23.
//

import UIKit
import Combine
import UniformTypeIdentifiers
import MobileCoreServices


protocol UploadDocumentDelegate:AnyObject {
    func uploadDocumentDetails(date:String,subject:String,description:String,dataString:String,formate:String)
}

class LMCDAttachDocVC: UIViewController,LMCDDocUploadDateDelegate {
    
    func getDate(date: String) {
        self.dateTF.setTextFieldValue(date)
    }
    

    
    @IBOutlet weak var attachmentTF: LMCDDocUploadTF!
    @IBOutlet weak var messageTextView: UITextView!{
        didSet{
            messageTextView.addDonButton()
            
        }
    }
    @IBOutlet weak var messageImgView: UIImageView!{
        didSet{
            messageImgView.image = messageImgView.image?.imageWithColor(color1: AppColor.Shared.greydark)
        }
    }
    @IBOutlet weak var messageView: UIView!{
        didSet{
            self.messageView.setCornerRadius(size: 5)
            self.messageView.setBorder(width: 0.65, borderColor: AppColor.Shared.greydark)
            
        }
    }
    @IBOutlet weak var subjectTF: UITextField!{
        didSet{
            self.subjectTF.addDonButton()
        }
    }
    @IBOutlet weak var dateTF: LMCDDocUploadDateTF!{
        didSet{
          
            self.dateTF.docDateDeleagate = self
        }
    }
    @IBOutlet weak var bgView: UIView!{
        didSet{
            self.bgView.setCornerRadius(size: 5)
            self.bgView.viewShadow(AppColor.Shared.greydark,CGSize(width: 0, height: 2),2,0.5)
        }
    }
    
    var messageText:String = ""
    
    lazy var descriptionCancellable = Set<AnyCancellable>()
    lazy var keyboardManager = KeyboardHeightPublisher
    lazy var keyboardCancellable = Set<AnyCancellable>()
    var importMenu : UIDocumentPickerViewController!
    lazy var imagePickerVm : ImagePickerManager = ImagePickerManager()
    
    lazy var attachFileViewModel : AttachmentHandler = AttachmentHandler()
    weak var uploadDetailsDelegate:UploadDocumentDelegate?
    lazy var uploadDocumentValidationVM : LMCUpLoadDocuMentValidationModel = LMCUpLoadDocuMentValidationModel(brockenRules: [])
    var dataString:String = ""
    var dataFormate:String = ""
    var dataFileName:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        messageTextView.text = "Description"
        messageTextView.textColor = UIColor.lightGray
        keyboardHandler()
        didMessageChange()
        
       
        // Do any additional setup after loading the view.
    }
    
    fileprivate func didMessageChange() {
        messageTextView.delegate = self
        textViewPublisher.sink { text in
            self.messageText = text
            
            print(self.messageText)
        }.store(in: &descriptionCancellable)
    }
    
    fileprivate func keyboardHandler() {
        keyboardManager
          
          .sink { completed in
            print(completed)
        } receiveValue: { height in
            print(height)
            
            
            
            self.view.frame.origin.y = height > 0 ? -height/5 : 0
            
        }.store(in: &keyboardCancellable)
    }
    
    func resetPage(){
        self.messageText = ""
        
        self.dateTF.text =  DateTimeModel.shared.stringDateFromDate(Date())
        messageTextView.text = "Description"
        messageTextView.textColor = UIColor.lightGray
        self.subjectTF.text = ""
        self.attachmentTF.text = ""
        self.view.endEditing(true)
     

    }
    

    @IBAction func backButtonAction(_ sender: BackButtonCC) {
        
        self.resetPage()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
//    func OpenFile(){
//
////        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePNG),String(kUTTypeImage)], in: .import)
////        importMenu.delegate = self
////        importMenu.modalPresentationStyle = .fullScreen
////        self.present(importMenu, animated: true, completion: nil)
//
//
//        if #available(iOS 14.0, *) {
//            let contentTypes: [UTType] = [
//                .init(filenameExtension: "doc")!,
//                .init(filenameExtension: "docx")!,
//                .pdf,
//                .jpeg,
//                .png,
//                .image]
//
//            importMenu = UIDocumentPickerViewController(forOpeningContentTypes: contentTypes, asCopy: false)
//
//
//                } else {
//
//
//                    let pdf                                 = String(kUTTypePDF)
//                    let img                                 = String(kUTTypeImage)
//                    let png                                 = String(kUTTypePNG)
//                    let jpeg                                = String(kUTTypeJPEG)
//
//                    let types: [String] = [pdf,img,png,jpeg]
//
//
//            importMenu = UIDocumentPickerViewController(documentTypes: types, in: .open)
//
//
//                }
//
//        importMenu.delegate = self
//        importMenu.modalPresentationStyle = .formSheet
//        self.present(importMenu, animated: true, completion: nil)
//
//
//    }
    
    fileprivate func cameraPhotoAccess() {
        imagePickerVm.pickImage(self) { selectedImage,filename in
            if let imageData = selectedImage.jpeg(.low) {
                let base64String = imageData.base64EncodedString()
                self.attachmentTF.text = filename
                print(base64String)
            }
        }
    }
    
    @IBAction func attachMentButtonAction(_ sender: UIButton) {
        
//        cameraPhotoAccess()
        attachFileViewModel.showAttachmentActionSheet(vc: self) { file_name, dataString,formate in
            self.attachmentTF.setTextFieldValue(file_name)
            self.dataString = dataString
            self.dataFormate = formate
            self.dataFileName = file_name
            
            self.view.endEditing(true)
        }
    }
    
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        
        uploadDocumentValidationVM.subject = self.subjectTF.text ?? ""
        uploadDocumentValidationVM.description = self.messageText
        uploadDocumentValidationVM.attachment = self.attachmentTF.text ?? ""
        if !uploadDocumentValidationVM.isValid{
            self.uploadDetailsDelegate?.uploadDocumentDetails(date: self.dateTF.text ?? "", subject: self.subjectTF.text ?? "", description: messageText, dataString: dataString, formate: dataFormate)
            self.resetPage()
            self.navigationController?.popViewController(animated: true)
        }else{
            self.popupAlert(title: "", message: uploadDocumentValidationVM.brockenRules.first?.message, actionTitles: [okTitle], actions: [{action1 in
                
            },nil])
        }
       
    }
    @IBAction func cancelButtonAction(_ sender: LMMCancelBtn) {
        self.resetPage()
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

extension LMCDAttachDocVC : UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentString : NSString = messageText as NSString
        let newString  : NSString = currentString.replacingCharacters(in: range, with: text) as NSString
        if newString.length == messageMaxLength{
            self.view.endEditing(true)
        }
        return newString.length <= messageMaxLength
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = AppColor.Shared.greydark
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
}

//extension LMCDAttachDocVC:UIDocumentPickerDelegate{
//
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
//        dismiss(animated: true)
//
//        guard url.startAccessingSecurityScopedResource() else {
//            return
//        }
//
//        do {
//
//
//            let data = try Data.init(contentsOf: url)
//            let base64 = data.base64EncodedString()
//            print(base64)
//            print(url.lastPathComponent)
//
//                   // You will have data of the selected file
//               }
//               catch {
//                   print(error.localizedDescription)
//               }
//
//        defer {
//            url.stopAccessingSecurityScopedResource()
//        }
//
//        // Copy the file with FileManager
//    }
//}



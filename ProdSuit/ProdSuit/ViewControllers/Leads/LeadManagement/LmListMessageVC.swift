//
//  LmListMessageVC.swift
//  ProdSuit
//
//  Created by MacBook on 18/05/23.
//

import UIKit
import Combine

class LmListMessageVC: UIViewController {
    
    
    
    
    
    @IBOutlet weak var messageImgView: UIImageView!{
        didSet{
            messageImgView.image = messageChecked == false ? uncheckedMark : checkedMark
        }
    }
    @IBOutlet weak var emailImgView: UIImageView!
    {
        didSet{
            emailImgView.image = emailChecked == false ? uncheckedMark : checkedMark
        }
    }
    @IBOutlet weak var messageTV: LmmessageTexview!{
        didSet{
            messageTV.autocorrectionType = .no
            messageTV.showsVerticalScrollIndicator = false
            messageTV.showsHorizontalScrollIndicator = false
            messageTV.tintColor = AppColor.Shared.coloBlack
            messageTV.addDonButton()
        }
    }
    
    var segmentSelected:Int = 0 {
        didSet{
            switch segmentSelected{
            case 1:
                print("Reminder")
            case 2:
                print("Intimation")
                
            default:
                print("Message")
                
            }
            
            
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Shared.colorWhite]
            lmmessageScontrol.setTitleTextAttributes(titleTextAttributes, for: .selected)
            lmmessageScontrol.selectedSegmentIndex = segmentSelected
            
        }
    }
    
    
    @IBOutlet weak var messageLbl: UILabel!{
        didSet{
            self.messageLbl.setTextColor(UIColor.clear)
        }
    }
    @IBOutlet weak var lmmessageScontrol: UISegmentedControl!
    @IBOutlet weak var messageBGView: UIView!
    
    lazy var keyboardManager = KeyboardHeightPublisher
    lazy var keyboardCancellable = Set<AnyCancellable>()
    lazy var msgCancellable = Set<AnyCancellable>()
    
    var messageText:String = ""
    
    let checkedMark = UIImage(named: "checkmark")
    let uncheckedMark = UIImage(named: "uncheckmark")
    
    var messageChecked = false
    var emailChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageTV.text = "Message"
        messageTV.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
        keyboardHandler()
        didMessageChange()
        
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageChecked = false
        emailChecked = false
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Shared.colorWhite]
        lmmessageScontrol.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
    
    fileprivate func didMessageChange() {
        messageTV.delegate = self
        textViewPublisher.sink { text in
            self.messageText = text
            self.messageLbl.text = self.messageText
            print(self.messageText)
        }.store(in: &msgCancellable)
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
    
    func resetMessage(){
        self.messageText = ""
        self.messageLbl.text = messageText
        messageTV.text = "Message"
        messageTV.textColor = UIColor.lightGray
        segmentSelected = 0
        messageChecked = false
        emailChecked = false

    }
    
    @IBAction func segmentClickAction(_ sender: UISegmentedControl) {
        
        segmentSelected = sender.selectedSegmentIndex
        
    }
    
    
    
    @IBAction func messageSendAction(_ sender: UIButton) {
        
        switch sender.tag{
        case 1: messageChecked = !messageChecked
                messageImgView.image = messageChecked == false ? uncheckedMark : checkedMark
            
        default:
            emailChecked = !emailChecked
            emailImgView.image = emailChecked == false ? uncheckedMark : checkedMark
        }
        
    }
    
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        
        resetMessage()
        self.dismiss(animated: true)
        
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        resetMessage()
        self.dismiss(animated: true)
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

extension LmListMessageVC : UITextViewDelegate{
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
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Message"
            textView.textColor = UIColor.lightGray
        }
    }
}

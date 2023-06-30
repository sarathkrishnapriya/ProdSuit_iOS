//
//  ReminderVC.swift
//  ProdSuit
//
//  Created by MacBook on 14/03/23.
//

import UIKit
import Combine
import EventKit

protocol ReminderDelegate:AnyObject{
    func updateReminder()
}

class ReminderVC: UIViewController {

    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var reminderView: UIView!
    
    
    @IBOutlet weak var timeTextField: ReminderTimeTF!
    @IBOutlet weak var dateTextField: ReminderTF!
    
    weak var reminderDelegate:ReminderDelegate?
    lazy var keyboardManager = KeyboardHeightPublisher
    var messageText:String = ""
    @Published var otherMessage : String = ""
    
    lazy var messageTextCancellable = Set<AnyCancellable>()
    lazy var keyBoardCancellabel = Set<AnyCancellable>()
    lazy var otherCancellable = Set<AnyCancellable>()
    
    let calendarImage:UIImage = UIImage(named: "calendar")!
    let timeImage:UIImage = UIImage(named: "time")!
    
    let datePicker = UIDatePicker()
    let store = EKEventStore()
    
    
    fileprivate func didMessageChange() {
        messageTextView.delegate = self
        textViewPublisher.sink { text in
            self.messageText = text
            self.messageLabel.text = self.messageText
            self.messageLabel.text = self.messageText
            print(self.messageText)
        }.store(in: &messageTextCancellable)
    }
    
    fileprivate func keyboardHeightGet() {
        keyboardManager.sink { height in
//            let keyboardY = self.view.frame.height - height
//            let textViewY = self.messageTextView.frame.origin.y + self.messageTextView.frame.height
//            let y = textViewY > keyboardY ? textViewY - keyboardY : 10
//            print("y difference \(y)")
            self.view.frame.origin.y = height == 0 ? 0 : -(height/2)
        }.store(in: &keyBoardCancellabel)
    }
    
    fileprivate func textFieldLeftImages() {
        timeTextField.leftImgView.image = timeImage
        dateTextField.leftImgView.image = calendarImage
    }
    
//    fileprivate func datePickerInitialise() {
//        self.view.addSubview(datePicker)
//        self.view.sendSubviewToBack(datePicker)
//        datePicker.translatesAutoresizingMaskIntoConstraints = false
//        datePicker.centerXAnchor.constraint(equalTo: reminderView.centerXAnchor).isActive = true
//        datePicker.centerYAnchor.constraint(equalTo: reminderView.centerYAnchor).isActive = true
//        datePicker.datePickerMode = .date
//
//        if #available(iOS 13.4, *) {
//            datePicker.preferredDatePickerStyle = .compact
//        } else {
//            // Fallback on earlier versions
//
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        switch EKEventStore.authorizationStatus(for: EKEntityType.event){
        
            
        case .notDetermined:
            
            store.requestAccess(to: EKEntityType.event) { granted, error in
                if (granted == true) && (error == nil){
                    print("granted")
                    
                }else{
                    self.popupAlert(title: "Calendar", message: "Allow ProdSuite to access calendar for set reminder note", actionTitles: [closeTitle], actions: [{action1 in
                        print("close calender notification")
                    },nil])
                }
            }
            
        case .restricted:
            print("no access")
        case .denied:
            
            print("no access")
            
        case .authorized:
            print("access")
        @unknown default:
            print("ek")
        }
       
        //datePickerInitialise()
        messageTextView.text = "Message"
        messageTextView.textColor = UIColor.lightGray
        
        textFieldLeftImages()
        
        keyboardHeightGet()
        didMessageChange()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if otherMessage != ""{
            self.messageTextView.textColor = UIColor.black
            self.$otherMessage
                .sink { text in
                    self.messageText = text
                    self.messageLabel.text = self.messageText
                    self.messageTextView.text = self.messageText
                }.store(in: &otherCancellable)
                
        }
    }
    
    @IBAction func dateButtonAction(_ sender: UIButton) {
        
        //self.view.bringSubviewToFront(datePicker)
    }
    
    @IBAction func timeButtonAction(_ sender: UIButton) {
    }
    
    fileprivate func resetReminder() {
        self.messageText = ""
        let dashboardpage = AppVC.Shared.DashboardPage
        dashboardpage.resetTabbar()
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            
            self.resetReminder()
        }
        
    }
    
    
    fileprivate func createReminder(title:String="ProdSuite",Message:String) {
        
        DispatchQueue.main.async {
            let reminder = EKEvent(eventStore: self.store)
        
        reminder.title = title
            
        reminder.notes = Message
            reminder.calendar = self.store.defaultCalendarForNewEvents
        
            let date = DateTimeModel.shared.combineDateAndTime(date: self.dateTextField.text!, time: self.timeTextField.text!)
            let alarm = EKAlarm(absoluteDate: date.addingTimeInterval(2 * 60))
            
            reminder.addAlarm(alarm)
            
            reminder.startDate = date
            reminder.endDate = date.addingTimeInterval(60)
            
            
        
        
    
        do {
            
            try self.store.save(reminder, span: .thisEvent, commit: true)
            
        } catch let error {
            print("Failed to save reminder with error: \(error)")
            
        }
      }
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        
        createReminder(Message: self.messageText)
        

        self.dismiss(animated: true) {
            self.reminderDelegate?.updateReminder()
            self.messageText = ""
            self.messageLabel.text = ""
            self.messageTextView.text = ""
            
            let dashboardpage = AppVC.Shared.DashboardPage
            dashboardpage.resetTabbar()
        }
        

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == bgView{
            self.dismiss(animated: true)
            self.resetReminder()
        }
        if touches.first?.view == reminderView{
            self.view.endEditing(true)
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

extension LManagementCategoryListVC:ReminderDelegate{
    func updateReminder() {
        self.reminderBellReset()
    }
    
    
}



extension ReminderVC : UITextViewDelegate{
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

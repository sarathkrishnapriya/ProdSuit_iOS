//
//  LoginVC.swift
//  ProdSuit
//
//  Created by MacBook on 16/02/23.
//

import UIKit
import Combine

class LoginVC: UIViewController {
    
    
  

    @IBOutlet weak var mobileNumberTF: LoginMobileNumTextField!
    
    lazy var parserViewModel : APIParserManager = APIParserManager()
    
    lazy var loginValidationVM : LoginValidationModel = LoginValidationModel(brockenRules: [])
    
    lazy var keyboardManager = KeyboardHeightPublisher
    
    var loginVm : LoginViewModel!
    
    var mobileRightViewHide = true
    var successErrorView : SuccessErrorView!
    var cancellables = Set<AnyCancellable>()
    
    // location service
    
    var deviceLocationService = DeviceLocationService.Shared
    var coordinates: (lat: Double, lon: Double) = (0, 0)
    lazy var locationtokens = Set<AnyCancellable>()
    
    
    fileprivate func keyboardHandler() {
        keyboardManager
          
          .sink { completed in
            print(completed)
        } receiveValue: { height in
            print(height)
            
            self.view.frame.origin.y = height == 0 ? 0 : -(height/4)
            
        }.store(in: &cancellables)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mobileNumberTF.delegate = self
        mobileNumberTF.want_hide = mobileRightViewHide
        self.successErrorView = SuccessErrorView(bgView: self.view)
        self.loginVm = LoginViewModel(controller: self)
        self.mobileNumberTF.text = ""
        locationCoordinateUpdates()
        deniedLocationAccess()
        deviceLocationService.requestLocationUpdates()
        
        
        //let hello = instanceOfEncryptionPost.encryptUseDES("hello", key: "PssErp22")
        
        keyboardHandler()
        

    }
    
    func locationCoordinateUpdates() {
        deviceLocationService.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Handle \(completion) for error and finished subscription.")
            } receiveValue: { coordinates in
                //print("location coordinates:\(coordinates.latitude)= \(coordinates.longitude)")
                self.coordinates = (coordinates.latitude, coordinates.longitude)
                //print(self.allControllers)
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
    

    
    @IBAction func continueAction(_ sender: UIButton) {
        
        sender.opacityAnimation()
        self.view.dismissKeyboard()
        self.loginValidationVM.mobileNumber = self.mobileNumberTF.text ?? ""
        
        if !loginValidationVM.isValid{
            
            //print("success")
            
            sender.isEnabled = false
            self.loginVm.userLoginValidation(mobile_Number: self.loginValidationVM.mobileNumber, sender: sender)
            
            
        }else{
            
            mobileNumberTF.want_hide = false
            self.successErrorView.showMessage(msg: loginValidationVM.brockenRules.first?.message ?? "",style: .failed)
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    deinit {
        
        mobileNumberTF.text = ""
        
    }

}

extension LoginVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,   replacementString string: String) -> Bool {
        
        let characterCount = textField.text?.count ?? 0
        
        if(range.length + range.location > characterCount){
            return false
        }
        
        let newLength = characterCount + string.count - range.length
        var maxLength = 0
        if textField.isEqual(mobileNumberTF){
            maxLength = 11
            
        }
        
            mobileNumberTF.want_hide = true
        
       return newLength <= maxLength
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == mobileNumberTF{
            if (((textField.text!.count ) != 0) || textField.text!.count < 10) {
                print("invalid mobile number")
             }
          }
       }
    }
 }

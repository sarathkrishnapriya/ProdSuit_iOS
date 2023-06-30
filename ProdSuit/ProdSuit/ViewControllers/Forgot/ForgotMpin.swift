//
//  ForgorMpin.swift
//  ProdSuit
//
//  Created by MacBook on 21/02/23.
//

import UIKit
import Combine

class ForgotMpin: UIViewController{
    
    var mobileNumberText = ""
    let textLimit = 10
    lazy var keyboardManager = KeyboardHeightPublisher
    var cancellables = Set<AnyCancellable>()
    var forgotVCVm : ForgotVCViewModel!
    lazy var loginValidationVM : LoginValidationModel = LoginValidationModel(brockenRules: [])
    var successErrorView : SuccessErrorView!
    
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var forgotView: UIView!
    
    fileprivate func keyboardHandler() {
        keyboardManager.sink { height in
            self.view.frame.origin.y = height == 0 ? 0 : -(height/4)
            print(height)
        }.store(in: &cancellables)
    }
    
    fileprivate func mobileNumberHandler() {
       
        mobileTF.delegate = self
        
        textFieldPublisher.sink { [self] text in
            
            mobileNumberText = text
            print(mobileNumberText)
            
        }.store(in: &cancellables)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        keyboardHandler()
        self.forgotVCVm = ForgotVCViewModel(controller: self)
        self.successErrorView = SuccessErrorView(bgView: self.forgotView)
        mobileNumberHandler()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.first?.view == bgView{
            
            self.view.dismissKeyboard()
            self.dismiss(animated: true)
            
        }
        
        if touches.first?.view == forgotView.subviews.first{
            self.view.dismissKeyboard()
        }
        
    }
    
    
    @IBAction func verifyButtonAction(_ sender: UIButton) {
        
    
        loginValidationVM.mobileNumber = mobileNumberText
        
        if !loginValidationVM.isValid{
            self.view.dismissKeyboard()
             print("success")
            self.view.isUserInteractionEnabled = false
            self.forgotVCVm.forgotMpinApiCall(mobile_number: loginValidationVM.mobileNumber)
            
        }else{
            self.view.dismissKeyboard()
            self.successErrorView.showMessage(msg: loginValidationVM.brockenRules.first?.message ?? "",style: .failed)
        }
        
        
    }
    

}


extension ForgotMpin : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString : NSString = mobileNumberText as NSString
        let newString  : NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= mobileNumberMaxLength
    }
}

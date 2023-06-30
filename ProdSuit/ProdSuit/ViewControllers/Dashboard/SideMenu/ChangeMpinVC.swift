//
//  ChangeMpinVC.swift
//  ProdSuit
//
//  Created by MacBook on 17/03/23.
//

import UIKit
import Combine

class ChangeMpinVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var currentPasswordTextField: LeftViewTextField!
    @IBOutlet weak var newPasswordTextField: LeftViewTextField!
    @IBOutlet weak var confirmPasswordTextField: LeftViewTextField!
    
    var currentMpinString : String = ""
    var newMpinString : String = ""
    var confirmMpinString : String = ""
    
    var successErrorView : SuccessErrorView!
    
    var changeMPINVM : ChangeMpinVCViewModel!
    lazy var validator = ChangeMpinValidateViewModel()
    lazy var changeMPINValidatorVm : ChangeMPINValidateVM = ChangeMPINValidateVM(brockenRules: [])
    
    var isKeyboardShow = false
    lazy var keyboardManager = KeyboardHeightPublisher
    lazy var keyboardCancellable = Set<AnyCancellable>()
    weak var delegate : ChangeMPINProtocol?
    
    fileprivate func keyboardHandler() {
        keyboardManager.sink { height in
            self.view.frame.origin.y = height == 0 ? 0 : -(height/3)
            self.isKeyboardShow = height == 0 ? false : true
            print(height)
        }.store(in: &keyboardCancellable)
    }
    
    fileprivate func textfieldDelegateCall() {
        self.currentPasswordTextField.delegate = self
        self.newPasswordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeMPINVM = ChangeMpinVCViewModel(controller: self)
        self.successErrorView = SuccessErrorView(bgView: self.bottomView)
        textfieldDelegateCall()

        keyboardHandler()
        
        
        // Do any additional setup after loading the view.
    }
    
     func resetMPIN() {
        self.currentPasswordTextField.text = ""
        self.newPasswordTextField.text = ""
        self.confirmPasswordTextField.text = ""
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        
        resetMPIN()
        
        
    }
    
    fileprivate func assignValidatorValues() {
        changeMPINValidatorVm.currentMPIN = self.currentPasswordTextField.text ?? ""
        
        changeMPINValidatorVm.newMPIN = self.newPasswordTextField.text ?? ""
        
        changeMPINValidatorVm.confirmMPIN = self.confirmPasswordTextField.text ?? ""
        
        validator.newMpin = changeMPINValidatorVm.newMPIN
        validator.confirmMpin = changeMPINValidatorVm.confirmMPIN
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        
        assignValidatorValues()

        
        if !changeMPINValidatorVm.isValid{
            
             validator.checkMpinMatched()
            
            if validator.isMatched == true{
                
                self.changeMPINVM.changeMPIN_API_Call(current: self.currentPasswordTextField.text!, new: self.newPasswordTextField.text!, changeMPINVC: self)
                
            }else{
                
                self.successErrorView.showMessage(msg: mIsmatchMPINErrorMessage,style: .failed)
                
            }
                
            validator.matchPasswordCancellable.dispose()
            
            
        }else{
            
            //print("invalide mpin: \(changeMPINValidatorVm.brockenRules.first!.propertyName)\(changeMPINValidatorVm.brockenRules.first!.message)")
            self.successErrorView.showMessage(msg: "\(changeMPINValidatorVm.brockenRules.first!.propertyName)\(changeMPINValidatorVm.brockenRules.first!.message)",style: .failed)
        }
        
        

        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.first?.view == bgView && isKeyboardShow == false{
            print("keyboard:\(isKeyboardShow)")
            self.dismiss(animated: true)
        }else{
            self.view.endEditing(true)
        }
        
        if touches.first?.view  == topView{
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

extension ChangeMpinVC:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField{
        
        case newPasswordTextField:
            let currentString: NSString = textField.text! as NSString
            let newString : NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            newMpinString = newString as String
            print("newMpin:\(newMpinString)")
            return newString.length <= mpinCount
        case confirmPasswordTextField:
            let currentString: NSString = textField.text! as NSString
            let newString : NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            confirmMpinString = newString as String
            print("confirmMpin:\(confirmMpinString)")
            return newString.length <= mpinCount
        
        default:
            
            let currentString: NSString = textField.text! as NSString
            let newString : NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            currentMpinString = newString as String
            print("currentMpin:\(currentMpinString)")
            return newString.length <= mpinCount
            
        }
    }
    
}

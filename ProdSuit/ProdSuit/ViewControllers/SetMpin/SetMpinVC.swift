//
//  SetMpinVC.swift
//  ProdSuit
//
//  Created by MacBook on 20/02/23.
//

import UIKit

class SetMpinVC: UIViewController {
    
    @IBOutlet weak var tfOne: UITextField!
    @IBOutlet weak var tfTwo: UITextField!
    @IBOutlet weak var tfThree: UITextField!
    @IBOutlet weak var tfFour: UITextField!
    @IBOutlet weak var tfFive: UITextField!
    @IBOutlet weak var tfSix: UITextField!
    
   
    
    @IBOutlet weak var otpOpenCloseImgView: UIImageView!
    
    var tfList:[UITextField] = [UITextField]()
   
    
    var text = ""
    var token : String = ""
    var fk_employee : String = ""
    
    var maskedImage = UIImage(named: "eye_hid")
    var unmaskedImage = UIImage(named: "eye_view")
    var userdetailsModelInfo : UserLoginDetailsModel!

    var maskedText = false
    var otpArray : [String] = []
    {
        didSet{
            if otpArray.count == 6{
                print("success")
                
                //self.moveToNextVc(nextController: AppVC.Shared.MpinPage)
                
                print("next page after set mpin")
                
                
            }else{
                print("failed")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.otpArray = []
        tfList = [tfOne,tfTwo,tfThree,tfFour,tfFive,tfSix]
        self.otpOpenCloseImgView.image = maskedImage
        print("set Mpin token==  \(token)")
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func otpKeyboardAction(_ sender: UIButton) {
       
        
        
        otpArray.append("\(sender.tag)")
        
        if otpArray.count > 6{
            otpArray.removeLast()
        }
        text = ""
        
        otpArray.map { $0
            text += $0
        }
        
        otpArray.enumerated().forEach { index,value in
            let textField = self.tfList[index]
            textField.text = maskedText == true ?  textField.text?.maskedString : value
    
            
        }
        
        
        print(text)
        print(otpArray)
        if let setMpinVM = SetMpinVCViewModel(controller: self) as? SetMpinVCViewModel{
            if text.count == loginMpin_OtpCount{
               
                setMpinVM.setMpinOtpApiCall(token: token, mpin: text, fk_employee: fk_employee,userdetailInfo: userdetailsModelInfo)
            }
        }
        
        
    }
    
    
    @IBAction func otpShowAction(_ sender: UIButton) {
        
        maskedText = !maskedText
        
        self.otpOpenCloseImgView.image = maskedText == false ? maskedImage : unmaskedImage
        
        self.otpArray.enumerated().forEach{ index,value in
            
            self.tfList[index].text = maskedText == true ?  self.tfList[index].text?.maskedString : value
            
        }
    }
    
    @IBAction func otpRemoveAction(_ sender: UIButton) {
        
        if otpArray.count > 0{
        otpArray.removeLast()
        }
        
        
        self.tfList[otpArray.count].text = ""
        
        text = ""
        otpArray.map { $0
            text += $0
        }
        
        print(text)
        print(otpArray)
    }
    
    @IBAction func otpFieldDidClick(_ sender: UIButton) {
        
        
        
    }
    
    deinit {
        
        resetPage()
        
    }
    
    func resetPage(){
        self.tfList.forEach { textfield in
            textfield.text = ""
        }
        self.otpArray = []
        text = ""
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

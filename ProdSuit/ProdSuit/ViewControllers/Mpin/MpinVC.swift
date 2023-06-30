//
//  MpinVC.swift
//  ProdSuit
//
//  Created by MacBook on 21/02/23.
//

import UIKit
import Combine

class MpinVC: UIViewController {
    
    @IBOutlet weak var forgotBGView: MpinStackBGView!
    @IBOutlet weak var logoutBGView: MpinStackBGView!
    
    @IBOutlet weak var tfOne: UITextField!
    @IBOutlet weak var tfTwo: UITextField!
    @IBOutlet weak var tfThree: UITextField!
    @IBOutlet weak var tfFour: UITextField!
    @IBOutlet weak var tfFive: UITextField!
    @IBOutlet weak var tfSix: UITextField!
    
    var loginButtonPressedSubject = PassthroughSubject<Void,Never>()
    var tfList:[UITextField] = [UITextField]()
    var preference = SharedPreference.Shared
    
    
    @IBOutlet weak var otpOpenCloseImgView: UIImageView!
    
    var text = ""
    
    private var cancelBag = Set<AnyCancellable>()
    
    var popupView : PopUpView!
    
    var maskedImage = UIImage(named: "eye_hid")
    var unmaskedImage = UIImage(named: "eye_view")
   // lazy var mpinVCVm : MpinVCViewModel = MpinVCViewModel(controller: self)
    var maskedText = false
    var otpArray : [String] = []
    {
        didSet{
            if otpArray.count == 6{
            
//                let dashboardVC = AppVC.Shared.DashboardPage
//                dashboardVC.DashboardNavController = self.navigationController
//                self.moveToNextVc(nextController: dashboardVC)
                print("go to home page")
                
            }else{
                print("failed")
            }
        }
    }
    

    fileprivate func logoutHandler() {
        loginButtonPressedSubject
        
            .sink { completion in
                switch completion{
                case.finished:
                    print("complete")
                case.failure(_):
                    print("error")
                }
                print("completed action")
            } receiveValue: { result in
                self.popupView.successHandler = { [weak self] in
                    UIView.animate(withDuration: 1, delay: 0, options: [.transitionFlipFromRight]) {
                        self?.popupView.removePopUPView()
                        
                    } completion: { completed in
                        //print("move to root view controlller")
                        self?.preference.logOut()
                    }
                    
                }
            }.store(in: &cancelBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.otpArray = []
        tfList = [tfOne,tfTwo,tfThree,tfFour,tfFive,tfSix]
        self.otpOpenCloseImgView.image = maskedImage
        
       // mpinVCVm = MpinVCViewModel(controller: self)
        
        popupView = PopUpView(homeView: self.view,btnCount: 2)
        print("mpin saved token : \(preference.User_Token)")
        
        logoutHandler()

        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetPage()
    }
    

    @IBAction func forgotButtonAction(_ sender: UIButton) {
        
        self.forgotBGView.opacityAnimation()
        let forgotPopUPVC = AppVC.Shared.ForgotMpinPage
        forgotPopUPVC.modalTransitionStyle = .crossDissolve
        forgotPopUPVC.modalPresentationStyle = .overCurrentContext
        self.present(forgotPopUPVC, animated: true)
        
        
    }
    
    
    @IBAction func logOutButtonAction(_ sender: UIButton) {
        
        
        loginButtonPressedSubject.send(logoutActionMethod())
        
        
        self.logoutBGView.opacityAnimations()
        self.popupView.showPopUpView()
        
        
        
        
        
    }
    
    func logoutActionMethod(){
       
        UIView.animate(withDuration: 2, delay: 0) {
            self.popupView.titile = logoutTitle
            self.popupView.action_btn_name = yesTitle
            self.popupView.cancel_btn_name = no_cancel_title
            self.popupView.info = logoutMessage
           
        }
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
        if text.count == loginMpin_OtpCount{
            if let mpinVCVm = MpinVCViewModel(controller: self) as? MpinVCViewModel{
               mpinVCVm.verifyMpinApiCall(token: preference.User_Token, fk_employee: "\(preference.User_Fk_Employee)", mpin: text)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == popupView.bgView{
            
            popupView.removePopUPView()
        }
    }
    
    deinit {
        
        resetPage()
        
    }
    
    func resetPage(){
        self.tfList.forEach { textfield in
            textfield.text = ""
        }
        
        otpArray = []
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




//
//  LoginCustomView.swift
//  ProdSuit
//
//  Created by MacBook on 16/02/23.
//

import Foundation
import UIKit
import Combine



class LoginTextLabel:UILabel{
    
    override func awakeFromNib() {
        
        self.textColor = AppColor.Shared.colorWhite
        self.font = AppFont.medium.size(15)
        self.text = login_topview_details
        self.setLineHeight(lineHeight: 0.5)
        self.textAlignment = .center
        self.minimumScaleFactor = 0.5
        
        self.adjustsFontSizeToFitWidth = true
        
    }
}

class LoginButton:UIButton{
    
    //let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func awakeFromNib() {
        self.titleLabel?.textColor = AppColor.Shared.colorWhite
        self.titleLabel?.text =  login_button_name
        self.titleLabel?.font = AppFont.semiBold.size(15)
        self.backgroundColor = AppColor.Shared.colorPrimaryDark
        self.setCornerRadius(size: self.frame.height/2)
        
        
    }
}

class LoginMobileNumTextField:UITextField{
    
    private let leftViewTF : MobileNumberLeftView = {
        
        let view = MobileNumberLeftView()
        
        return view
    }()
    
    private let rightViewTF : MobileNumberRightView = {
        
        let view = MobileNumberRightView()
        
        return view
    }()
    
    var want_hide = false {
        didSet{
            
            self.rightView = want_hide == false ? rightViewTF : nil
            self.rightViewMode = want_hide == false ? .always : .never
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
       }
    
    override func awakeFromNib() {
        
        self.setCornerRadius(size: 5)
        self.setBorder(width: 0.75)
        self.keyboardType = .numberPad
        self.textColor = AppColor.Shared.colorPrimaryDark
        self.tintColor = AppColor.Shared.colorPrimaryDark
        self.font = AppFonts.Shared.SemiBold.withSize(18)
        self.placeholder = "Mobile Number"
        
        
        self.leftView = leftViewTF
        self.leftViewMode = .always
        
        self.rightView = rightViewTF
        self.rightViewMode = .always
        setupView()
    }
    
    func setupView(){
    
        
        self.leftViewTF.translatesAutoresizingMaskIntoConstraints = false
       
        var Constraint = [NSLayoutConstraint]()
        
        Constraint.append(leftViewTF.leadingAnchor.constraint(equalTo: self.leftView!.leadingAnchor, constant: 0))
        
        Constraint.append(leftViewTF.topAnchor.constraint(equalTo: self.leftView!.topAnchor, constant: 0))
        Constraint.append(leftViewTF.bottomAnchor.constraint(equalTo: self.leftView!.bottomAnchor, constant: 0))
        
        Constraint.append(leftViewTF.widthAnchor.constraint(equalToConstant: 91))
        Constraint.append(leftViewTF.heightAnchor.constraint(equalToConstant: 45))
        NSLayoutConstraint.activate(Constraint)
        
        
        
        
        
        self.rightViewTF.translatesAutoresizingMaskIntoConstraints = false
        
        var rightConstraint = [NSLayoutConstraint]()
        
        rightConstraint.append(rightViewTF.topAnchor.constraint(equalTo: self.rightView!.topAnchor, constant: 0))
        rightConstraint.append(rightViewTF.bottomAnchor.constraint(equalTo: self.rightView!.bottomAnchor, constant: 0))
        
        rightConstraint.append(rightViewTF.rightAnchor.constraint(equalTo: self.rightView!.rightAnchor, constant: 0))
        
        rightConstraint.append(rightViewTF.widthAnchor.constraint(equalToConstant: 50))
        
        rightConstraint.append(rightViewTF.heightAnchor.constraint(equalToConstant: 45))
        
        NSLayoutConstraint.activate(rightConstraint)
        
    }
    
}

class MobileNumberValidateViewModel{
    
    func validate(value: String,count:Int) -> Bool {
        let RegEx = "d{\(count)}$"
        let PHONE_REGEX = RegEx
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
       }
}

class MobileNumberLeftView : UIView{
    
    lazy var stackView : UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [imageView,label])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.spacing = 1
        
        return stackView
    }()
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "india")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "+91"
        label.font =  AppFonts.Shared.SemiBold.withSize(18)
        label.textColor = AppColor.Shared.colorPrimaryDark
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
        self.addSubview(stackView)
        //self.backgroundColor = AppColor.Shared.colorPrimaryDark
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        var stackViewConstraint = [NSLayoutConstraint]()
        
        stackViewConstraint.append(stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5))
        
        stackViewConstraint.append(stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5))
        stackViewConstraint.append(stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5))
        
        stackViewConstraint.append(stackView.widthAnchor.constraint(equalToConstant: 86))
        stackViewConstraint.append(stackView.heightAnchor.constraint(equalToConstant: 35))
        NSLayoutConstraint.activate(stackViewConstraint)
        
        
    }
    
}

class MobileNumberRightView:UIView{
    
    lazy var bgView : UIStackView = {
        
        let bgView = UIStackView(arrangedSubviews: [imageView])
        bgView.axis = .horizontal
        bgView.distribution = .fillEqually
        
        return bgView
    }()
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "warning")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
        
        self.addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        //self.backgroundColor = AppColor.Shared.purple_700
        
        var bgViewConstraint = [NSLayoutConstraint]()
        
        bgViewConstraint.append(bgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10))
        bgViewConstraint.append(bgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8))
        bgViewConstraint.append(bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10))
        
        bgViewConstraint.append(bgView.widthAnchor.constraint(equalToConstant: 40))
        
        NSLayoutConstraint.activate(bgViewConstraint)
    }
}


class SuccessErrorView{
    
    var bottomConstraint = NSLayoutConstraint()
    var leadingConstraint = NSLayoutConstraint()
    var trailingConstraint = NSLayoutConstraint()
    var superViews = UIView()
    
    lazy var msgLabel : UILabel = {
        
        let messageLbl = PaddingLabel()
        messageLbl.setCornerRadius(size: 6)
        messageLbl.setLineHeight(lineHeight: 0.5)
        messageLbl.text = "No Internet"
        messageLbl.numberOfLines = 0
        messageLbl.textAlignment = .center
        messageLbl.textColor = AppColor.Shared.colorWhite
        messageLbl.font = AppFont.medium.size(14)
        
        return messageLbl
    }()
    
    init(bgView:UIView) {
        superViews = bgView
        
    }
    
    
    func commonInit(msg:String=""){
        
        superViews.addSubview(msgLabel)
        superViews.bringSubviewToFront(msgLabel)
        msgLabel.translatesAutoresizingMaskIntoConstraints = false
        msgLabel.text = msg
        
        
        bottomConstraint = superViews.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: msgLabel.bottomAnchor, constant: 20)
        
        leadingConstraint = superViews.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: msgLabel.leadingAnchor, constant: -20)
        
        trailingConstraint = superViews.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: msgLabel.trailingAnchor, constant: 20)
        
        NSLayoutConstraint.activate([leadingConstraint,trailingConstraint,bottomConstraint])
        
    }
    
   
    
    func removeBgView(){
        
        bottomConstraint.constant = -100
        
        UIView.animate(withDuration: 0.3) {
            self.superViews.layoutIfNeeded()
        } completion: { [self] completion in
            msgLabel.text = ""
            msgLabel.removeFromSuperview()
            msgLabel.translatesAutoresizingMaskIntoConstraints = true
            NSLayoutConstraint.deactivate([leadingConstraint,trailingConstraint,bottomConstraint])
        }

        
    }
    
    func showMessage(msg:String,style:ResponseStyle = .success,time:TimeInterval = 2){
        
        switch style {
        case .success:
            msgLabel.backgroundColor = AppColor.Shared.colorPrimary
        case .failed:
            msgLabel.backgroundColor = AppColor.Shared.color_error
        case .warning:
            msgLabel.backgroundColor = AppColor.Shared.color_warning
        }
        
        commonInit(msg: msg)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            
            self.removeBgView()
            
        }
        
    }
    
}


class PaddingLabel: UILabel {

    var topInset: CGFloat = 8.0
    var bottomInset: CGFloat = 8.0
    var leftInset: CGFloat = 8.0
    var rightInset: CGFloat = 8.0

   override func drawText(in rect: CGRect) {
      let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
       super.drawText(in: rect.inset(by: insets))
   }

   override var intrinsicContentSize: CGSize {
      get {
         var contentSize = super.intrinsicContentSize
         contentSize.height += topInset + bottomInset
         contentSize.width += leftInset + rightInset
         return contentSize
      }
   }
}

enum ResponseStyle:String{
    case success
    case failed
    case warning
    
}


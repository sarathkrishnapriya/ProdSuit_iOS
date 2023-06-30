//
//  MpinCustomViews.swift
//  ProdSuit
//
//  Created by MacBook on 21/02/23.
//

import Foundation
import UIKit

class MpinStackBGView:UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func opacityAnimations(fromValue:Float=1,toValue:Float=0.25,duration:CFTimeInterval=0.5){
        
        self.opacityAnimation(fromValue: fromValue, toValue: toValue, duration: duration)
        
    }
    
    
}

@objc protocol PopUpButtonActionDelegate:AnyObject{
    @objc func successButtonPressed()
    
}

class PopUpView:UIView{
    
    var bbCount : Int = 0
    var titile : String = ""
    var action_btn_name:String = "Yes"
    var cancel_btn_name:String = "No"
    var info:String = ""
    var bgView = UIView()
    var homeView = UIView()
    var bgconStraint=[NSLayoutConstraint]()
    var stackViewConstraint = [NSLayoutConstraint]()
    weak var delegate:PopUpButtonActionDelegate?
    var dismissActionEnable = false
    var successHandler:(()->Void)?
    var dismissHandler:(()->Void)?
    // successHandler : (()->Void)?
    
    
    
    lazy var stackView : UIStackView = {
      
        let stackview = UIStackView(arrangedSubviews: [titleLabel,messageLabel,bottomStackView])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fill
        stackview.axis = .vertical
        stackview.backgroundColor = AppColor.Shared.colorWhite
        stackview.setCornerRadius(size: 5)
        stackview.layoutMargins = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.spacing = 16
        
        return stackview
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = titile
        label.textAlignment = .center
        label.font = AppFonts.Shared.SemiBold.withSize(15)
        label.textColor = AppColor.Shared.colorPrimaryDark
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var messageLabel : UILabel = {
        let label = UILabel()
        label.text = info
        label.textAlignment = .center
        
        label.font = AppFonts.Shared.Regular.withSize(14)
        label.textColor = AppColor.Shared.colorPrimaryDark
        label.numberOfLines = 0
        return label
    }()
    
    lazy var bottomStackView : UIStackView = {
        
        let stackview = UIStackView(arrangedSubviews: bbCount == 1 ? [cancelButton] : [cancelButton,actionButton])
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
            
        return stackview
    }()
    
    lazy var actionButton:UIButton = {
        let button = UIButton()
        button.setTitle(action_btn_name, for: .normal)
        button.setCornerRadius(size: 5)
        button.setTitleColor(AppColor.Shared.colorWhite, for: .normal)
        button.titleLabel?.font = AppFonts.Shared.Medium.withSize(14)
        button.backgroundColor = AppColor.Shared.colorPrimaryDark
        button.addTarget(self, action: #selector(actionButtonMethod), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var cancelButton:UIButton = {
        let button = UIButton()
        
       
        button.setTitleColor(AppColor.Shared.colorWhite, for: .normal)
        button.titleLabel?.font = AppFonts.Shared.Medium.withSize(14)
        button.backgroundColor = AppColor.Shared.colorPrimaryDark
        button.setCornerRadius(size: 5)
        button.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        button.setTitle(cancel_btn_name, for: .normal)
        return button
    }()
    
    
    init(homeView:UIView,btnCount:Int=1) {
        self.homeView = homeView
        self.bbCount = btnCount
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
   
    
   
    @objc func actionButtonMethod() {
        
        self.successHandler?()
    }
    
    @objc  func dismissAction(){
        
        self.removePopUPView()
        
        do  {
            if dismissActionEnable == true{
               self.dismissHandler?()
            }
        }
    }
    
    
    func setup(){
        
        bgView.translatesAutoresizingMaskIntoConstraints = false
        homeView.addSubview(bgView)
        bgView.addSubview(stackView)
        
        bgView.backgroundColor = AppColor.Shared.coloBlack.withAlphaComponent(0.55)
        bgconStraint.append(bgView.topAnchor.constraint(equalTo: homeView.topAnchor, constant: 0))
        bgconStraint.append(bgView.bottomAnchor.constraint(equalTo: homeView.bottomAnchor, constant: 0))
        bgconStraint.append(bgView.leadingAnchor.constraint(equalTo: homeView.leadingAnchor, constant: 0))
        bgconStraint.append(bgView.trailingAnchor.constraint(equalTo: homeView.trailingAnchor, constant: 0))
        
        NSLayoutConstraint.activate(bgconStraint)
        
        stackViewConstraint.append(stackView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor))
        stackViewConstraint.append(stackView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor))
        
        
        stackViewConstraint.append(stackView.widthAnchor.constraint(equalToConstant: 300))
        
        var titleConstraint = [NSLayoutConstraint]()
        titleConstraint.append(titleLabel.heightAnchor.constraint(equalToConstant: 30))
//        titleConstraint.append(titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10))
//        titleConstraint.append(titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10))
        
        //titleConstraint.append(titleLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 5))
        
        
        var bottomStackConstriant = [NSLayoutConstraint]()
       
//        bottomStackConstriant.append(bottomStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5))
//        bottomStackConstriant.append(bottomStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5))
        bottomStackConstriant.append(bottomStackView.heightAnchor.constraint(equalToConstant: 40))
        
        NSLayoutConstraint.activate(titleConstraint)
        
        NSLayoutConstraint.activate(bottomStackConstriant)
        
        NSLayoutConstraint.activate(stackViewConstraint)
        
       
        
    }
    
    func showPopUpView(){
        setup()
    }
    
    func removePopUPView(){
        self.bgView.removeFromSuperview()
        bgView.translatesAutoresizingMaskIntoConstraints = true
       
        //NSLayoutConstraint.deactivate(stackViewConstraint)
        NSLayoutConstraint.deactivate(bgconStraint)
    }
    
   
    
}

//
//  LeadGenerationCustomView.swift
//  ProdSuit
//
//  Created by MacBook on 06/04/23.
//

import Foundation
import UIKit

protocol LeadDetailsDateDelegate:AnyObject{
    func getDate(date:String)
}

class LeadDateTextField : UITextField {

//override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
//    let offset = 5
//    let width  = 20
//    let height = width
//    let x = Int(bounds.width) - width - offset
//    let y = offset
//    let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
//    return rightViewBounds
//}
    
    weak var leadDateDelegate : LeadDetailsDateDelegate?
    
    lazy var dateimageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = calendarImage
        return imageview
    }()
    
    let calendarImage:UIImage = UIImage(named: "leadcalendar")!
    let datePickerView = UIDatePicker()
    
    override func awakeFromNib() {
        
        self.leftView = dateimageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.text = DateTimeModel.shared.stringDateFromDate(Date())
        initializeDate()
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    func initializeDate(){
        datePickerView.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .compact
        } else {
            // Fallback on earlier versions
        }
        self.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
    
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {

            let dateFormatter = DateFormatter()

            dateFormatter.dateStyle = DateFormatter.Style.medium

            dateFormatter.timeStyle = DateFormatter.Style.none

           self.text = DateTimeModel.shared.stringDateFromDate(sender.date)
        self.leadDateDelegate?.getDate(date: DateTimeModel.shared.stringDateFromDate(sender.date))
           self.resignFirstResponder()

        }
    
}

let rightDownImage = UIImage(named: "down")
let searchImage = UIImage(named: "search")

class LeadDetailsNameTextField:UITextField{
    
    var leadNameSelectionButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let image:UIImage = UIImage(named: "leaduser")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.inputView = UIView()
        self.textColor = AppColor.Shared.greyText
       
        
        self.rightView = rightSideImageView
        
        self.rightViewMode = .always
        setupButton()
    }
    
    func setupButton(){
        
        self.addSubview(leadNameSelectionButton)
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(leadNameSelectionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        buttonConstraint.append(leadNameSelectionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(leadNameSelectionButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(leadNameSelectionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
    
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}

class LeadDetailSourceField:UITextField{
    
   lazy var sourceButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    let image:UIImage = UIImage(named: "magnet")!
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.inputView = UIView()
        self.customPlaceholder(color:AppColor.Shared.greyText,text: leadSourcePlaceholderText)
        
        self.rightView = rightSideImageView
        self.rightViewMode = .always
        setupButton()
        
        
    }
    
    func setupButton(){
        
        self.addSubview(sourceButton)
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(sourceButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        buttonConstraint.append(sourceButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(sourceButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(sourceButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}

class LeadDetailSourceDetailsField:UITextField{
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    let image:UIImage = UIImage(named: "magnet")!
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
   lazy var sourceDetailsButton:UIButton={
        let button = UIButton()
        button.titleLabel?.text = ""
        //button.backgroundColor = AppColor.Shared.colorPrimary
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
       
        self.customPlaceholder(color:AppColor.Shared.greyText,text: leadSourcePlaceholderText + " Name")
        self.tintColor = AppColor.Shared.greyText
        self.rightView = rightSideImageView
        self.rightViewMode = .always
        setupButton()
        
    }
    
    
    
    func setupButton(){
        
        self.addSubview(sourceDetailsButton)
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(sourceDetailsButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        buttonConstraint.append(sourceDetailsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(sourceDetailsButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(sourceDetailsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}

class LeadDetailSubmediaField:UITextField{
    
   lazy var mediaButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    let image:UIImage = UIImage(named: "magnet")!
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.inputView = UIView()
        self.customPlaceholder(color:AppColor.Shared.greyText,text: leadSourceSubMediaPlaceholderText)
        
        self.rightView = rightSideImageView
        self.rightViewMode = .always
        setupButton()
        
        
    }
    
    func setupButton(){
        
        self.addSubview(mediaButton)
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(mediaButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        buttonConstraint.append(mediaButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(mediaButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(mediaButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}



class LeadCustomerNameEditSearchTF:UITextField,UITextFieldDelegate{
    
    var searchButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(searchImage, for: .normal)
        button.imageView!.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
        //button.backgroundColor = AppColor.Shared.purple_500
        return button
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = searchImage
        
        return imageview
    }()
    
    lazy var leftSideImageView : UIImageView  = {
        let leftImageView = UIImageView()
        leftImageView.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
        //leftImageView.image = UIImage(named: "magnet")
        leftImageView.backgroundColor = AppColor.Shared.colorWhite
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        return leftImageView
    }()
    
    var imageConstraints = [NSLayoutConstraint]()
    var widthConstraint : NSLayoutConstraint!
   

    override func awakeFromNib() {
        
        
        self.leftView = self.leftSideImageView
        
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.autocorrectionType = .no
        self.textColor = AppColor.Shared.greyText
        self.tintColor = AppColor.Shared.greyText
        self.rightView = searchButton
        self.rightViewMode = .always
        self.customPlaceholder(color:AppColor.Shared.greyText,text:  "Search")
        self.delegate = self
        self.setUp()
        //self.setupButton()
        
    }
    
    func setUp(){
        
        //self.leftSideImageView.backgroundColor = UIColor.gray
        //self.imageConstraints.append(self.leftSideImageView.leftAnchor.constraint(equalTo: self.leftView!.leftAnchor, constant: 5))
        widthConstraint = self.leftSideImageView.widthAnchor.constraint(equalToConstant: 4)
        self.imageConstraints.append(widthConstraint)
        self.imageConstraints.append(self.leftSideImageView.heightAnchor.constraint(equalToConstant: 20))
        self.imageConstraints.append(self.leftSideImageView.centerXAnchor.constraint(equalTo: self.leftView!.centerXAnchor, constant: 0))
        NSLayoutConstraint.activate(self.imageConstraints)
        
    }
    
    func setupButton(){
        
        self.rightView!.addSubview(searchButton)
        self.bringSubviewToFront(searchButton)
        searchButton.backgroundColor = AppColor.Shared.ColorHot
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(searchButton.leftAnchor.constraint(equalTo: self.rightView!.leftAnchor, constant: 0))
        buttonConstraint.append(searchButton.rightAnchor.constraint(equalTo: self.rightView!.rightAnchor, constant: 6))
        buttonConstraint.append(searchButton.topAnchor.constraint(equalTo: self.rightView!.topAnchor, constant: -6))
        buttonConstraint.append(searchButton.bottomAnchor.constraint(equalTo: self.rightView!.bottomAnchor, constant: 6))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
    
//    override func caretRect(for position: UITextPosition) -> CGRect {
//        return CGRect.zero
//    }
//
    
    

   
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) || action == #selector(selectAll(_:)) || action == #selector(select(_:)){
            
            return false
        }

        return true
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 20
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString:NSString = (textField.text ?? "")  as NSString
        let newString : NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        widthConstraint.constant = newString.length > 0 ? 4 : 4
        
        
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
        
        return true
    }
}

class LeadCustomerCustNameTF:UITextField{
    
    var searchByNameorMobileButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    let image:UIImage = UIImage(named: "magnet")!
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.backgroundColor = AppColor.Shared.colorWhite
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.inputView = UIView()
        self.customPlaceholder(color:AppColor.Shared.greyText,text: leadCustomerDetailByNameMobile)
        self.autocorrectionType = .no
        self.rightView = rightSideImageView
        self.rightViewMode = .always
        
        setupButton()
    }
    
    func setupButton(){
        
        self.addSubview(searchByNameorMobileButton)
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(searchByNameorMobileButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        buttonConstraint.append(searchByNameorMobileButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(searchByNameorMobileButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(searchByNameorMobileButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
    
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 0
        let width = 8
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}


class LeadCustomerRespectTF:UITextField{
    
    var honorificsButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    let image:UIImage = UIImage(named: "magnet")!
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.backgroundColor = AppColor.Shared.colorWhite
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.inputView = UIView()
        self.customPlaceholder(color:AppColor.Shared.greyText,text: "Mr")
        self.tintColor = AppColor.Shared.colorWhite
        self.rightView = rightSideImageView
        self.rightViewMode = .always
        setupButton()
        
        
    }
    
    func setupButton(){
        
        self.addSubview(honorificsButton)
        //honorificsButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(honorificsButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        buttonConstraint.append(honorificsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(honorificsButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(honorificsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
//    override func caretRect(for position: UITextPosition) -> CGRect {
//        return CGRect.zero
//    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 0
        let width = 8
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}


class LeadCustomerDetailsTF:UITextField{
    
    
    
    let image:UIImage = UIImage(named: "magnet")!
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.tintColor = AppColor.Shared.greyText
        self.autocorrectionType = .no
       
        
        
        
        
    }
    
    
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
}

class LeadMoreInfoTF:UITextField{
    
    let image:UIImage = UIImage(named: "phone-book")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.tintColor = AppColor.Shared.greyText
        self.textColor = AppColor.Shared.greyText
        
        self.autocorrectionType = .no
        
        
        
    }
    
   
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    
    
}

class LeadMoreListingTF:UITextField{
    
    var dropDownButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let image:UIImage = UIImage(named: "magnet")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.inputView = UIView()
        self.textColor = AppColor.Shared.greyText
        
        
        self.rightView = rightSideImageView
        
        self.rightViewMode = .always
        setupButton()
        
    }
    
    func setupButton(){
        
        self.addSubview(dropDownButton)
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(dropDownButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
    
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}

class LeadMorePinCodeTF:UITextField{
    
    var searchButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "pincodeSearch"), for: .normal)
        button.imageView!.layer.transform = CATransform3DMakeScale(0.95, 0.95, 0.95)
        //button.backgroundColor = AppColor.Shared.purple_500
        return button
    }()
    
    let image:UIImage = UIImage(named: "pin")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = UIImage(named: "pincodeSearch")
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.keyboardType = .numberPad
        self.textColor = AppColor.Shared.greyText
        self.autocorrectionType = .no
        self.tintColor = AppColor.Shared.greyText
        self.customPlaceholder(color: AppColor.Shared.greyText, text: "Pincode")
        
        self.rightView = searchButton
        
        self.rightViewMode = .always
        //self.setupSearchButton()
        
    }
    
    func setupSearchButton(){
        self.rightView!.addSubview(searchButton)
        self.bringSubviewToFront(searchButton)
        searchButton.backgroundColor = AppColor.Shared.ColorHot
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(searchButton.leftAnchor.constraint(equalTo: self.rightView!.leftAnchor, constant: 0))
        buttonConstraint.append(searchButton.rightAnchor.constraint(equalTo: self.rightView!.rightAnchor, constant: 0))
        buttonConstraint.append(searchButton.topAnchor.constraint(equalTo: self.rightView!.topAnchor, constant: 0))
        buttonConstraint.append(searchButton.bottomAnchor.constraint(equalTo: self.rightView!.bottomAnchor, constant: 0))
    }
    
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 20
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}

//=========================== PROJECT/PRODUCT DETAILS CUSTOM VIEWS CLASS =============================

class ProjectDetailsCategoryTF:UITextField{
    
    var dropDownButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let image:UIImage = UIImage(named: "figures")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.autocorrectionType = .no
        self.tintColor = AppColor.Shared.greyText
        self.customPlaceholder(color: AppColor.Shared.greyText, text: "Category")
        self.autocorrectionType = .no
       
        self.rightView = rightSideImageView
        
        self.rightViewMode = .always
        
        setupButton()
        
    }
    
    func setupButton(){
        
        self.addSubview(dropDownButton)
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(dropDownButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
    
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}


class ProjectDetailsProductTF:UITextField{
    
    var productButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let image:UIImage = UIImage(named: "product")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.autocorrectionType = .no
        self.tintColor = AppColor.Shared.greyText
        self.customPlaceholder(color: AppColor.Shared.greyText, text: "Product")
        self.autocorrectionType = .no
        self.rightView = rightSideImageView
        
        self.rightViewMode = .always
        
    }
    
    
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}


class ProjectDetailsQtyTF:UITextField{
    
    let image:UIImage = UIImage(named: "qty")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.customPlaceholder(color: AppColor.Shared.greyText, text: "Qty")
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.tintColor = AppColor.Shared.greyText
        self.textColor = AppColor.Shared.greyText
        self.autocorrectionType = .no
        
        
        
    }
    
   
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    
    
}


class ProjectDetailsPriorityTF:UITextField{
    
    var dropDownButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let image:UIImage = UIImage(named: "prioritize")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.autocorrectionType = .no
        self.tintColor = AppColor.Shared.greyText
        self.customPlaceholder(color: AppColor.Shared.greyText, text: "Priority")
        self.autocorrectionType = .no
        self.rightView = rightSideImageView
        
        self.rightViewMode = .always
        setupButton()
    }
    
    func setupButton(){
        
        self.addSubview(dropDownButton)
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(dropDownButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
    
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
    
   
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}


class ProjectDetailEnquiryNoteTF:UITextField{
    
    let image:UIImage = UIImage(named: "note")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.customPlaceholder(color: AppColor.Shared.greyText, text: "Enquiry Note")
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.tintColor = AppColor.Shared.greyText
        self.textColor = AppColor.Shared.greyText
        self.borderStyle = UITextField.BorderStyle.roundedRect
        self.autocorrectionType = .no
        
        
        
    }
    
   
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    
    
}


class ProjectDetailsStatusTF:UITextField{
    
    
    var dropDownButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let image:UIImage = UIImage(named: "action")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.autocorrectionType = .no
        self.tintColor = AppColor.Shared.greyText
        self.customPlaceholder(color: AppColor.Shared.greyText, text: "Action")
        self.autocorrectionType = .no
        self.rightView = rightSideImageView
        
        self.rightViewMode = .always
        self.setupButton()
    }
    
    func setupButton(){
        
        self.addSubview(dropDownButton)
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(dropDownButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
    
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
    
    
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}


class ProjectDetailsActionTF:UITextField{
    
    let image:UIImage = UIImage(named: "action")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.autocorrectionType = .no
        self.tintColor = AppColor.Shared.greyText
        self.customPlaceholder(color: AppColor.Shared.greyText, text: "Action")
        
        self.rightView = rightSideImageView
        
        self.rightViewMode = .always
        
    }
    
    
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}

class ProjectDetailsActionTypeTF:UITextField{
    
    var dropDownButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let image:UIImage = UIImage(named: "action_type")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.autocorrectionType = .no
        self.tintColor = AppColor.Shared.greyText
        self.customPlaceholder(color: AppColor.Shared.greyText, text: "Action Type")
        
        self.rightView = rightSideImageView
        
        self.rightViewMode = .always
        
        self.setupButton()
        
    }
    
    func setupButton(){
        
        self.addSubview(dropDownButton)
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(dropDownButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
    
   
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}

protocol ProjectDateDelegate:AnyObject{
    func projectDate(date:String)
}


class ProjectDetailsDateTF : UITextField {


    weak var date_delegate:ProjectDateDelegate?
    
    lazy var dateimageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = calendarImage
        return imageview
    }()
    
    var dateTodayOnwards:Bool=false{
        didSet{
            if dateTodayOnwards == true{
                initializeDate(dateOnwards: dateTodayOnwards)
            }
        }
    }
    
    let calendarImage:UIImage = UIImage(named: "leadcalendar")!
    let datePickerView = UIDatePicker()
    
    override func awakeFromNib() {
        
        self.leftView = dateimageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.text = DateTimeModel.shared.stringDateFromDate(Date())
        
        initializeDate()
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    func initializeDate(dateOnwards:Bool=false){
        datePickerView.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .compact
        } else {
            // Fallback on earlier versions
        }
        if dateOnwards == true{
        datePickerView.minimumDate = Date()
        }
        datePickerView.tintColor = AppColor.Shared.greyText
        self.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
    
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {

            let dateFormatter = DateFormatter()

            dateFormatter.dateStyle = DateFormatter.Style.medium

            dateFormatter.timeStyle = DateFormatter.Style.none

           self.text = DateTimeModel.shared.stringDateFromDate(sender.date)
        date_delegate?.projectDate(date: DateTimeModel.shared.stringDateFromDate(sender.date))
           self.resignFirstResponder()

        }
    
}

class ProjectDetailsUserTF:UITextField{
    
    
    var dropDownButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let image:UIImage = UIImage(named: "leaduser")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.autocorrectionType = .no
        self.tintColor = AppColor.Shared.greyText
        self.customPlaceholder(color: AppColor.Shared.greyText, text: "Employee")
        
        self.rightView = rightSideImageView
        
        self.rightViewMode = .always
        self.setupButton()
        
    }
    
    func setupButton(){
        
        self.addSubview(dropDownButton)
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(dropDownButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(dropDownButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
    
   
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 20
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}

// LOCATION DETAILS

class LocationDetailsTF:UITextField{
    
    var mapButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let image:UIImage = UIImage(named: "location")!
    
    lazy var leftSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = image
        return imageview
    }()
    
    
    
    override func awakeFromNib() {
        
        self.leftView = leftSideImageView
        self.leftViewMode = .always
        self.customPlaceholder(color: AppColor.Shared.greyText, text: "Location")
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.tintColor = AppColor.Shared.greyText
        self.textColor = AppColor.Shared.greyText
        self.autocorrectionType = .no
        
        self.setupButton()
        
    }
    
    func setupButton(){
        
        self.addSubview(mapButton)
        //sourceButton.backgroundColor = AppColor.Shared.colorPrimary
        var buttonConstraint = [NSLayoutConstraint]()
        buttonConstraint.append(mapButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        buttonConstraint.append(mapButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(mapButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(mapButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
    }
    
    
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
 
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width = 15
        let height = width
        let x = offset
        let y = (Int(self.frame.height) - height)/2
        let leftViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return leftViewBounds
    }
    
    
    
}


class UploadImageView:UIImageView{
    var deleteButton:UIButton = {
        
        let button  = UIButton()
        button.titleLabel?.text = ""
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func awakeFromNib() {
        
        setupDeleteButton()
    }
    
    
    func setupDeleteButton(){
        self.addSubview(deleteButton)
        
        var buttonConstraint = [NSLayoutConstraint]()
        
        deleteButton.setImage(UIImage(named: "close"), for: .normal)
        
        buttonConstraint.append(deleteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        buttonConstraint.append(deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        buttonConstraint.append(deleteButton.widthAnchor.constraint(equalToConstant: 25))
        buttonConstraint.append(deleteButton.heightAnchor.constraint(equalToConstant: 25))
        
        NSLayoutConstraint.activate(buttonConstraint)
        
        
    }
}


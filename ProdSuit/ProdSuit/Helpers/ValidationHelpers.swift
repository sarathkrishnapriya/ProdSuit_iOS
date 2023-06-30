//
//  ValidationHelpers.swift
//  ProdSuit
//
//  Created by MacBook on 27/04/23.
//

import Foundation
import UIKit

protocol EmailChecker{
    var email : String { get }
    func isValidEmail()->Bool
}

struct EmailValidator:EmailChecker{
    
    var email: String

    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self.email)
    }
}

protocol MobileChecker{
    
    var length:Int { get }
    var currentTextField:UITextField{ get }
    func isValidMobileNumber(_ mobileNumber:NSString) -> Bool

}

class MobileValidator:NSObject,MobileChecker,UITextFieldDelegate{
    
    
    var length: Int
    var numberString : String = ""
    var currentTextField: UITextField
    
    init(textField:UITextField,length:Int=12) {
       
        self.currentTextField = textField
        self.currentTextField.addDonButton()
        self.length = length
        super.init()
        self.currentTextField.delegate = self
    }
    
    func isValidMobileNumber(_ mobileNumber:NSString) -> Bool {
        return mobileNumber.length <= self.length
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText : NSString = (textField.text ?? "")  as NSString
        let newText : NSString = currentText.replacingCharacters(in: range, with: string) as NSString
//        self.numberString = isValidMobileNumber(newText) == true ? String((newText as String).prefix(self.length)) : ""
        self.numberString = newText as String
        return isValidMobileNumber(newText)
    }
    
    
}


@objc public protocol TabLayoutDelegate:NSObjectProtocol{
    @objc optional func tabLayout(tablayout:TabLayout,index:Int)
}

@IBDesignable public class TabLayout:UIScrollView,UIScrollViewDelegate{
    private let indicator = UIView()
    private var buttons = [UIButton]()
    private var controllers = [UIView]()
    
    var index = 0
    var previousIndex = 0
    
    @IBOutlet public weak var tabLayoutDelegate : TabLayoutDelegate!
    
    @IBOutlet public weak var scrollView:UIScrollView?{
        didSet{
            scrollView?.delegate = self
            scrollView?.showsHorizontalScrollIndicator = false
            scrollView?.isPagingEnabled = true
        }
    }
    
    @IBInspectable public var fixedMode:Bool = false{
        didSet{
            reload()
        }
    }
    
    @IBInspectable public var textColor:UIColor = UIColor.gray{
        didSet{
            reload()
        }
    }
    
    @IBInspectable public var currentTextColor:UIColor = UIColor.black{
        didSet{
            reload()
        }
    }
    
    @IBInspectable public var font: UIFont = AppFonts.Shared.Regular.withSize(13) {
        didSet { reload() }
    }
    
    @IBInspectable public var currentFont: UIFont = AppFonts.Shared.SemiBold.withSize(13) {
        didSet { reload() }
    }
    
    @IBInspectable public var imageColor: UIColor = UIColor.darkGray {
        didSet { reload() }
    }
    
    @IBInspectable public var currentImageColor: UIColor = UIColor.black {
        didSet { reload() }
    }
    
    @IBInspectable public var indicatorColor: UIColor = UIColor.white {
        didSet { indicator.backgroundColor = indicatorColor }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        reload()
        //        let vc  = UIViewController()
        //        addTabs(tabs: [(title: "hello", image: nil, vc: vc)])
    }
    
    public func addTabs(tabs:[(title:String?,image:UIImage?,vc:UIViewController)]){
        
        addTabButtons(tabs: tabs)
        addControllers(tabControllers:tabs.map{ $0.vc })
        reload()
    }
    
    private func addControllers(tabControllers:[UIViewController]){
        
        let scrollView = self.scrollView
        
        for view in (scrollView?.subviews)! {
            view.removeFromSuperview()
        }
        
        controllers = []
        
        
        for singleController in tabControllers{
            
            
            scrollView?.addSubview(singleController.view)
            
            controllers.append(singleController.view)
           
        }
        
    }
    
    private func addTabButtons(tabs: [(title: String?, image: UIImage?, vc: UIViewController)]){
        
        for button in buttons{
            button.removeFromSuperview()
        }
        
        buttons = []
        
        var i = 0
        for tab in tabs{
            let button = configButton(index: i, title: tab.title, image: tab.image)
            buttons.append(button)
            addSubview(button)
            addSubview(indicator)
            
            i = i + 1
        }
        
        
        
    }
    
    
    
    
        func reload(){
        refreshButtons()
        
        if buttons.count > 0 {
            setIndex(index: index, animated: false, scroll: false)
        }
        scrollView?.contentSize = CGSize(width: (scrollView?.frame.size.width)! * CGFloat(buttons.count), height: (scrollView?.frame.size.height)!)
        
        for i in 0..<controllers.count {
            controllers[i].frame = CGRect(x: (scrollView?.frame.size.width)! * CGFloat(i), y: 0, width: (scrollView?.frame.size.width)!, height: (scrollView?.frame.size.height)!)
        }
        
    }
    
    private func refreshButtons() {
        let height = frame.size.height - 2
        var currentWidth : CGFloat = 0.0
        
        for i in 0..<buttons.count {
            let button = buttons[i]
            let width = buttonWidth(button: button)
            button.frame = CGRect(x: currentWidth, y: 0, width: width, height: height)
            currentWidth += width
            
            button.setTitleColor((i == index) ? currentTextColor : textColor, for: .normal)
            button.titleLabel?.font = (i == index) ? currentFont : font
            button.imageView?.tintColor = (i == index) ? currentImageColor : imageColor
        }
        
        contentSize = CGSize(width: currentWidth, height: height)
    }
    
    
    @objc public func tabClicked(sender: UIButton) {
        tabLayoutDelegate?.tabLayout?(tablayout: self, index: sender.tag)
        setIndex(index: sender.tag, animated: true, scroll: true)
    }
    
    public func setIndex(index: Int, animated: Bool, scroll: Bool) {
        self.index = index
        let button = self.buttons[index]
        
        var currentWidth : CGFloat = 0.0
        for i in 0...index {
            currentWidth += self.buttonWidth(button: self.buttons[i])
        }
        
        let width = self.buttonWidth(button: button)
        
        self.refreshButtons()
        
        self.indicator.frame = CGRect(x: currentWidth - width, y: self.frame.size.height - 2, width: width, height: 2)
        
        
        if index > previousIndex {
            scrollRectToVisible( CGRect(x: currentWidth, y: 0, width: 1, height: 1), animated: false)
        } else {
            if index != previousIndex {
                scrollRectToVisible( CGRect(x: currentWidth - width, y: 0, width: 1, height: 1), animated: false)
            }
        }
        
        previousIndex = index
        
        if scroll {
            self.scrollView?.contentOffset = CGPoint(x: CGFloat(index) * (scrollView?.frame.size.width)!, y: 0)
        }
        
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let tab = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        if tab != index {
            setIndex(index: tab, animated: true, scroll: false)
            tabLayoutDelegate?.tabLayout?(tablayout: self, index: tab)
        }
        
    }
    
    public func buttonWidth(button: UIButton) -> CGFloat {
        var width : CGFloat = 0
        
        if fixedMode {
            width = self.frame.size.width / CGFloat(buttons.count)
            return width
        }
        
        let string = button.titleLabel?.text
        let font = button.titleLabel?.font
        let size = string?.size(withAttributes: [NSAttributedString.Key.font: font!])
        let imageSize = button.imageView?.image?.size
        
        if size != nil {
            width =  (size?.width)! + 20
        }
        if imageSize != nil {
            width = width + (imageSize?.width)! + 20
        }
        
        
        return width
    }
    
    
}


extension TabLayout {
    public func configButton(index: Int, title: String?, image:UIImage?) -> UIButton {
        let button = UIButton(type: .custom)
        
        button.tag = index
        button.addTarget(self, action: #selector(TabLayout.tabClicked(sender:)), for: .touchUpInside)
        
        if title != nil {
            button.setTitle(title, for: .normal)
        }
        
        if image != nil {
            let img = image?.withRenderingMode(.alwaysTemplate)
            button.setImage(img, for: .normal)
            if title != nil {
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
                button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            }
        }
        
        return button
    }
}


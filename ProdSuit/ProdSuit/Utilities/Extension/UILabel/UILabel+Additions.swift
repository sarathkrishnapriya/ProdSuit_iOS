//
//  UILabel+Additions.swift
//  ProdSuit
//
//  Created by MacBook on 15/02/23.
//

import Foundation
import UIKit

extension UILabel{
    
    func setLabelValue(_ value:String){
        self.text = value
    }
    
    
    func addCountLabel(mainView:UIView,count:String = "0"){
       let countView = CircleCornerView()
       let countLbl = UILabel()
        countLbl.setFontSize(12, font: .medium, autoScale: true)
        countLbl.setTextColor(AppColor.Shared.colorPrimary)
        countLbl.textAlignment = .center
        
        countLbl.setLabelValue(count)
        countLbl.translatesAutoresizingMaskIntoConstraints = false
        countView.setBGColor(color: AppColor.Shared.colorWhite)
        countView.translatesAutoresizingMaskIntoConstraints = false
        
        countView.addSubview(countLbl)
        mainView.addSubview(countView)
        mainView.bringSubviewToFront(countView)
        countView.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        
        countView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        let widthanchor = countView.widthAnchor.constraint(equalToConstant: 35)
        widthanchor.priority = UILayoutPriority.init(rawValue: 750)
        widthanchor.isActive = true
        
        countView.heightAnchor.constraint(equalTo: countView.widthAnchor).isActive = true
        
        
        
        countLbl.leadingAnchor.constraint(equalTo: countView.leadingAnchor, constant: 3).isActive = true
        countLbl.trailingAnchor.constraint(equalTo: countView.trailingAnchor, constant: -3).isActive = true
        countLbl.topAnchor.constraint(equalTo: countView.topAnchor, constant: 3).isActive = true
        countLbl.bottomAnchor.constraint(equalTo: countView.bottomAnchor, constant: -3).isActive = true
        
        
    }
    
    func setLineHeight(lineHeight:CGFloat=0.4){
        let text = self.text
        if let text = text {
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()

        style.lineSpacing = lineHeight
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
        self.attributedText = attributeString
        }
    }
    
    func setTextColor(_ color:UIColor){
        self.textColor = color
    }
    
    func setFontSize(_ size:CGFloat,font:AppFont,autoScale : Bool = false){
        self.font = font.size(autoScale == true ? size.dp : size)
    }
    
//    private struct AssociatedKeys {
//            static var padding = UIEdgeInsets()
//        }
//
//        public var padding: UIEdgeInsets? {
//            get {
//                return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
//            }
//            set {
//                if let newValue = newValue {
//                    objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//                }
//            }
//        }
//
//        override open func draw(_ rect: CGRect) {
//            
//            if let insets = padding {
//                self.drawText(in: rect.inset(by: insets))
//            } else {
//                self.drawText(in: rect)
//            }
//        }
//
//        override open var intrinsicContentSize: CGSize {
//            guard let text = self.text else { return super.intrinsicContentSize }
//
//            var contentSize = super.intrinsicContentSize
//            var textWidth: CGFloat = frame.size.width
//            var insetsHeight: CGFloat = 0.0
//            var insetsWidth: CGFloat = 0.0
//
//            if let insets = padding {
//                insetsWidth += insets.left + insets.right
//                insetsHeight += insets.top + insets.bottom
//                textWidth -= insetsWidth
//            }
//
//            let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
//                                            options: NSStringDrawingOptions.usesLineFragmentOrigin,
//                                            attributes: [NSAttributedString.Key.font: self.font!], context: nil)
//
//            contentSize.height = ceil(newSize.size.height) + insetsHeight
//            contentSize.width = ceil(newSize.size.width) + insetsWidth
//
//            return contentSize
//        }
}


extension CGFloat {
    var dp: CGFloat {
        
        let width = UIScreen.main.bounds.width
        let device = UIScreen.main.traitCollection.userInterfaceIdiom
        
        if (device == .phone) {
            if (width <= 320) {
                // iPod(Gen7)
                // iPhone(5s, SEGen1)
                return self * 0.75
            } else if (width <= 375) {
                // iPhone(SEGen2 6, 6s, 7, 8, X, Xs, 11pro, 12mini, 13mini)
                return self * 1.1
            } else if (width <= 414) {
                // iPhone(6+, 6s+, 7+, 8+, XsMax, XR, 11, 11proMax, 12, 12pro, 13, 13pro)
                return self * 1.15
            } else if (width <= 744) {
                // iPhone(12proMax, 13proMax)
                return self * 1.2
            }
        } else if (device == .pad) {
            if (width <= 744) {
                // ipad(miniGen6, )
                return self * 1.4
            } else if (width <= 768) {
                // ipad(Gen5, Gen6, Air, Air2, Pro9.7)
                return self * 1.45
            } else if (width <= 810) {
                // ipad(Gen9)
                return self * 1.5
            } else if (width <= 834) {
                // ipad(AirGen3, AirGen5, Pro10.5, Pro11Gen1, Pro11Gen3)
                return self * 1.55
            } else if (width <= 1024) {
                // ipad(Pro12.9Gen1, Pro12.9Gen2, Pro12.9Gen3, Pro12.9Gen5)
                return self * 1.85
            }
        }
        
        return self
    }
}

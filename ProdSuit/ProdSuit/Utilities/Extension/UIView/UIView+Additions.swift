//
//  UIView+Additions.swift
//  ProdSuit
//
//  Created by MacBook on 13/02/23.
//

import Foundation
import UIKit

enum AnimationKeyPath:String{
    case opacity = "opacity"
    case rotation = "transform.rotation"
}

extension UIView{
    
    
    
    
    enum AnimationKeyPath:String{
        case opacity = "opacity"
        case rotate = "transform.rotation"
    }
    
    func flash(animation:AnimationKeyPath = .opacity,withDutation duration:TimeInterval = 1.5,repeatCount:Float = Float(Double.infinity)){
        
        let flash = CABasicAnimation(keyPath: animation.rawValue)
        flash.duration = duration
        flash.fromValue = 1
        flash.toValue = 0.15
        flash.repeatCount = repeatCount
        flash.autoreverses = true
        flash.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        layer.add(flash, forKey: nil)
        
    }
    
   
    
    func setBGColor(color:UIColor = AppColor.Shared.colorWhite){
        self.backgroundColor = color
    }
    
    func setCornerRadius(size:CGFloat=5){
        self.layer.cornerRadius = size
        self.layer.masksToBounds = false
        //self.clipsToBounds = true
    }
    
    
    
    func setBorder(width:CGFloat=0.5,borderColor:UIColor=AppColor.Shared.colorPrimaryDark){
        self.layer.borderWidth = width
        self.layer.borderColor = borderColor.cgColor
    }
    
    func keyboardHide(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       self.addGestureRecognizer(tap)

        
    }
    
    func dismissKeyboard() {
           //Hides keyboard
           self.endEditing(true)
       }
    
    
    func opacityAnimation(fromValue:Float=1,toValue:Float=0.4,duration:CFTimeInterval=0.5){
        
        let opacityAnimation = CABasicAnimation(keyPath: AnimationKeyPath.opacity.rawValue)
        opacityAnimation.duration = duration
        opacityAnimation.fromValue = fromValue
        opacityAnimation.toValue = toValue
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
      
        opacityAnimation.autoreverses = true
        self.subviews.map { subview in
            subview.layer.add(opacityAnimation, forKey: nil)
        }
        
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    
    func addShadow(width:CGFloat=1,height:CGFloat=2,color:UIColor=AppColor.Shared.coloBlack,opacity:Float=1) {
        
        self.layer.shadowColor = color.cgColor
        self.layer.masksToBounds = true
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowOpacity = opacity
      }
    
    func addBottomShadow(radius:CGFloat=4,color:UIColor=AppColor.Shared.redDark) {
        layer.masksToBounds = false
        layer.shadowRadius = radius
        layer.shadowOpacity = 1
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 2)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.maxY - layer.shadowRadius,
                                                     width: bounds.width,
                                                     height: layer.shadowRadius)).cgPath
    }
           
    
    
    
        func showBlurLoader() {
            let blurLoader = BlurLoader(frame: frame)
            self.addSubview(blurLoader)
        }

        func removeBluerLoader() {
            if let blurLoader = subviews.first(where: { $0 is BlurLoader }) {
                blurLoader.removeFromSuperview()
            }
        }
    
    func viewShadow(_ color:UIColor?=AppColor.Shared.greydark,_ size:CGSize=CGSize(width: 0 , height:2),_ radius:CGFloat=2,_ opacity:Float=0.45){
        self.layer.masksToBounds = false
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color?.cgColor
        self.layer.shadowOffset = size
    }
    
    func displayTooltip(_ message: String, completion: (() -> Void)? = nil) {
            let tooltipBottomPadding: CGFloat = 12
            let tooltipCornerRadius: CGFloat = 6
            let tooltipAlpha: CGFloat = 0.95
            let pointerBaseWidth: CGFloat = 14
            let pointerHeight: CGFloat = 8
            let padding = CGPoint(x: 18, y: 12)
            
            let tooltip = UIView()
            
            let tooltipLabel = UILabel()
            tooltipLabel.text = "    \(message)    "
        tooltipLabel.font = AppFonts.Shared.Regular.withSize(12)
            tooltipLabel.contentMode = .center
            tooltipLabel.textColor = .white
            tooltipLabel.layer.backgroundColor = UIColor(red: 44 / 255, green: 44 / 255, blue: 44 / 255, alpha: 1).cgColor
            tooltipLabel.layer.cornerRadius = tooltipCornerRadius
            
            tooltip.addSubview(tooltipLabel)
            tooltipLabel.translatesAutoresizingMaskIntoConstraints = false
            tooltipLabel.bottomAnchor.constraint(equalTo: tooltip.bottomAnchor, constant: -pointerHeight).isActive = true
            tooltipLabel.topAnchor.constraint(equalTo: tooltip.topAnchor).isActive = true
            tooltipLabel.leadingAnchor.constraint(equalTo: tooltip.leadingAnchor).isActive = true
            tooltipLabel.trailingAnchor.constraint(equalTo: tooltip.trailingAnchor).isActive = true
            
            let labelHeight = message.height(withWidth: .greatestFiniteMagnitude, font: AppFonts.Shared.Regular.withSize(12)) + padding.y
           let labelWidth = message.width(withHeight: .zero, font: AppFonts.Shared.Regular.withSize(12)) + padding.x
            
            let pointerTip = CGPoint(x: labelWidth / 2, y: labelHeight + pointerHeight)
            let pointerBaseLeft = CGPoint(x: labelWidth / 2 - pointerBaseWidth / 2, y: labelHeight)
            let pointerBaseRight = CGPoint(x: labelWidth / 2 + pointerBaseWidth / 2, y: labelHeight)
            
            let pointerPath = UIBezierPath()
            pointerPath.move(to: pointerBaseLeft)
            pointerPath.addLine(to: pointerTip)
            pointerPath.addLine(to: pointerBaseRight)
            pointerPath.close()
            
            let pointer = CAShapeLayer()
            pointer.path = pointerPath.cgPath
            pointer.fillColor = UIColor(red: 44 / 255, green: 44 / 255, blue: 44 / 255, alpha: 1).cgColor
            
            tooltip.layer.addSublayer(pointer)
            (superview ?? self).addSubview(tooltip)
            tooltip.translatesAutoresizingMaskIntoConstraints = false
            tooltip.bottomAnchor.constraint(equalTo: topAnchor, constant: -tooltipBottomPadding + pointerHeight).isActive = true
            tooltip.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            tooltip.heightAnchor.constraint(equalToConstant: labelHeight + pointerHeight).isActive = true
            tooltip.widthAnchor.constraint(equalToConstant: labelWidth).isActive = true
            
            tooltip.alpha = 0
            UIView.animate(withDuration: 0.2, animations: {
                tooltip.alpha = tooltipAlpha
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                    tooltip.alpha = 0
                }, completion: { _ in
                    tooltip.removeFromSuperview()
                    completion?()
                })
            })
        }
  
    
}



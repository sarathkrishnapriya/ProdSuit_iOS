//
//  UITextfield+Additions.swift
//  ProdSuit
//
//  Created by MacBook on 06/04/23.
//

import Foundation
import UIKit

extension UITextField{
    
    func customPlaceholder(color:UIColor=AppColor.Shared.greylight,text:String=""){
        self.attributedPlaceholder = NSAttributedString(
            string: "\(text)",
            attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    func setTextFieldValue(_ value:String){
        self.text = value
    }
    
    func setTextColor(_ color:UIColor){
        self.textColor = color
    }
    
    func setFontSize(_ size:CGFloat,font:AppFont,autoScale : Bool = false){
        self.font = font.size(autoScale == true ? size.dp : size)
    }
    
    func addDonButton(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
                doneToolbar.barStyle = .default

                let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
                done.tintColor = AppColor.Shared.greydark
                let items = [flexSpace, done]
                doneToolbar.items = items
                doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        self.resignFirstResponder()
        }
    
}

extension UITextView{
    func setTextColor(_ color:UIColor){
        self.textColor = color
    }
    
    func setFontSize(_ size:CGFloat,font:AppFont){
        self.font = font.size(size)
    }
    
    func setValue(_ value:String){
        self.text = value
    }
    
    func addDonButton(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
                doneToolbar.barStyle = .default

                let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
                done.tintColor = AppColor.Shared.greydark
                let items = [flexSpace, done]
                doneToolbar.items = items
                doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        self.resignFirstResponder()
        }
}

extension Date {
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

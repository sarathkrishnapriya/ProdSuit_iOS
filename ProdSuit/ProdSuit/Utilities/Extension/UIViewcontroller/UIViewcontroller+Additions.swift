//
//  UIViewcontroller+Additions.swift
//  ProdSuit
//
//  Created by MacBook on 15/02/23.
//

import Foundation
import UIKit
import Combine





extension UIViewController{
    
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         alert.view.subviews.first?.subviews.first?.backgroundColor = UIColor.white
        let titleFont = [NSAttributedString.Key.font: AppFont.semiBold.size(15)]
        let messageFont = [NSAttributedString.Key.font: AppFont.regular.size(14)]

        let titleAttrString = NSMutableAttributedString(string:title!, attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: message!, attributes: messageFont)
        alert.setValue(titleAttrString, forKey: "attributedTitle")
        alert.setValue(messageAttrString, forKey: "attributedMessage")
         
         for (index, title) in actionTitles.enumerated() {
             let action = UIAlertAction(title: title, style: .default, handler: actions[index])
             action.setValue(AppColor.Shared.colorPrimaryDark, forKey: "titleTextColor")
             alert.addAction(action)
         }
         self.present(alert, animated: true, completion: nil)
     }
    
    var allControllers:[UIViewController]{
        return self.navigationController?.viewControllers ?? []
    }
    
    
    
    func popToViewController(ofClass: AnyClass,controllers:[UIViewController]){
        
        controllers.map { controller in
            if controller.isKind(of: ofClass){
               self.navigationController?.popToViewController(controller, animated: true)
                return
            }
        }
        
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
    
    func moveToNextVc(nextController:UIViewController) {
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    func keyboardShowHideObserver() {
        print("keyboard")
    }
    
    func rootViewController(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func image(fromLayer layer : CALayer) -> UIImage{
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        return outputImage!
    }
    
    func setGradient(bgView:UIView,colors:[UIColor])->UIImage{
        let gradient = CAGradientLayer()
        gradient.frame = bgView.bounds
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = [colors[0].cgColor, colors[1].cgColor]
        return self.image(fromLayer: gradient)
    }
    
    func saveAndOpenFile(data:NSMutableData,fileName:String){
        
        // create destination url
        let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationUrl = documentUrl.appendingPathComponent("\(fileName)")
      
        
        do{
           // Write to app data
            if data.write(to: destinationUrl, atomically: true){
                let contents = try FileManager.default.contentsOfDirectory(at: documentUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
           // find content we have searched
              let getContent =  contents.filter{ return $0.lastPathComponent == destinationUrl.lastPathComponent }
                // open searched content
                
            }
        }
        catch(let err){
            print("file Error : \(err)")
        }
        
    }
    
    func commonAppAlertAction(sender: UIButton,model:SplashViewModel){
        
        
        
      
        print(sender.tag)
        let companycode = instanceOfEncryptionPost.encryptUseDES("\(sender.tag)", key: SKey) ?? ""
        
        
        let textfield = sender.superview as! UITextField
        
        
        
//        var responder : UIResponder! = textfield
//
//        while !(responder is UIAlertController) { responder = responder.next }
//
//        let alertcontroller = responder as! UIAlertController
//
//        alertcontroller.parserVm
        
        textfield.dismissKeyboard()
        model.companyCodeApiCall(companyCode: companycode)
    
        
//        if sender.tag == 0{
//            alert.message = "Please enter company code below"
//            UIView.animate(withDuration: 2) {
//                alert.message = ""
//            }
//        }
        
        
        
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let btn  = textField.rightView as! UIButton
        
        btn.tag = Int((textField.text!).prefix(3)) ?? 0
            
        
        textField.text = btn.tag == 0 ? "" : "\(btn.tag)"
        
        var resp : UIResponder! = textField
        while !(resp is UIAlertController) { resp = resp.next }
          let alert = resp as! UIAlertController
          alert.actions[1].isEnabled = (textField.text != "")
        
        

    }
    
    
    
    
    func commonApiModeAlert(model:SplashViewModel,vc:SplashScreenVC){
        

       
    
        let alertController = UIAlertController(title: "COMPANY", message: "", preferredStyle: .alert)
            alertController.view.subviews.first?.subviews.first?.backgroundColor = UIColor.white
            var alertButton : UIButton!
        
            let cancelButton = UIAlertAction(title: "Cancel", style: .default) { alertaction in
                print("cancel button clicked")
                exit(0)
            }
        model.parserVM.NetworkCheck()
        let continueButton = UIAlertAction(title: "Continue", style: .default) { alert in
            if model.parserVM.isInternetConnected == true{
                print("internet connected")
            vc.commonAppAlertAction(sender: alertButton, model: model)
            }else{
                print("No internet")
                vc.popupAlert(title: "Network", message: "No internet connection. Do you want to continue?", actionTitles: ["No","Yes"], actions:[{action1 in
                    print("exit")
                    exit(0)
                },{action2 in
                    vc.present(alertController, animated: true, completion: nil)
                }, nil])
              }
            }
        
           
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                alertButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.size.height))
               //alertButton.addTarget(self, action: #selector(self.commonAppAlertAction(sender:)), for: .touchUpInside)
               textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .allEditingEvents)
               
               textField.rightView = alertButton
               textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
               textField.rightViewMode = .always
               textField.tintColor = AppColor.Shared.colorWhite
               textField.font = AppFont.medium.size(14)
               textField.textColor = AppColor.Shared.colorPrimaryDark
               textField.keyboardType = .numberPad
               textField.rightViewMode = .always
               //alertButton.backgroundColor = AppColor.Shared.colorPrimaryDark
               textField.placeholder = "Enter Code"
           }
           
        
               
           continueButton.setValue(AppColor.Shared.colorPrimaryDark, forKey: "titleTextColor")
           cancelButton.setValue(AppColor.Shared.colorPrimaryDark, forKey: "titleTextColor")
           
           alertController.addAction(cancelButton)
           alertController.addAction(continueButton)
           self.present(alertController, animated: true, completion: nil)
        
        
    }
}



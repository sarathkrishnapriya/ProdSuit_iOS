//
//  ForgotMpinCustomView.swift
//  ProdSuit
//
//  Created by MacBook on 22/02/23.
//

import Foundation
import UIKit


class ForgotMpinTF:UITextField{
    
    var leftViews : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUP()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUP()
    }
    
    override func awakeFromNib() {
        
        self.keyboardType = .numberPad
        self.textColor = AppColor.Shared.colorPrimaryDark
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.tintColor = AppColor.Shared.colorWhite
        self.setBorder(width: 0.4, borderColor: AppColor.Shared.colorPrimaryDark)
        
        
    }
    
    func setUP(){
        
         leftViews = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.center = leftViews.center
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_forgot_mobile")
        //imageView.backgroundColor = .red
        leftViews.addSubview(imageView)
        self.leftView = leftViews
        self.leftViewMode = .always
        
        
        
        
        
    }
    
    
    
}

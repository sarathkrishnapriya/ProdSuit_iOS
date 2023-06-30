//
//  WelcomeCustomView.swift
//  ProdSuit
//
//  Created by MacBook on 15/02/23.
//

import Foundation
import UIKit



class WelcomeTitleLabel:UILabel{
    
    override func awakeFromNib() {
        
        self.textColor = AppColor.Shared.colorWhite
        self.text = welcome_screen_title
        self.font = AppFont.extra_bold.size(18)
        
        
        self.textAlignment = .center
        
    }
}

class WelcomeDetailLabel:UILabel{
    
    override func awakeFromNib() {
        
        self.textColor = AppColor.Shared.colorWhite
        self.font = AppFont.regular.size(15)
        self.text = welcome_screen_details
        self.setLineHeight(lineHeight: 0.5)
        self.textAlignment = .center
        self.minimumScaleFactor = 0.5
        self.adjustsFontSizeToFitWidth = true
        
    }
}

class WelcomeStartedBtn:UIButton{
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func awakeFromNib() {
        self.titleLabel?.textColor = AppColor.Shared.p_green
        self.titleLabel?.text = welcome_screeen_btn_title_name
        self.titleLabel?.font = AppFont.semiBold.size(15)
        self.backgroundColor = AppColor.Shared.colorWhite
        self.setCornerRadius(size: self.frame.height/2)
        
        
    }
    
    
    
    
    
       
}

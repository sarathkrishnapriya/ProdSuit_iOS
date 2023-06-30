//
//  OnboardCustomView.swift
//  ProdSuit
//
//  Created by MacBook on 15/02/23.
//

import Foundation
import UIKit

class OnboardTitleLabel:UILabel{
    
    override func awakeFromNib() {
        self.textColor = AppColor.Shared.p_green
        self.font = AppFonts.Shared.SemiBold
        self.setLineHeight()
        self.textAlignment = .center
        
    }
    
//    override func drawText(in rect: CGRect) {
//        let insets: UIEdgeInsets = UIEdgeInsets(top: 2.0, left: 0.0, bottom: 2.0, right: 0.0)
//        super.drawText(in: rect.inset(by: insets))
//    }
}

class OnboardDetailLabel:UILabel{
    
    override func awakeFromNib() {
        self.textColor = AppColor.Shared.coloBlack
        self.font = UIFont.init(name: "Poppins", size: 13)
        self.textAlignment = .center
        self.setLineHeight(lineHeight: 0.5)
        
    }

}

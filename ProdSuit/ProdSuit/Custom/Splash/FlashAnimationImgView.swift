//
//  FlashAnimationImgView.swift
//  ProdSuit
//
//  Created by MacBook on 13/02/23.
//

import Foundation
import UIKit

class FlashAnimationImgView:UIImageView{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.flash(withDutation:2)
    }
    
    
}



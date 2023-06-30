//
//  ChangeMpinCustomViews.swift
//  ProdSuit
//
//  Created by MacBook on 17/03/23.
//

import Foundation
import UIKit

class ResetMpinLabael:UILabel{
    override func awakeFromNib() {
        self.font = AppFonts.Shared.SemiBold.withSize(17)
        self.text = "Reset MPIN"
        self.textColor = AppColor.Shared.coloBlack
    }
}

class ResetMpinNoteLabael:UILabel{
    override func awakeFromNib() {
        self.font = AppFonts.Shared.Regular.withSize(13)
        self.text = "Enter old and new password to reset your MPIN"
        self.textColor = AppColor.Shared.greyTitle
    }
}

//
//  LeadRequestTVC.swift
//  ProdSuit
//
//  Created by MacBook on 08/05/23.
//

import UIKit

class LeadRequestTVC: UITableViewCell {
    
    

    @IBOutlet weak var assignedLabel: UILabel!{
        didSet{
            self.assignedLabel.font = AppFonts.Shared.Regular.withSize(15)
            self.assignedLabel.textColor = AppColor.Shared.greyText
        }
    }
    @IBOutlet weak var assignedTitleLabel: UILabel!{
        didSet{
            self.assignedTitleLabel.font = AppFonts.Shared.Medium.withSize(15)
            self.assignedTitleLabel.textColor = AppColor.Shared.greyText
        }
    }
    @IBOutlet weak var mobileLabel: UILabel!{
        didSet{
            self.mobileLabel.font = AppFonts.Shared.Regular.withSize(15)
            self.mobileLabel.textColor = AppColor.Shared.greyText
        }
    }
    @IBOutlet weak var mobileTitleLabel: UILabel!{
        didSet{
            self.mobileTitleLabel.font = AppFonts.Shared.Medium.withSize(15)
            self.mobileTitleLabel.textColor = AppColor.Shared.greyText
        }
    }
    @IBOutlet weak var cusmtomerNameLabel: UILabel!{
        didSet{
            self.cusmtomerNameLabel.font = AppFonts.Shared.Regular.withSize(15)
            self.cusmtomerNameLabel.textColor = AppColor.Shared.greyText
        }
    }
    @IBOutlet weak var customerNameTitleLabel: UILabel!{
        didSet{
            self.customerNameTitleLabel.font = AppFonts.Shared.Medium.withSize(15)
            self.customerNameTitleLabel.textColor = AppColor.Shared.greyText
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

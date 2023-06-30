//
//  NotificationTVC.swift
//  ProdSuit
//
//  Created by MacBook on 29/03/23.
//

import UIKit

class NotificationTVC: UITableViewCell {
    
    var viewModel:NotificationDetailsInfo?{
        didSet{
            
            self.notificationTitleLabel.text = viewModel?.Title
            self.notificationDescriptionLabel.text = viewModel?.Message
            self.notificationDateLabel.text = viewModel?.SendOn
            
        }
    }

    @IBOutlet weak var notificationDateLabel: UILabel!
    @IBOutlet weak var notificationDescriptionLabel: UILabel!
    @IBOutlet weak var unReadNotificationImageView: UIImageView!
    @IBOutlet weak var notificationTitleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var notificationImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellConfigure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfigure(){
        self.notificationTitleLabel.font = AppFonts.Shared.Medium.withSize(16)
        self.notificationTitleLabel.textColor = AppColor.Shared.coloBlack
        self.notificationDescriptionLabel.font = AppFonts.Shared.Regular.withSize(14)
        self.notificationDescriptionLabel.textColor = AppColor.Shared.greyTitle
        self.notificationDateLabel.font = AppFonts.Shared.Regular.withSize(12)
        self.notificationDateLabel.textColor = AppColor.Shared.greyText
    }

}

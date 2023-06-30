//
//  LeadGenConfirmTVC.swift
//  ProdSuit
//
//  Created by MacBook on 03/05/23.
//

import UIKit

class LeadGenConfirmTVC: UITableViewCell {

    @IBOutlet weak var noteLabel: UILabel!{
        didSet{
            self.noteLabel.font = AppFont.regular.size(13)
            self.noteLabel.textColor = AppColor.Shared.greyText
        }
    }
    @IBOutlet weak var noteBGView: UIView!
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            self.titleLabel.font = AppFont.medium.size(13)
            self.titleLabel.textColor = AppColor.Shared.greyText
        }
    }
    @IBOutlet weak var tittleBGView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

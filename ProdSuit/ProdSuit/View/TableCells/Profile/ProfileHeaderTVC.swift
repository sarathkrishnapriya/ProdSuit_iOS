//
//  ProfileHeaderTVC.swift
//  ProdSuit
//
//  Created by MacBook on 20/03/23.
//

import UIKit

class ProfileHeaderTVC: UITableViewCell {

    @IBOutlet weak var headerNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellUIConfigure()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellUIConfigure(){
        headerNameLabel.font = AppFonts.Shared.SemiBold.withSize(18)
        headerNameLabel.textColor = AppColor.Shared.coloBlack
    }

}

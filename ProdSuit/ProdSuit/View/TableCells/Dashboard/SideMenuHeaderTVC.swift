//
//  SideMenuHeaderTVC.swift
//  ProdSuit
//
//  Created by MacBook on 09/03/23.
//

import UIKit

class SideMenuHeaderTVC: UITableViewCell {

    @IBOutlet weak var cellDateLabel: UILabel!
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var imageBgView: UIView!
    
    let preference = SharedPreference.Shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellDetails(){
        
        cellNameLabel.text = preference.User_UserName
        cellNameLabel.textColor = AppColor.Shared.colorWhite
        cellNameLabel.font = AppFonts.Shared.Medium.withSize(18)
        cellDateLabel.text = preference.User_LoggedDate
        cellDateLabel.textColor = AppColor.Shared.colorWhite
        cellDateLabel.font = AppFonts.Shared.Regular.withSize(12)
        
        
    }

}

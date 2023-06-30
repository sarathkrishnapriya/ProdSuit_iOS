//
//  ProfileTVC.swift
//  ProdSuit
//
//  Created by MacBook on 20/03/23.
//

import UIKit

class ProfileTVC: UITableViewCell {
    
    var viewModel:ProfileModel?{
        didSet{
            self.cellImageView.image = viewModel?.profileDetailImage
            self.cellTitleName.text = viewModel?.title
            self.cellDetailsLbl.text = viewModel?.description
        
        }
    }

    @IBOutlet weak var imgBGView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    
    @IBOutlet weak var cellTitleName: UILabel!
    @IBOutlet weak var cellDetailsLbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCellDetails()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    func configureCellDetails(){
        
        cellTitleName.text = ""
        cellDetailsLbl.text = ""
        cellTitleName.font = AppFonts.Shared.Medium.withSize(16)
        cellDetailsLbl.font = AppFonts.Shared.Regular.withSize(13)
        cellTitleName.textColor = AppColor.Shared.greyTitle
        cellDetailsLbl.numberOfLines = 0
        cellDetailsLbl.textColor = AppColor.Shared.greyText
        imgBGView.backgroundColor = AppColor.Shared.greyLite
        imgBGView.setCornerRadius(size: 5)
        
    }

}

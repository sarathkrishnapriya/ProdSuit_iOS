//
//  SideMenueContentTVC.swift
//  ProdSuit
//
//  Created by MacBook on 09/03/23.
//

import UIKit

class SideMenueContentTVC: UITableViewCell {

    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var cellCategoryName: UILabel!
    @IBOutlet weak var cellimagView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func menuDetails(_ item:SidMenueModel){
        self.cellimagView.image = item.image
        self.cellimagView.contentMode = .scaleAspectFit
        self.cellCategoryName.font = AppFonts.Shared.Medium.withSize(16)
        self.cellCategoryName.text = item.name
    }
    

}

//
//  LeadManagementInfoTVC.swift
//  ProdSuit
//
//  Created by MacBook on 22/05/23.
//

import UIKit

class LeadManagementInfoTVC: UITableViewCell {
    
   

    @IBOutlet weak var leadTitleLbl: UILabel!
    @IBOutlet weak var leadTextLbl: UILabel!
    @IBOutlet weak var leadImagView: UIImageView!
    
    var vm : (pic:UIImage,title:String,value:String)?{
        didSet{
            self.leadImagView.image = vm?.pic
            self.leadTextLbl.text = vm?.value
            self.leadTitleLbl.text = vm?.title
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

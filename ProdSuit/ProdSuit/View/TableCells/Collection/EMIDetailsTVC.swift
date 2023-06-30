//
//  EMIDetailsTVC.swift
//  ProdSuit
//
//  Created by MacBook on 20/06/23.
//

import UIKit

class EMIDetailsTVC: UITableViewCell {
    
    var viewModel:(title:String,value:String)?{
        didSet{
            if let model = viewModel{
                self.titleNameLbl.setLabelValue(" \(model.title)")
                self.textLbl.setLabelValue(" \(model.value)")
            }
        }
    }

    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var titleNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

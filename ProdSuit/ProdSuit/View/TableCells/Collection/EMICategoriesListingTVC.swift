//
//  EMICategoriesListingTVC.swift
//  ProdSuit
//
//  Created by MacBook on 06/06/23.
//

import UIKit

class EMICategoriesListingTVC: UITableViewCell {

    
    @IBOutlet weak var emiNoBGView: UIView!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var nextEMILbl: UILabel!
    @IBOutlet weak var dueAmountLbl: UILabel!
    @IBOutlet weak var mobilePhoneLbl: UILabel!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var emiNumberLbl: UILabel!
    
    var infoModel:EMICollectionReportModel?{
        didSet{
            emiNumberLbl.setLabelValue(infoModel?.eMINo ?? "")
            customerNameLbl.setLabelValue(infoModel?.customer.capitalized ?? "")
            
            mobilePhoneLbl.setLabelValue(infoModel?.mobile ?? "")
            dueAmountLbl.setLabelValue(infoModel?.dueAmount ?? "")
            let nextEMIDateString = (infoModel?.nextEMIDate ?? "").prefix(10)
            nextEMILbl.setLabelValue(String(nextEMIDateString))
            areaLbl.setLabelValue(infoModel?.area ?? "")
            self.emiNumberLbl.layoutIfNeeded()
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

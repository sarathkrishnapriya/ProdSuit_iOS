//
//  LeadGenerationTVC.swift
//  ProdSuit
//
//  Created by MacBook on 03/04/23.
//

import UIKit

class LeadGenerationTVC: UITableViewCell {
    
    
    var hasLeadSourceFrom:Bool?{
        didSet{
            if hasLeadSourceFrom == false{
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.leadSourceFromTextField.isHidden = true
                    self.leadStacView.layoutIfNeeded()
                })
                
            }else{
                UIView.animate(withDuration: 0.25, animations: {
                    self.leadSourceFromTextField.isHidden = false
                    self.leadStacView.layoutIfNeeded()
                })
            }
        }
    }
    
    
    
    @IBOutlet weak var leadDetailsBGView: UIView!
    @IBOutlet weak var leadStacView: UIStackView!
    @IBOutlet weak var dateTextField: LeadDateTextField!{
        didSet{
            
            dateTextField.setBorder(width: 0.5, borderColor: AppColor.Shared.red_light)
            
        }
    }
    @IBOutlet weak var nameTextField: LeadDetailsNameTextField!
    @IBOutlet weak var leadSourceTextField: LeadDetailSourceField!
    @IBOutlet weak var leadSourceFromTextField: LeadDetailSourceDetailsField!
    
    @IBOutlet weak var leadSourceSubmediaField: LeadDetailSubmediaField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  CustomerDetailsTVC1.swift
//  ProdSuit
//
//  Created by MacBook on 04/04/23.
//

import UIKit

class CustomerDetailsTVC1: UITableViewCell,UITextFieldDelegate{

    
    @IBOutlet weak var searchByTF: LeadCustomerCustNameTF!
    @IBOutlet weak var searchTF: LeadCustomerNameEditSearchTF!{
        didSet{
            searchTF.addDonButton()
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

//
//  ContactUsVC.swift
//  ProdSuit
//
//  Created by MacBook on 17/03/23.
//

import UIKit

class ContactUsVC: UIViewController {
    
    

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    var preference  = SharedPreference.Shared
    
   // var DashboardNavController : UINavigationController?
    
    fileprivate func contactUsDetails() {
        self.nameLbl.text = preference.ProductName
        self.mobileNumberLbl.text = preference.ContactNumber
        self.emailLbl.text = preference.ContactEmail
        self.addressLbl.text = preference.ContactAddress == "" ? "null" : preference.ContactAddress
    }
    
    fileprivate func setUI() {
        self.nameLbl.font = AppFonts.Shared.Regular.withSize(15)
        self.nameLbl.textColor = AppColor.Shared.greyText
        
        self.mobileNumberLbl.font = AppFonts.Shared.Regular.withSize(15)
        self.mobileNumberLbl.textColor = AppColor.Shared.greyText
        
        
        self.emailLbl.font = AppFonts.Shared.Regular.withSize(15)
        self.emailLbl.textColor = AppColor.Shared.greyText
        
        
        self.addressLbl.font = AppFonts.Shared.Regular.withSize(15)
        self.addressLbl.textColor = AppColor.Shared.greyText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()

        contactUsDetails()
        
        
    }
    
    @IBAction func backButtonAction(_ sender: BackButtonCC) {
        let contactUs = AppVC.Shared.ContactUsPage
        if allControllers.contains(contactUs){
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

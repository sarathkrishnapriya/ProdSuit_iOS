//
//  CustomerDetailsTVC3.swift
//  ProdSuit
//
//  Created by MacBook on 04/04/23.
//

import UIKit

protocol CustomerDetailsProtocol:AnyObject{
    func getCustomerDetails(name:String?,contact:String?,whatsapp:String?,company:String?,contact_email:String?)
}

class CustomerDetailsTVC3: UITableViewCell,UITextFieldDelegate {
    
    
    weak var custmerInfoDelegate: CustomerDetailsProtocol?
    @IBOutlet weak var emailTF: LeadCustomerDetailsTF!
    @IBOutlet weak var companyTF: LeadCustomerDetailsTF!
    @IBOutlet weak var whatsAppNumberTF: LeadCustomerDetailsTF!
    @IBOutlet weak var contactNumberTF: LeadCustomerDetailsTF!
    @IBOutlet weak var customerNameTF: LeadCustomerDetailsTF!{
        didSet{
            
            customerNameTF.setBorder(width: 0.5, borderColor: AppColor.Shared.red_light)
            customerNameTF.addDonButton()
            
        }
    }
    @IBOutlet weak var respectTF: LeadCustomerRespectTF!{
        didSet{
            
            respectTF.setBorder(width: 0.5, borderColor: AppColor.Shared.red_light)
            
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customerNameTF.customPlaceholder(color: AppColor.Shared.greyText, text: "Customer Name")
        self.customerNameTF.autocorrectionType = .no
        
        
        self.contactNumberTF.customPlaceholder(color: AppColor.Shared.greyText, text: "Contact No")
        
        self.contactNumberTF.keyboardType = .numberPad
        
        
        self.whatsAppNumberTF.customPlaceholder(color: AppColor.Shared.greyText, text: "WhatsApp No")
        self.whatsAppNumberTF.keyboardType = .numberPad
        
        
        self.companyTF.customPlaceholder(color: AppColor.Shared.greyText, text: "Company/Contact Person")
        self.companyTF.autocorrectionType = .no
        
        self.emailTF.customPlaceholder(color: AppColor.Shared.greyText, text: "Contact Email")
        self.emailTF.autocorrectionType = .no

        self.emailTF.keyboardType = .emailAddress
    
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
    func textFieldDelegateCall(textField:UITextField){
        textField.delegate = self
        textField.addDonButton()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == customerNameTF || textField == contactNumberTF || textField == whatsAppNumberTF || textField == companyTF || textField == emailTF{
            custmerInfoDelegate?.getCustomerDetails(name: customerNameTF.text!, contact: contactNumberTF.text!, whatsapp: whatsAppNumberTF.text!, company: companyTF.text!, contact_email: emailTF.text!)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var currentString : NSString = ""
        var newString : NSString = ""
        
        currentString =  textField.text! as NSString 
        newString = currentString.replacingCharacters(in: range, with: string) as NSString
        if textField == contactNumberTF || textField == whatsAppNumberTF{
            return newString.length <= 12
        }
       

        return true
    }

}


extension LeadGenerationVC:CustomerDetailsProtocol{
    
  
    
    func getCustomerDetails(name: String?, contact: String?, whatsapp: String?, company: String?, contact_email: String?) {
//        print("name:\(name ?? "")")
//        print("contact_number:\(contact ?? "")")
//        print("whatsapp_number:\(whatsapp ?? "")")
//        print("company:\(company ?? "")")
//        print("email:\(contact_email ?? "")")
        
        contactName = name ?? ""
        contact_numbers  = contact ?? ""
        whatsapp_numbers = whatsapp ?? ""
        company_name = company ?? ""
        customer_email  = contact_email ?? ""
        self.selecteCustomerDetailsInfo.CusName = name
        self.selecteCustomerDetailsInfo.CusPhnNo = contact_numbers
        self.selecteCustomerDetailsInfo.whatsapp = whatsapp_numbers
        self.selecteCustomerDetailsInfo.Company = company_name
        emailValidatorVm.email = customer_email
        
        if customer_email != ""{
        if emailValidatorVm.isValidEmail() == true{
            self.selecteCustomerDetailsInfo.CusEmail = customer_email
        }else{
            self.popupAlert(title: "", message: "Enter valid email address", actionTitles: [okTitle], actions: [{action1 in
                
            },nil])
        }
        }
        
    }
    
    
}

//
//  ProjectProductDetailsTVC.swift
//  ProdSuit
//
//  Created by MacBook on 05/04/23.
//

import UIKit

protocol ProductModelDelegate:AnyObject{
    func getProductModel(model:String)
}

protocol ProductEnquiryDelegate:AnyObject{
    func getEnquiryText(text:String)
}

protocol QuantityDelegate:AnyObject{
    func maxQuantity(cell:ProjectProductDetailsTVC,qty:String)
}

class ProjectProductDetailsTVC: UITableViewCell{
    
    fileprivate func enableDisableFollowUpView(isEnabled:Bool) {
        UIView.animate(withDuration: 0.25, animations: {
            self.followUpView.isHidden = true
            self.followUpView.subviews.map{ $0.isHidden = true }
            self.actionTextField.isHidden = isEnabled
            self.actionTypeTextField.isHidden = isEnabled
            self.dateTextField.isHidden = isEnabled
            self.nameTextField.isHidden = isEnabled
            self.dateTextField.dateTodayOnwards = true
            self.productStackView.layoutIfNeeded()
        })
    }
    
    var hasFollowUp:Bool?{
        didSet{
            if hasFollowUp == true{
                
                enableDisableFollowUpView(isEnabled: false)
                
            }else{
                
                enableDisableFollowUpView(isEnabled: true)
                
            }
        }
    }
    
    var isZeroProject:NSNumber = 0{
        didSet{
            if isZeroProject == 0{
                
                self.actionTextField.isHidden = true
                self.subCategoryQtyTextField.isHidden = false
                self.subCategoryTextField.customPlaceholder(color: AppColor.Shared.greyText, text: "Product")
                self.subCategoryTextField.rightView = self.subCategoryTextField.rightSideImageView
                self.subCategoryTextField.rightViewMode = .always
                self.subCategoryTextField.text = ""
                self.subCategoryQtyTextField.keyboardType = .numberPad
                self.subCategoryQtyTextField.addDonButton()
                self.subCategoryTextField.resignFirstResponder()
               
                UIView.animate(withDuration: 0.25, animations: {
                
                    self.layoutIfNeeded()
                    
                })
                
            }else{
               
                
                    self.actionTextField.isHidden = true
                    self.subCategoryQtyTextField.isHidden = true
                    self.subCategoryTextField.customPlaceholder(color: AppColor.Shared.greyText, text: "Model")
                    self.subCategoryTextField.rightView = nil
                self.subCategoryTextField.addDonButton()
                    self.subCategoryTextField.delegate = self
                    self.subCategoryTextField.becomeFirstResponder()
                UIView.animate(withDuration: 0.25, animations: {
                    self.layoutIfNeeded()
                })
                
            }
            
            productListingButtonAdd(isZeroProject: isZeroProject)
        }
    }
    
    
    @IBOutlet weak var productBGView: UIView!
    @IBOutlet weak var productStackView: UIStackView!
    @IBOutlet weak var categoryTextField: ProjectDetailsCategoryTF!{
        didSet{
            
        categoryTextField.setBorder(width: 0.5, borderColor: AppColor.Shared.red_light)
            
        }
    }
    
    @IBOutlet weak var subCategoryStackView: UIStackView!
    @IBOutlet weak var subCategoryTextField: ProjectDetailsProductTF!
    
    @IBOutlet weak var subCategoryQtyTextField: UITextField!
    
    @IBOutlet weak var priorityTextField: ProjectDetailsPriorityTF!{
        didSet{
            
            priorityTextField.setBorder(width: 0.5, borderColor: AppColor.Shared.red_light)
            
        }
    }
    
    @IBOutlet weak var enquiryNoteTextField: ProjectDetailEnquiryNoteTF!{
        didSet{
            
            enquiryNoteTextField.setBorder(width: 0.5, borderColor: AppColor.Shared.red_light)
            
        }
    }
    
    @IBOutlet weak var statusTextField: ProjectDetailsStatusTF!{
        didSet{
            
            statusTextField.setBorder(width: 0.5, borderColor: AppColor.Shared.red_light)
            
        }
    }
    
    
    @IBOutlet weak var followUpView: UIView!
    
    @IBOutlet weak var actionTextField: UITextField!
    
    @IBOutlet weak var actionTypeTextField: ProjectDetailsActionTypeTF!{
        didSet{
            
            actionTypeTextField.setBorder(width: 0.5, borderColor: AppColor.Shared.red_light)
            
        }
    }
    
    @IBOutlet weak var dateTextField: ProjectDetailsDateTF!{
        didSet{
            
            dateTextField.setBorder(width: 0.5, borderColor: AppColor.Shared.red_light)
            
        }
    }
    
    @IBOutlet weak var nameTextField: ProjectDetailsUserTF!
    
    weak var productDelegate : ProductModelDelegate?
    weak var enquiryDelegate : ProductEnquiryDelegate?
    weak var quantityDelegate : QuantityDelegate?
    
    var modelCode:String = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.enquiryNoteTextField.addDonButton()
        self.enquiryNoteTextField.delegate = self
        self.subCategoryQtyTextField.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func productListingButtonAdd(isZeroProject:NSNumber){
        
        var productButtonConstraints = [NSLayoutConstraint]()
        
        productButtonConstraints.append(self.subCategoryTextField.productButton.leadingAnchor.constraint(equalTo: self.subCategoryTextField.leadingAnchor, constant: 0))
        
        productButtonConstraints.append(self.subCategoryTextField.productButton.trailingAnchor.constraint(equalTo: self.subCategoryTextField.trailingAnchor, constant: 0))
        
        productButtonConstraints.append(self.subCategoryTextField.productButton.topAnchor.constraint(equalTo: self.subCategoryTextField.topAnchor, constant: 0))
        
        productButtonConstraints.append(self.subCategoryTextField.productButton.bottomAnchor.constraint(equalTo: self.subCategoryTextField.bottomAnchor, constant: 0))
        
        if isZeroProject == 0{
            self.subCategoryTextField.addSubview(self.subCategoryTextField.productButton)
            
            NSLayoutConstraint.activate(productButtonConstraints)
        }else{
            self.subCategoryTextField.productButton.removeFromSuperview()
            NSLayoutConstraint.deactivate(productButtonConstraints)
        }
    }

}


extension ProjectProductDetailsTVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var currentString : NSString = ""
        var newString : NSString = ""
        
        if textField == subCategoryTextField{
        currentString  = textField.text!  as NSString
        newString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        
        modelCode = newString as String
            return newString.length <= 30
            
        }else{
            
            currentString  = textField.text!  as NSString
            newString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= 80
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == subCategoryTextField{
            productDelegate?.getProductModel(model: modelCode)
        }
        
        if textField == enquiryNoteTextField{
            enquiryDelegate?.getEnquiryText(text: textField.text ?? "")
        }
        
        if textField == subCategoryQtyTextField{
            quantityDelegate?.maxQuantity(cell: self,qty: textField.text!)
        }
        
    }
}

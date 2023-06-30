//
//  MoreCommunicationInfoTVC.swift
//  ProdSuit
//
//  Created by MacBook on 05/04/23.
//

import UIKit

protocol PincodeDelegate:AnyObject{
    func getPinCode(pincode:String)
}
protocol HousePlaceDetailsDelegate:AnyObject{
    func details(house:String?,place:String?)
}

class MoreCommunicationInfoTVC: UITableViewCell,UITextFieldDelegate{
    
    var pincode:String = ""
    var table:UITableView?
    weak var pindelegate : PincodeDelegate?
    weak  var houseplaceDelegate : HousePlaceDetailsDelegate?

    @IBOutlet weak var houseNameTF: LeadMoreInfoTF!{
        didSet{
            self.houseNameTF.autocorrectionType = .no
            self.houseNameTF.customPlaceholder(color: AppColor.Shared.greyText, text: "House Name")
        }
    }
    @IBOutlet weak var placeNameTF: LeadMoreInfoTF!{
        didSet{
            self.houseNameTF.autocorrectionType = .no
            self.placeNameTF.customPlaceholder(color: AppColor.Shared.greyText, text: "Place")
        }
    }
    @IBOutlet weak var pincodeTF: LeadMorePinCodeTF!
    
    @IBOutlet weak var countryTF: LeadMoreListingTF!{
        didSet{
            self.countryTF.customPlaceholder(color: AppColor.Shared.greyText, text: "Country")
        }
    }
    @IBOutlet weak var stateTF: LeadMoreListingTF!{
        didSet{
            self.stateTF.customPlaceholder(color: AppColor.Shared.greyText, text: "State")
        }
    }
    
    @IBOutlet weak var districtTF: LeadMoreListingTF!{
        didSet{
            self.districtTF.customPlaceholder(color: AppColor.Shared.greyText, text: "District")
        }
    }
    
    @IBOutlet weak var locationTF: LeadMoreListingTF!{
        didSet{
            self.locationTF.customPlaceholder(color: AppColor.Shared.greyText, text: "Area")
        }
    }
    @IBOutlet weak var postTF: LeadMoreListingTF!{
        didSet{
            self.postTF.customPlaceholder(color: AppColor.Shared.greyText, text: "Post")
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
    
    func textFieldDelegateCall(textField:UITextField,tableView:UITableView){
        textField.delegate = self
        houseNameTF.addDonButton()
        placeNameTF.addDonButton()
        houseNameTF.delegate = self
        placeNameTF.delegate = self
        textField.addDonButton()
        
        table = tableView
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == houseNameTF || textField == placeNameTF{
            houseplaceDelegate?.details(house: houseNameTF.text!, place: placeNameTF.text)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var currentString : NSString = ""
        var newString : NSString = ""
        if textField == pincodeTF{
        currentString =  textField.text! as NSString
        newString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        pincode = newString as String
        
        pindelegate?.getPinCode(pincode: pincode)
        
        
        
        return newString.length <= 6
        }
        return true
    }

}

extension LeadGenerationVC : HousePlaceDetailsDelegate{
    func details(house: String?, place: String?) {
        self.selectedDefaultValue.Place = place ?? ""
        self.selectedDefaultValue.address = house ?? ""
        print(self.selectedDefaultValue)
    }
    
    
}

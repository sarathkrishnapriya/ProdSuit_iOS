//
//  ProfileModels.swift
//  ProdSuit
//
//  Created by MacBook on 20/03/23.
//

import Foundation
import UIKit

struct ProfileModel {
    
    
    var profileDetailImage:UIImage
    var title :String
    var description : String
    
}

var preference = SharedPreference.Shared

let bankKey = preference.appBankKey


let fk_employee = "\(preference.User_Fk_Employee)"


let fk_company = "\(preference.User_FK_Company)"


let token = preference.User_Token


let entrBy = preference.User_UserCode


let fk_branchCodeUser = "\(preference.User_FK_BranchCodeUser)"


let fk_branch = "\(preference.User_FK_Branch)"


let fk_department = "\(preference.User_FK_DepartMent)"




var profileDetilsList : [ProfileModel] = [ProfileModel(profileDetailImage: UIImage(named: "ic_prof_address")!,title: "ADDRESS", description: preference.User_Address),ProfileModel(profileDetailImage: UIImage(named: "ic_prof_dob")!,title: "DATE OF BIRTH", description: "01/01/1990"),ProfileModel(profileDetailImage: UIImage(named: "ic_prof_email")!,title: "EMAIL", description: preference.User_Email),ProfileModel(profileDetailImage: UIImage(named: "ic_prof_mobile")!,title: "MOBILE", description: preference.User_MobileNumber)]



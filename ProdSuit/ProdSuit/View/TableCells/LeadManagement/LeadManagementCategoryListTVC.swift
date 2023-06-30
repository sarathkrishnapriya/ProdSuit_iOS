//
//  LeadManagementCategoryListTVC.swift
//  ProdSuit
//
//  Created by MacBook on 11/05/23.
//

import UIKit

class LeadManagementCategoryListTVC: UITableViewCell {
    
    
    
    
    fileprivate func hideMessageView(hide:Bool=false) {
        self.messageView.subviews.map{ $0.isHidden = hide }
        self.messageView.isHidden = hide
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    var fromItem : String = "todo"{
        didSet{
            switch fromItem{
            case "overdue" :
                 hideMessageView()
                 setColor(AppColor.Shared.overdue_Color)
            case "upcoming":
                hideMessageView()
                setColor(AppColor.Shared.upcomung_Color)
            case "mylead":
                hideMessageView(hide: true)
                setColor(AppColor.Shared.leadManageMyLead)
            default:
                hideMessageView()
                setColor(AppColor.Shared.todolist_Color)
            }
        }
    }

    @IBOutlet weak var mainBGView: UIView!
    @IBOutlet weak var mainStackView: UIStackView!{
        didSet{
            mainStackView.layer.masksToBounds = false
            mainStackView.layer.shadowRadius = 2
            mainStackView.layer.shadowOpacity = 0.5
            mainStackView.layer.shadowColor = AppColor.Shared.greydark.cgColor
            mainStackView.layer.shadowOffset = CGSize(width: 0 , height:2)
        }
    }
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var thirdStackView: UIStackView!
    
    @IBOutlet weak var leadNumberView: RoundCornerView!
    
    @IBOutlet weak var leadNoLbl: LMTicketLB!
    @IBOutlet weak var preferenceImgView: UIImageView!
    @IBOutlet weak var preferenceLbl: LMPriorityLB!
    @IBOutlet weak var dateLbl: LMDateLB!
    
    @IBOutlet weak var lgCusNameLbl: LMLNameLB!
    @IBOutlet weak var cusAddressLbl: LMLAddressLB!
    @IBOutlet weak var lgCusMobileLbl: LMLMobLB!
    @IBOutlet weak var ppNameLbl: LMLProductLB!
    
    @IBOutlet weak var nextActionDateLbl: LMLActionDateLB!
    @IBOutlet weak var actionLbl: LMLActionLB!
    @IBOutlet weak var lgCollectedByLbl: UILabel!
    
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var bellView: UIView!
    @IBOutlet weak var bellImageView: UIImageView!
    
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var bellButton: UIButton!
    
    
    var viewModelInfo : LeadManagementDetailsInfo?{
        didSet{
            if let info = viewModelInfo{
                self.leadNoLbl.text = info.LeadNo
                self.leadNumberView.setCornerRadius(size: self.leadNumberView.frame.height/2)
                self.setPreferenceImage(info, imageView: self.preferenceImgView)
                self.dateLbl.text = info.LgLeadDate
                self.lgCusNameLbl.text = info.LgCusName.capitalized
                self.cusAddressLbl.text = info.CusAddress == "" ? "nil" : info.CusAddress
                self.lgCusMobileLbl.text = info.LgCusMobile == "" ? "nil" : info.LgCusMobile
                
                self.ppNameLbl.text = info.ProdName == "" ? "Project Name : \(info.ProjectName)" : "Product Name : \(info.ProdName)"
                self.nextActionDateLbl.text = "Next Action Date : \(info.NextActionDate)"
                self.actionLbl.text = "Next Action : \(info.Action)"
                self.lgCollectedByLbl.text = "Collected By : \(info.LgCollectedBy)"
                
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainBGView.addShadow(width: 0, height: 4)
        
    }
    
    func setColor(_ color:UIColor){
        
        self.firstView.setBGColor(color: color)
            self.thirdView.setBGColor(color: AppColor.Shared.colorWhite)
    
    }
    
    func setPreferenceImage(_ preference:LeadManagementDetailsInfo,imageView:UIImageView){
        switch preference.Preference{
        case "Hot":
            imageView.image = UIImage(named: "preference2")
            imageView.tintColor = AppColor.Shared.ColorHot
            
        case "Cold":
            imageView.image = UIImage(named: "preference1")
            imageView.tintColor = AppColor.Shared.ColorCold
            
        default:
            imageView.image = UIImage(named: "preference3")
            imageView.tintColor = AppColor.Shared.ColorWarm
        }
        self.preferenceLbl.text = preference.Preference
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

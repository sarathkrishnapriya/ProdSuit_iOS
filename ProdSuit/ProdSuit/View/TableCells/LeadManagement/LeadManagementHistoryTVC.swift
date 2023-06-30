//
//  LeadManagementHistoryTVC.swift
//  ProdSuit
//
//  Created by MacBook on 22/05/23.
//

import UIKit

class LeadManagementHistoryTVC: UITableViewCell {

    @IBOutlet weak var enquiryView: UIView!
    @IBOutlet weak var enquiryTitleLbl: UILabel!
    @IBOutlet weak var enquiryTextLbl: UILabel!{
        didSet{
            self.enquiryTextLbl.numberOfLines = 2
            self.enquiryTextLbl.lineBreakMode = .byWordWrapping
            self.enquiryTextLbl.sizeToFit()
            
        }
    }
    
    @IBOutlet weak var actionView: UIView!
    
    @IBOutlet weak var actionTextLbl: UILabel!
    @IBOutlet weak var actionTitleLbl: UILabel!
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var actionTypeView: UIView!
    @IBOutlet weak var actionTypeTitleLbl: UILabel!
    @IBOutlet weak var actionTypeTextLbl: UILabel!
    
    @IBOutlet weak var actionDateView: UIView!
    @IBOutlet weak var actionDateTitleLbl: UILabel!
    @IBOutlet weak var actionDateTextLbl: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusTitleLbl: UILabel!
    @IBOutlet weak var statusTextLbl: UILabel!
    
    @IBOutlet weak var agentView: UIView!
    @IBOutlet weak var agentTitleLbl: UILabel!
    @IBOutlet weak var agentTextLbl: UILabel!
    
    
    @IBOutlet weak var followByView: UIView!
    @IBOutlet weak var followByTitleLbl: UILabel!
    @IBOutlet weak var followByTextLbl: UILabel!{
        didSet{
            self.followByTextLbl.numberOfLines = 2
            self.followByTextLbl.lineBreakMode = .byWordWrapping
            self.followByTextLbl.sizeToFit()
            
        }
    }
    
    var vm:LeadActivitiesDetailsModel?{
        didSet{
            self.enquiryTextLbl.text = vm?.EnquiryAbout
            vm?.EnquiryAbout == "" ? hideEmptyView(true, enquiryView) : hideEmptyView(false, enquiryView)
            self.actionTextLbl.text = vm?.Action
            vm?.Action == "" ? hideEmptyView(true, actionView) : hideEmptyView(false, actionView)
            self.actionTypeTextLbl.text = vm?.ActionType
            vm?.ActionType == "" ? hideEmptyView(true, actionTypeView) : hideEmptyView(false, actionTypeView)
            self.actionDateTextLbl.text = vm?.ActionDate
            vm?.ActionDate == "" ? hideEmptyView(true, actionDateView) : hideEmptyView(false, actionDateView)
            self.statusTextLbl.text = vm?.Status
            vm?.Status == "" ? hideEmptyView(true, statusView) : hideEmptyView(false, statusView)
            self.agentTextLbl.text = vm?.Agentremarks
            vm?.Agentremarks == "" ? hideEmptyView(true, agentView) : hideEmptyView(false, agentView)
            self.followByTextLbl.text = vm?.FollowedBy
            vm?.FollowedBy == "" ? hideEmptyView(true, followByView) : hideEmptyView(false, followByView)
            
        }
    }
    
    func hideEmptyView(_ hidden:Bool=false,_ hideView:UIView)  {
        _ = hideView.subviews.map{ $0.isHidden = hidden }
        hideView.isHidden = hidden
        UIView.animate(withDuration: 0.2) {
            
            self.mainStackView.layoutIfNeeded()
        }
    }
    
    
    
    @IBOutlet weak var bgView: UIView!
    
    
    func bgGradient(_ bgViews:UIView){
  
//        let fistColor = AppColor.Shared.histroyBgColor2
//
//        let lastColor = AppColor.Shared.histroyBgColor3
//
//        let gradient = CAGradientLayer(start: .topLeft, end: .bottomRight, colors:[fistColor.cgColor,lastColor.cgColor], type: .axial)
//                    gradient.frame = bgView.bounds
//        bgViews.layer.insertSublayer(gradient, at: 0)
        bgViews.setBGColor(color: AppColor.Shared.histroyBgColor2)
        bgViews.layer.masksToBounds = false
        bgViews.layer.shadowRadius = 2
        bgViews.layer.shadowOpacity = 0.5
        bgViews.layer.shadowColor = AppColor.Shared.greydark.cgColor
        bgViews.layer.shadowOffset = CGSize(width: 0 , height:3)
        bgViews.setCornerRadius(size: 6)
        
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
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

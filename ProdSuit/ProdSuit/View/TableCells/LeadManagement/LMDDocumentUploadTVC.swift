//
//  LMDDocumentUploadTVC.swift
//  ProdSuit
//
//  Created by MacBook on 25/05/23.
//

import UIKit

class LMDDocumentUploadTVC: UITableViewCell {

    @IBOutlet weak var downLoadButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var vm:LMDDocumentDetailsModel?{
       didSet{
           self.titleLabel.text = vm?.DocumentSubject.capitalized
           self.titleLabel.lineBreakMode = .byWordWrapping
           self.titleLabel.numberOfLines = 0
           self.titleLabel.sizeToFit()
            self.descriptionLabel.text = vm?.DocumentDescription 
            self.dateLabel.text = vm?.DocumentDate
        }
    }
    
    func bgGradient(_ bgViews:UIView){
  

        bgViews.setBGColor(color: AppColor.Shared.histroyBgColor2)
        bgViews.layer.masksToBounds = false
        bgViews.layer.shadowRadius = 2
        bgViews.layer.shadowOpacity = 0.5
        bgViews.layer.shadowColor = AppColor.Shared.histroyBgColor3.cgColor
        bgViews.layer.shadowOffset = CGSize(width: 0 , height:3)
        bgViews.setCornerRadius(size: 1)
        
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
        
    }
    
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

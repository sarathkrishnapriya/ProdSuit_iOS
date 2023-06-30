//
//  DashboardMenuCVC.swift
//  ProdSuit
//
//  Created by MacBook on 08/03/23.
//

import UIKit

class DashboardMenuCVC: UICollectionViewCell {
    
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var menuImageView: UIImageView!
    
    @IBOutlet weak var menuTitle: UILabel!
    
    var notificationLabelConstraints = [NSLayoutConstraint]()
    
    lazy var notificationLabel : UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.text = "12345"
        label.sizeToFit()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .justified
        label.font = AppFonts.Shared.Regular.withSize(10)
        label.textColor = AppColor.Shared.colorWhite
        
        return label
        
    }()
    
    
    func fetchMenuDetails(info:MenuModel,_ notReadCount:Int){
        self.menuImageView.image = info.image
        self.menuImageView.transform = CGAffineTransform.init(scaleX: 1.15, y: 1.15)
        self.menuTitle.font = AppFonts.Shared.Medium.withSize(10.55)
        if (info.hasNotification == true && info.name == "Notification" && notReadCount > 0){
            notificationLabelConstraintsAdd()
            self.notificationLabel.text = "  \(notReadCount)  "
        }else{
            removeNotificationLabel()
        }
        self.menuTitle.text = info.name
    }
    
    func notificationLabelConstraintsAdd(){
        
        self.bgView.addSubview(notificationLabel)
        self.bgView.bringSubviewToFront(notificationLabel)
        notificationLabel.backgroundColor = AppColor.Shared.colorPrimary
        //menuImageView.backgroundColor = UIColor.red
        //notificationLabel.setCornerRadius(size: 5)
        
        
        //notificationLabelConstraints.append(notificationLabel.heightAnchor.constraint(equalToConstant: 20))
        //let notificationSize = self.notificationLabel.frame.size
        notificationLabelConstraints.append(notificationLabel.topAnchor.constraint(equalTo: self.menuImageView.topAnchor, constant: -5))
        
        
        notificationLabelConstraints.append(notificationLabel.leadingAnchor.constraint(equalTo: self.menuImageView.leadingAnchor, constant: self.menuImageView.frame.width/2))
        NSLayoutConstraint.activate(notificationLabelConstraints)
        
        //notificationLabel.padding = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        notificationLabel.setCornerRadius(size: 3)
        
        
    }
    
    func removeNotificationLabel(){
        NSLayoutConstraint.deactivate(notificationLabelConstraints)
        notificationLabel.removeFromSuperview()
    }
    
    
    
    override func awakeFromNib() {
        bgView.setCornerRadius(size: 6)
        bgView.setBorder(width: 0.25, borderColor: AppColor.Shared.companyLog)
        bgView.addShadow(width: 0, height: 4, color: AppColor.Shared.coloBlack, opacity: 1)
        self.menuTitle.numberOfLines = 0
        self.menuTitle.lineBreakMode = .byWordWrapping
        self.menuTitle.adjustsFontSizeToFitWidth = true
        self.menuTitle.minimumScaleFactor = 0.75
    }
    
    
}

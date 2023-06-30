//
//  PaymentMethodAddTVC.swift
//  ProdSuit
//
//  Created by MacBook on 23/06/23.
//

import UIKit

class PaymentMethodAddTVC: UITableViewCell {

    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var balanceView: TextFieldWithNameView!{
        didSet{
            balanceView.HeaderNameLabel.setLabelValue(" Amount")
            balanceView.HeaderDetailTF.isUserInteractionEnabled = false
            balanceView.HeaderDetailTF.setBorder(width: 1, borderColor: AppColor.Shared.colorWhite)
            balanceView.HeaderNameLabel.setTextColor(AppColor.Shared.greyText)
            balanceView.HeaderNameLabel.setFontSize(12, font: .medium)
            balanceView.HeaderDetailTF.setFontSize(14, font: .regular)
            balanceView.leftSideImageView.image = UIImage.init(named: "ic_emi_amount")
            balanceView.leftSideImageView.transform = CGAffineTransform.init(scaleX: 0.65, y: 0.65)
        }
    }
    @IBOutlet weak var referenceView: TextFieldWithNameView!{
        didSet{
            referenceView.HeaderNameLabel.setLabelValue(" Reference No.")
            referenceView.HeaderDetailTF.isUserInteractionEnabled = false
            referenceView.HeaderDetailTF.setFontSize(14, font: .regular)
            referenceView.HeaderNameLabel.setTextColor(AppColor.Shared.greyText)
            referenceView.HeaderNameLabel.setFontSize(12, font: .medium)
            referenceView.leftSideImageView.image = UIImage.init(named: "ic_emi_amount")
            referenceView.leftSideImageView.transform = CGAffineTransform.init(scaleX: 0.65, y: 0.65)
            referenceView.HeaderDetailTF.setBorder(width: 1, borderColor: AppColor.Shared.colorWhite)
        }
    }
    @IBOutlet weak var methodView: TextFieldWithNameView!{
        didSet{
            methodView.HeaderNameLabel.setLabelValue(" Method")
            methodView.HeaderDetailTF.isUserInteractionEnabled = false
            methodView.HeaderDetailTF.setFontSize(14, font: .regular)
            methodView.HeaderNameLabel.setTextColor(AppColor.Shared.greyText)
            methodView.HeaderNameLabel.setFontSize(12, font: .medium)
            methodView.leftSideImageView.image = UIImage.init(named: "ic_emi_amount")
            methodView.leftSideImageView.transform = CGAffineTransform.init(scaleX: 0.65, y: 0.65)
            methodView.HeaderDetailTF.setBorder(width: 1, borderColor: AppColor.Shared.colorWhite)
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

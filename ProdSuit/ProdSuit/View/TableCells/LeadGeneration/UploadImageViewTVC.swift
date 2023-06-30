//
//  UploadImageViewTVC.swift
//  ProdSuit
//
//  Created by MacBook on 05/04/23.
//

import UIKit

class UploadImageViewTVC: UITableViewCell {

    @IBOutlet weak var uploadSecondImageView: UploadImageView!
    @IBOutlet weak var uploadFirstImageView: UploadImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

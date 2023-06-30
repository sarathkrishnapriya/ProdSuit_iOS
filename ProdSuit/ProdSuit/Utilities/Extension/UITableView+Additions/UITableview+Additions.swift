//
//  UITableview+Additions.swift
//  ProdSuit
//
//  Created by MacBook on 12/05/23.
//

import Foundation
import UIKit

extension UITableView{
    
    func tableHasItems(){
        self.backgroundView = nil
    }
    
    func tableIsEmpty(_ imageName:String="ic_no_data",_ message:String = "Loading....",_ color:UIColor) {
        
        
        lazy var stackImageView : UIImageView = {
            let imgView = UIImageView()
            let getImageName = imageName == "" ? "ic_no_data" : imageName
            let getImage  = UIImage(named: getImageName)?.withTintColor(color)
            imgView.image = getImage
            imgView.translatesAutoresizingMaskIntoConstraints = false
           // imgView.backgroundColor = AppColor.Shared.color_warning
            return imgView
        }()
        
        
        lazy var stackLabel : UILabel = {
            let lbl = UILabel()
            lbl.text = message
            lbl.setTextColor(color)
            lbl.textAlignment = .center
            lbl.numberOfLines = 0
            //lbl.translatesAutoresizingMaskIntoConstraints = false
          //  lbl.backgroundColor = AppColor.Shared.green1
            lbl.setFontSize(13, font: .medium)
            return lbl
        }()
        
        lazy var tableStackView : UIStackView = {
            let  stack = UIStackView()
       
            stack.axis = .vertical
            stack.distribution = .fill
            stack.spacing = 8
            stack.alignment = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
           // stack.backgroundColor = AppColor.Shared.purple_500
            return stack
        }()
        
        
  
        //tableStackView.addArrangedSubview(stackLabel)
        
        
    
        self.backgroundView = stackLabel
        
        
        
    }
}

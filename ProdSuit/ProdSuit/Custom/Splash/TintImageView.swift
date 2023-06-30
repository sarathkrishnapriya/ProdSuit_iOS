//
//  TintImageView.swift
//  ProdSuit
//
//  Created by MacBook on 13/02/23.
//

import UIKit

class TintImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tintColorChangeMethod()
    }
    
    private var changeColor : UIColor?
    
    init(changeColor:UIColor=UIColor.white) {
        self.changeColor = changeColor
        super.init(frame: .zero)
        tintColorChangeMethod()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tintColorChangeMethod()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //tintColorChangeMethod()
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tintColorChangeMethod()
    }
    
   
    
    
    
    private func tintColorChangeMethod(){
        
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
        
            self.image = self.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            self.tintColor = UIColor.white
        }
        
        
        //self.flash()
        
    }
    
    
    
}

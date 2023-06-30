//
//  AppFontHelper.swift
//  ProdSuit
//
//  Created by MacBook on 14/02/23.
//

import Foundation
import UIKit

private let familyName = "Poppins"

enum AppFont : String {
    
    case light = "Light"
    case extra_light = "ExtraLight"
    case medium = "Medium"
    case bold = "Bold"
    case extra_bold = "ExtraBold"
    case thin = "Thin"
    case semiBold = "SemiBold"
    case regular = "Regular"
    
    func size(_ size: CGFloat) -> UIFont {
            if let font = UIFont(name: fullFontName, size: size + 1.0) {
                return font
            }
        
        return UIFont()
            //fatalError("Font '\(fullFontName)' does not exist.")
    }
    
    fileprivate var fullFontName: String {
            return rawValue.isEmpty ? familyName : familyName + "-" + rawValue
    }
}



struct AppFonts{
    
    static let Shared = AppFonts()
    
    
    let Regular : UIFont = AppFont.regular.size(14)
   
    let Medium : UIFont = AppFont.medium.size(15)
    let Bold : UIFont = AppFont.bold.size(16)
    let SemiBold : UIFont = AppFont.semiBold.size(17)
    let ExtraBold : UIFont = AppFont.extra_bold.size(18)
    let Thin : UIFont = AppFont.thin.size(12)
    
    
}



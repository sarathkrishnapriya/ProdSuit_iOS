//
//  StringExtension.swift
//  ProdSuit
//
//  Created by MacBook on 20/02/23.
//

import Foundation
import UIKit



extension StringProtocol{
 
    
    var maskedString:String{
        return String(repeating: "•", count: 1)
    }
    
    func encodedForm()->String{
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self as! String }
            return String(self.dropFirst(prefix.count))
        }
    
    
    
    
}


extension String{
    
    func width(withHeight constrainedHeight: CGFloat, font: UIFont) -> CGFloat {
            let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: constrainedHeight)
            let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
            return ceil(boundingBox.width)
        }
        
        func height(withWidth constrainedWidth: CGFloat, font: UIFont) -> CGFloat {
            let constraintRect = CGSize(width: constrainedWidth, height: .greatestFiniteMagnitude)
            let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
            
      
            return ceil(boundingBox.height)
        }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
           let fontAttributes = [NSAttributedString.Key.font: font]
           let size = self.size(withAttributes: fontAttributes)
           return size.width
       }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

//extension Array where Generator.Element == [String:AnyObject] {
//    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
//        if let arr = self as? [[String:AnyObject]],
//           let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
//           let str = String(data: dat, encoding: String.Encoding.utf8) {
//            return str
//        }
//        return "[]"
//    }
//}

extension Data {
    private static let mimeTypeSignatures: [UInt8 : String] = [
        0xFF : "image/jpeg",
        0x89 : "image/png",
        0x47 : "image/gif",
        0x49 : "image/tiff",
        0x4D : "image/tiff",
        0x25 : "application/pdf",
        0xD0 : "application/vnd",
        0x46 : "text/plain",
        ]

    var mimeType: String {
        var c: UInt8 = 0
        copyBytes(to: &c, count: 1)
        return Data.mimeTypeSignatures[c] ?? "application/octet-stream"
    }
}



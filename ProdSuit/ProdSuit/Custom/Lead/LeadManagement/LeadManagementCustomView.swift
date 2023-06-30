//
//  LeadManagementCustomView.swift
//  ProdSuit
//
//  Created by MacBook on 09/05/23.
//

import Foundation
import UIKit

class PendingCountLabel:UILabel{
    
    override func awakeFromNib() {
        
        self.font = AppFonts.Shared.Regular.withSize(14)
        self.minimumScaleFactor = 0.7
        self.adjustsFontSizeToFitWidth = true
        self.textColor = AppColor.Shared.colorWhite
    }
}

class PendingCountTitleLabel:UILabel{
    
    override func awakeFromNib() {
        
        self.font = AppFonts.Shared.Medium.withSize(16)
        
    }
}

class FilterLabel:UILabel{
    override func awakeFromNib() {
        
        self.font = AppFonts.Shared.Medium.withSize(17)
        self.textColor = AppColor.Shared.coloBlack
        self.textAlignment = .center
    }
}

class FilterTF:UITextField{
    override func awakeFromNib() {
        
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.customPlaceholder(color: AppColor.Shared.hintTextColor, text: "Employee")
        self.setCornerRadius(size: 5)
        self.textAlignment = .left
        self.setBorder(width: 0.75, borderColor: AppColor.Shared.textColor)
        
    }
}

class FilterListEmployeeTF:UITextField{
    override func awakeFromNib() {
        
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.customPlaceholder(color: AppColor.Shared.hintTextColor, text: self.placeholder ?? "")
        self.setCornerRadius(size: 5)
        self.textAlignment = .left
        self.inputView = UIView()
        self.setBorder(width: 0.75, borderColor: AppColor.Shared.textColor)
        
    }
}


class FilterListTF:UITextField{
    override func awakeFromNib() {
        
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.customPlaceholder(color: AppColor.Shared.hintTextColor, text: self.placeholder ?? "")
        self.setCornerRadius(size: 5)
        self.textAlignment = .left
        self.tintColor = AppColor.Shared.greyText
        self.setBorder(width: 0.75, borderColor: AppColor.Shared.textColor)
        
        
        
    }
    
    
    
    
}

class FilterRightViewTF:UITextField{
    
    lazy var rightSideImageView : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = rightDownImage
        return imageview
    }()
    
    override func awakeFromNib() {
        self.inputView = UIView()
        self.font = AppFonts.Shared.Regular.withSize(15)
        self.textColor = AppColor.Shared.greyText
        self.customPlaceholder(color: AppColor.Shared.hintTextColor, text: self.placeholder ?? "")
        self.inputView = UIView()
        self.setCornerRadius(size: 5)
        self.textAlignment = .left
        self.setBorder(width: 0.75, borderColor: AppColor.Shared.textColor)
       
        
        self.rightView = rightSideImageView
        
        self.rightViewMode = .always
    }
    
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 8
        let width  = 18
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = (Int(self.frame.height) - height)/2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
}

class FilterSubmitBtn:UIButton{
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func awakeFromNib() {
        self.titleLabel?.textColor = AppColor.Shared.colorWhite
        self.titleLabel?.text = "OK"
        self.titleLabel?.font = AppFont.semiBold.size(15)
        self.backgroundColor = AppColor.Shared.color_submit2
        
        
        
    }

}

class FilterCancelBtn:UIButton{
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func awakeFromNib() {
        self.titleLabel?.textColor = AppColor.Shared.coloBlack
        self.titleLabel?.text = "CANCEL"
        self.titleLabel?.font = AppFont.semiBold.size(15)
        self.backgroundColor = AppColor.Shared.color_reset1
        
        
        
    }

}

class LMPriorityLB:UILabel{
    
    override func awakeFromNib() {
        self.setTextColor(AppColor.Shared.colorWhite)
        self.setFontSize(11, font: .regular)
    }
}

class LMDateLB:UILabel{
    
    override func awakeFromNib() {
        self.setTextColor(AppColor.Shared.colorWhite)
        self.setFontSize(11, font: .medium)
    }
}

class LMTicketLB:UILabel{
    
    override func awakeFromNib() {
        self.setTextColor(AppColor.Shared.coloBlack)
        self.setFontSize(13, font: .medium)
    }
}

class LMLNameLB:UILabel{
    
    override func awakeFromNib() {
        self.setTextColor(AppColor.Shared.coloBlack)
        self.setFontSize(18, font: .semiBold)
    }
}

class LMLAddressLB:UILabel{
    
    override func awakeFromNib() {
        self.setTextColor(AppColor.Shared.greyText)
        self.setFontSize(13, font: .regular)
    }
}

class LMLMobLB:UILabel{
    
    override func awakeFromNib() {
        self.setTextColor(AppColor.Shared.greyText)
        self.setFontSize(13, font: .regular)
    }
}

class LMLProductLB:UILabel{
    
    override func awakeFromNib() {
        self.setTextColor(AppColor.Shared.greyText)
        self.setFontSize(10, font: .regular)
    }
}

class LMLActionDateLB:UILabel{
    
    override func awakeFromNib() {
        self.setTextColor(AppColor.Shared.greyText)
        self.setFontSize(10, font: .regular)
    }
}

class LMLActionLB:UILabel{
    
    override func awakeFromNib() {
        self.setTextColor(AppColor.Shared.greyText)
        self.setFontSize(10, font: .regular)
    }
}

class LMLCollectedByLB:UILabel{
    
    override func awakeFromNib() {
        self.setTextColor(AppColor.Shared.greyText)
        self.setFontSize(10, font: .regular)
    }
}


class LMMSubmitBtn:UIButton{
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func awakeFromNib() {
        self.titleLabel?.textColor = AppColor.Shared.colorWhite
        self.titleLabel?.text = "Submit"
        self.titleLabel?.font = AppFont.semiBold.size(15)
        self.backgroundColor = AppColor.Shared.p_green
        
        
        
    }

}

class LMMCancelBtn:UIButton{
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func awakeFromNib() {
        self.titleLabel?.textColor = AppColor.Shared.coloBlack
        self.titleLabel?.text = "Cancel"
        self.titleLabel?.font = AppFont.semiBold.size(15)
        self.backgroundColor = AppColor.Shared.greydark
        
        
        
    }

}

class MessageBGView:UIView{
    override func awakeFromNib() {
        self.setCornerRadius(size: 5)
        self.setBGColor(color: AppColor.Shared.colorWhite)
    }
}

class LmmessageView:UIView{
    override func awakeFromNib() {
        self.setCornerRadius(size: 5)
        self.setBGColor(color: AppColor.Shared.colorWhite)
        self.setBorder(width: 0.45, borderColor: AppColor.Shared.lmMessageTab)
    }
}

class LmmessageTexview:UITextView{
    override func awakeFromNib() {
        self.setFontSize(13, font: .regular)
        self.setTextColor(AppColor.Shared.coloBlack)
      
    }
}

class LmmessageCheckboxLb:UILabel{
    override func awakeFromNib() {
        self.setFontSize(13, font: .medium)
        self.setTextColor(AppColor.Shared.coloBlack)
      
    }
}

class LMDHistoryTitleLbl:UILabel{
    override func awakeFromNib() {
        
        self.setFontSize(12, font: .medium)
        self.setTextColor(AppColor.Shared.colorPrimary)
    }
}

class LMDHistoryTextLbl:UILabel{
    override func awakeFromNib() {
        
        self.setFontSize(12, font: .regular)
        self.setTextColor(AppColor.Shared.colorPrimary)
    }
}

class LMDLeadNameLbl:UILabel{
    override func awakeFromNib() {
        
        self.setFontSize(15, font: .semiBold)
        self.setTextColor(AppColor.Shared.colorWhite)
    }
}

class LMDLeadAddressLbl:UILabel{
    override func awakeFromNib() {
        
        self.setFontSize(12, font: .regular)
        self.setTextColor(AppColor.Shared.colorWhite)
    }
}

class LMDLeadPhoneLbl:UILabel{
    override func awakeFromNib() {
        
        self.setFontSize(12, font: .regular)
        self.setTextColor(AppColor.Shared.colorWhite)
    }
}

class LMDLeadContactLbl:UILabel{
    override func awakeFromNib() {
        
        self.setFontSize(13, font: .medium)
        self.setTextColor(AppColor.Shared.coloBlack)
    }
}

class LMDLeadTitleLabl:UILabel{
    override func awakeFromNib() {
        
        self.setFontSize(12, font: .medium)
        self.setTextColor(AppColor.Shared.coloBlack)
    }
}

class LMDLeadTextLabl:UILabel{
    override func awakeFromNib() {
        
        self.setFontSize(15, font: .regular)
        self.setTextColor(AppColor.Shared.greydark)
    }
}


class LMCDDocUploadTF:UITextField{
    
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = UIImage(named: "ic_lm_attach")
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var leftSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    var imageConstraint = [NSLayoutConstraint]()
    
    override func awakeFromNib() {
        
        
        
        self.leftView = leftSideView
        self.leftViewMode = .always
        self.setBorder(width: 0.65, borderColor: AppColor.Shared.greydark)
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        self.setCornerRadius(size: 5)
        self.setTextColor(AppColor.Shared.greyText)
        self.setFontSize(14, font: .regular)
        self.autocorrectionType = .no
        self.tintColor = AppColor.Shared.greyText
       
        
    
        
    }
}

protocol LMCDDocUploadDateDelegate:AnyObject{
    func getDate(date:String)
}

class LMCDDocUploadDateTF:UITextField{
    
    weak var docDateDeleagate : LMCDDocUploadDateDelegate?
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = calendarImage
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    let calendarImage:UIImage = UIImage(named: "leadcalendar")!
    let datePickerView = UIDatePicker()
    
    lazy var leftSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    var imageConstraint = [NSLayoutConstraint]()
    
    override func awakeFromNib() {
        
        
        
        self.leftView = leftSideView
        self.leftViewMode = .always
        self.setBorder(width: 0.65, borderColor: AppColor.Shared.greydark)
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        self.setCornerRadius(size: 5)
        self.setTextColor(AppColor.Shared.greyText)
        self.setFontSize(14, font: .regular)
        self.text = DateTimeModel.shared.stringDateFromDate(Date())
        self.tintColor = UIColor.clear
        initializeDate()
    }
       
        func initializeDate(){
            datePickerView.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePickerView.preferredDatePickerStyle = .compact
            } else {
                // Fallback on earlier versions
            }
            self.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        
        }
        
       @objc func datePickerValueChanged(sender:UIDatePicker) {

                let dateFormatter = DateFormatter()

                dateFormatter.dateStyle = DateFormatter.Style.medium

                dateFormatter.timeStyle = DateFormatter.Style.none

               self.text = DateTimeModel.shared.stringDateFromDate(sender.date)
            self.docDateDeleagate?.getDate(date: DateTimeModel.shared.stringDateFromDate(sender.date))
               self.resignFirstResponder()

            }
    
        
    
}

class LMMResetBtn:UIButton{
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func awakeFromNib() {
        self.titleLabel?.textColor = AppColor.Shared.coloBlack
        self.titleLabel?.text = "Reset"
        self.titleLabel?.font = AppFont.semiBold.size(15)
        self.backgroundColor = AppColor.Shared.color_reset1
        
        
        
    }

}

class LMCDDocUploadTextView:UITextView{
    override func awakeFromNib() {
       
        self.setFontSize(15, font: .regular)
        self.setTextColor(AppColor.Shared.greyText)
        self.autocorrectionType = .no
        self.tintColor = AppColor.Shared.greyText
              
          
    }
}

class LMCDocumentUploadTitleLBL:UILabel{
    override func awakeFromNib() {
        self.setFontSize(14, font: .regular,autoScale: true)
        self.setTextColor(AppColor.Shared.colorPrimary)
    }
    
}
class LMCDocumentUploadMsgLBL:UILabel{
    override func awakeFromNib() {
        self.setFontSize(11, font: .regular,autoScale: true)
        self.setTextColor(AppColor.Shared.colorPrimary)
    }
}

class LMCDocumentUploadTimeLBL:UILabel{
    override func awakeFromNib() {
        self.setFontSize(10, font: .regular,autoScale: true)
        self.setTextColor(AppColor.Shared.coloBlack)
    }
}



class FollowUpActionTypeTF:UITextField{
    
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = UIImage(named: "fd_actiontype ")
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var rightSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = rightDownImage!
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var leftSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    lazy var rightSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    override func awakeFromNib() {
        self.setBorder(width: 0.6, borderColor: AppColor.Shared.coloBlack)
        self.setCornerRadius(size: 5)
        self.leftView = leftSideView
        self.leftViewMode = .always
        self.rightView = rightSideView
        self.rightViewMode = .always
        self.setTextColor(AppColor.Shared.greydark)
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        
        rightSideView.addSubview(rightSideImageView)
        rightSideImageView.center = rightSideView.center
       
        
        self.setFontSize(14, font: .regular)
        self.inputView = UIView()
        self.tintColor = UIColor.clear
    }
    
    
}


class FollowUpByTF:UITextField{
    
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = UIImage(named: "followupby")
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var rightSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = rightDownImage!
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var leftSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    lazy var rightSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    override func awakeFromNib() {
        self.setBorder(width: 0.6, borderColor: AppColor.Shared.coloBlack)
        self.setCornerRadius(size: 5)
        self.leftView = leftSideView
        self.leftViewMode = .always
        self.rightView = rightSideView
        self.rightViewMode = .always
        self.setTextColor(AppColor.Shared.greydark)
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        
        rightSideView.addSubview(rightSideImageView)
        rightSideImageView.center = rightSideView.center
       
        
        self.setFontSize(14, font: .regular)
        self.inputView = UIView()
        self.tintColor = UIColor.clear
    }
    
    
}

class FollowUpStatusTF:UITextField{
    
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = UIImage(named: "fd_status")
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var rightSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = rightDownImage!
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var leftSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    lazy var rightSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    override func awakeFromNib() {
        self.setBorder(width: 0.6, borderColor: AppColor.Shared.coloBlack)
        self.setCornerRadius(size: 5)
        self.leftView = leftSideView
        self.leftViewMode = .always
        self.rightView = rightSideView
        self.rightViewMode = .always
        self.setTextColor(AppColor.Shared.greydark)
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        
        rightSideView.addSubview(rightSideImageView)
        rightSideImageView.center = rightSideView.center
       
        
        self.setFontSize(14, font: .regular)
        self.inputView = UIView()
        self.tintColor = UIColor.clear
    }
    
    
}


class FollowUpCallTF:UITextField{
    
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = UIImage(named: "fd_callstatus")
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var rightSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = rightDownImage!
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var leftSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    lazy var rightSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    override func awakeFromNib() {
        self.setBorder(width: 0.6, borderColor: AppColor.Shared.coloBlack)
        self.setCornerRadius(size: 5)
        self.leftView = leftSideView
        self.leftViewMode = .always
        self.rightView = rightSideView
        self.rightViewMode = .always
        self.setTextColor(AppColor.Shared.greydark)
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        
        rightSideView.addSubview(rightSideImageView)
        rightSideImageView.center = rightSideView.center
       
        
        self.setFontSize(14, font: .regular)
        self.inputView = UIView()
        self.tintColor = UIColor.clear
    }
    
    
}


class FollowUPDateTF:UITextField{
    
    weak var docDateDeleagate : LMCDDocUploadDateDelegate?
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = calendarImage
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    let calendarImage:UIImage = UIImage(named: "fd_date")!
    let datePickerView = UIDatePicker()
    
    lazy var leftSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    var imageConstraint = [NSLayoutConstraint]()
    
    override func awakeFromNib() {
        
        
        
        self.leftView = leftSideView
        self.leftViewMode = .always
        self.setBorder(width: 0.65, borderColor: AppColor.Shared.greydark)
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        self.setCornerRadius(size: 5)
        self.setTextColor(AppColor.Shared.greyText)
        self.setFontSize(14, font: .regular)
        self.text = DateTimeModel.shared.stringDateFromDate(Date())
        self.tintColor = UIColor.clear
        initializeDate()
    }
       
        func initializeDate(){
            datePickerView.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePickerView.preferredDatePickerStyle = .compact
            } else {
                // Fallback on earlier versions
            }
            self.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        
        }
        
       @objc func datePickerValueChanged(sender:UIDatePicker) {

                let dateFormatter = DateFormatter()

                dateFormatter.dateStyle = DateFormatter.Style.medium

                dateFormatter.timeStyle = DateFormatter.Style.none

               self.text = DateTimeModel.shared.stringDateFromDate(sender.date)
            self.docDateDeleagate?.getDate(date: DateTimeModel.shared.stringDateFromDate(sender.date))
               self.resignFirstResponder()

            }
    
        
    
}


class FollowUpLocationTF:UITextField{
    
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = UIImage(named: "fd_latitude")
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
   
    
    lazy var leftSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
  
    
    override func awakeFromNib() {
        self.setBorder(width: 0.6, borderColor: AppColor.Shared.coloBlack)
        self.setCornerRadius(size: 5)
        self.leftView = leftSideView
        self.leftViewMode = .always
       
        self.setTextColor(AppColor.Shared.greydark)
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        
       
       
        
        self.setFontSize(14, font: .regular)
        self.inputView = UIView()
        self.tintColor = UIColor.clear
    }
    
    
}


class FollowUpTextView:UITextView{
    override func awakeFromNib() {
        
        self.setCornerRadius(size: 5)
        self.tintColor = AppColor.Shared.greydark
        self.setTextColor(AppColor.Shared.greydark)
        self.setFontSize(14, font: .regular)
    }
}

class FollowUpUploadLabel:UILabel{
    override func awakeFromNib() {
        self.setFontSize(14, font: .medium)
        self.setTextColor(AppColor.Shared.greydark)
    }
}

class FollowUpSegmentLabel:UILabel{
    override func awakeFromNib() {
        self.setFontSize(16, font: .medium)
        self.setTextColor(AppColor.Shared.coloBlack)
    }
}

class NextActionTF:UITextField{
    
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = UIImage(named: "na_action")
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var rightSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = rightDownImage!
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var leftSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    lazy var rightSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    override func awakeFromNib() {
        self.setBorder(width: 0.6, borderColor: AppColor.Shared.coloBlack)
        self.setCornerRadius(size: 5)
        self.leftView = leftSideView
        self.leftViewMode = .always
        self.rightView = rightSideView
        self.rightViewMode = .always
        self.setTextColor(AppColor.Shared.greydark)
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        
        rightSideView.addSubview(rightSideImageView)
        rightSideImageView.center = rightSideView.center
       
        
        self.setFontSize(14, font: .regular)
        self.inputView = UIView()
        self.tintColor = UIColor.clear
    }
    
    
}


class NextActionDateTF:UITextField{
    
    weak var docDateDeleagate : LMCDDocUploadDateDelegate?
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = calendarImage
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    let calendarImage:UIImage = UIImage(named: "fd_nextfollowdate")!
    let datePickerView = UIDatePicker()
    
    lazy var leftSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    var imageConstraint = [NSLayoutConstraint]()
    
    override func awakeFromNib() {
        
        
        
        self.leftView = leftSideView
        self.leftViewMode = .always
        self.setBorder(width: 0.65, borderColor: AppColor.Shared.greydark)
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        self.setCornerRadius(size: 5)
        self.setTextColor(AppColor.Shared.greyText)
        self.setFontSize(14, font: .regular)
        //self.text = DateTimeModel.shared.stringDateFromDate(Date())
        self.tintColor = UIColor.clear
        initializeDate()
    }
       
        func initializeDate(){
            datePickerView.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePickerView.preferredDatePickerStyle = .compact
            } else {
                // Fallback on earlier versions
            }
            self.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        
        }
        
       @objc func datePickerValueChanged(sender:UIDatePicker) {

                let dateFormatter = DateFormatter()

                dateFormatter.dateStyle = DateFormatter.Style.medium

                dateFormatter.timeStyle = DateFormatter.Style.none

               self.text = DateTimeModel.shared.stringDateFromDate(sender.date)
            self.docDateDeleagate?.getDate(date: DateTimeModel.shared.stringDateFromDate(sender.date))
               self.resignFirstResponder()

            }
    
        
    
}


class NextActionPriorityTF:UITextField{
    
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = UIImage(named: "fd_priority")
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var rightSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = rightDownImage!
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var leftSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    lazy var rightSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    override func awakeFromNib() {
        self.setBorder(width: 0.6, borderColor: AppColor.Shared.coloBlack)
        self.setCornerRadius(size: 5)
        self.leftView = leftSideView
        self.leftViewMode = .always
        self.rightView = rightSideView
        self.rightViewMode = .always
        self.setTextColor(AppColor.Shared.greydark)
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        
        rightSideView.addSubview(rightSideImageView)
        rightSideImageView.center = rightSideView.center
       
        
        self.setFontSize(14, font: .regular)
        self.inputView = UIView()
        self.tintColor = UIColor.clear
    }
    
    
}

class NextActionDepartMentTF:UITextField{
    
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = UIImage(named: "fd_department")
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var rightSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = rightDownImage!
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var leftSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    lazy var rightSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    override func awakeFromNib() {
        self.setBorder(width: 0.6, borderColor: AppColor.Shared.coloBlack)
        self.setCornerRadius(size: 5)
        self.leftView = leftSideView
        self.leftViewMode = .always
        self.rightView = rightSideView
        self.rightViewMode = .always
        self.setTextColor(AppColor.Shared.greydark)
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        
        rightSideView.addSubview(rightSideImageView)
        rightSideImageView.center = rightSideView.center
       
        
        self.setFontSize(14, font: .regular)
        self.inputView = UIView()
        self.tintColor = UIColor.clear
    }
    
    
}

class NextActionEmployeeTF:UITextField{
    
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = UIImage(named: "fd_employee")
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var rightSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.image = rightDownImage!
        imgView.tintColor = AppColor.Shared.greydark
        return imgView
    }()
    
    lazy var leftSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    lazy var rightSideView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        //containerView.backgroundColor = AppColor.Shared.purple_500
        
        return containerView
    }()
    
    override func awakeFromNib() {
        self.setBorder(width: 0.6, borderColor: AppColor.Shared.coloBlack)
        self.setCornerRadius(size: 5)
        self.leftView = leftSideView
        self.leftViewMode = .always
        self.rightView = rightSideView
        self.rightViewMode = .always
        self.setTextColor(AppColor.Shared.greydark)
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        
        rightSideView.addSubview(rightSideImageView)
        rightSideImageView.center = rightSideView.center
       
        
        self.setFontSize(14, font: .regular)
        self.inputView = UIView()
        self.tintColor = UIColor.clear
    }
    
    
}




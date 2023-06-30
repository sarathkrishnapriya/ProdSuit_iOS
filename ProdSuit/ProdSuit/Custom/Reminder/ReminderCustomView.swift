//
//  ReminderCustomView.swift
//  ProdSuit
//
//  Created by MacBook on 15/03/23.
//

import Foundation
import UIKit

class ReminderView:UIView{
    
    override func awakeFromNib() {
        self.setCornerRadius(size: 5)
    }
    
    
}

class ReminderTF:UITextField{
    
    lazy var leftImgView:UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = AppColor.Shared.colorPrimary
        //imageView.backgroundColor = AppColor.Shared.colorPrimary
        return imageView
    }()
    
    let bgView = UIView()
    
    let datePickerView = UIDatePicker()
    
    fileprivate func initializeDatePicker() {
        
        self.tintColor = UIColor.clear
        datePickerView.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .compact
        } else {
            // Fallback on earlier versions
        }
        self.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
    }
    
    override func awakeFromNib() {
        self.leftView = bgView
        self.leftViewMode = .always
        self.setCornerRadius(size: 5)
        self.setBorder(width: 0.5, borderColor: UIColor.gray)
        self.text = DateTimeModel.shared.stringDateFromDate(Date())
        initializeDatePicker()
        
        
        setUI()
        
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {

            let dateFormatter = DateFormatter()

            dateFormatter.dateStyle = DateFormatter.Style.medium

            dateFormatter.timeStyle = DateFormatter.Style.none

           self.text = DateTimeModel.shared.stringDateFromDate(sender.date)
           self.resignFirstResponder()

        }
    
    func setUI(){
        
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(leftImgView)
       // bgView.backgroundColor =  AppColor.Shared.purple_200
        var bgConstraint = [NSLayoutConstraint]()
        
        bgConstraint.append(bgView.leadingAnchor.constraint(equalTo: self.leftView!.leadingAnchor, constant: 0))
        bgConstraint.append(bgView.trailingAnchor.constraint(equalTo: self.leftView!.trailingAnchor, constant: 0))
        bgConstraint.append(bgView.topAnchor.constraint(equalTo: self.leftView!.topAnchor, constant: 0))
        bgConstraint.append(bgView.bottomAnchor.constraint(equalTo: self.leftView!.bottomAnchor, constant: 0))
        
        bgConstraint.append(bgView.widthAnchor.constraint(equalToConstant: 40))
        bgConstraint.append(bgView.heightAnchor.constraint(equalToConstant: 35))
        
        NSLayoutConstraint.activate(bgConstraint)
        
        var imageConstraints = [NSLayoutConstraint]()

        imageConstraints.append(leftImgView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor, constant: 0))


        imageConstraints.append(leftImgView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor, constant: 0))

        imageConstraints.append(leftImgView.widthAnchor.constraint(equalToConstant: 20))
        imageConstraints.append(leftImgView.heightAnchor.constraint(equalToConstant: 20))
        
        NSLayoutConstraint.activate(imageConstraints)
        
        
    }
    
}

class ReminderTimeTF:UITextField{
    
    lazy var leftImgView:UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = AppColor.Shared.colorPrimary
        //imageView.backgroundColor = AppColor.Shared.colorPrimary
        return imageView
    }()
    
    let bgView = UIView()
    
    let datePickerView = UIDatePicker()
    
    fileprivate func initializeDatePicker() {
        self.tintColor = UIColor.clear
        datePickerView.datePickerMode = .time
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .compact
        } else {
            // Fallback on earlier versions
        }
        self.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: .valueChanged)
        
        
    }
    
    override func awakeFromNib() {
        self.leftView = bgView
        self.leftViewMode = .always
        self.setCornerRadius(size: 5)
        self.setBorder(width: 0.5, borderColor: UIColor.gray)
        self.text = DateTimeModel.shared.stringTimeFromDate(Date())
        initializeDatePicker()
        
        
        setUI()
        
    }
    
    @objc func timePickerValueChanged(sender:UIDatePicker) {

            

        self.text = DateTimeModel.shared.stringTimeFromDate(sender.date)
        self.resignFirstResponder()

        }
    
    func setUI(){
        
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(leftImgView)
       // bgView.backgroundColor =  AppColor.Shared.purple_200
        var bgConstraint = [NSLayoutConstraint]()
        
        bgConstraint.append(bgView.leadingAnchor.constraint(equalTo: self.leftView!.leadingAnchor, constant: 0))
        bgConstraint.append(bgView.trailingAnchor.constraint(equalTo: self.leftView!.trailingAnchor, constant: 0))
        bgConstraint.append(bgView.topAnchor.constraint(equalTo: self.leftView!.topAnchor, constant: 0))
        bgConstraint.append(bgView.bottomAnchor.constraint(equalTo: self.leftView!.bottomAnchor, constant: 0))
        
        bgConstraint.append(bgView.widthAnchor.constraint(equalToConstant: 40))
        bgConstraint.append(bgView.heightAnchor.constraint(equalToConstant: 35))
        
        NSLayoutConstraint.activate(bgConstraint)
        
        var imageConstraints = [NSLayoutConstraint]()

        imageConstraints.append(leftImgView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor, constant: 0))


        imageConstraints.append(leftImgView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor, constant: 0))

        imageConstraints.append(leftImgView.widthAnchor.constraint(equalToConstant: 20))
        imageConstraints.append(leftImgView.heightAnchor.constraint(equalToConstant: 20))
        
        NSLayoutConstraint.activate(imageConstraints)
        
        
    }
    
}

class ReminderButtonView:UIView{
    override func awakeFromNib() {
        self.setCornerRadius(size: 6)
    }
}

class ReminderTextView:UITextView{
    override func awakeFromNib() {
        self.setCornerRadius(size: 6)
        self.textContainerInset = UIEdgeInsets(top: 7, left: 5, bottom: 7, right: 5)
        self.setBorder(width: 0.5, borderColor: UIColor.gray)
    }
}

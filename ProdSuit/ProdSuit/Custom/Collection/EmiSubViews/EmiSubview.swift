//
//  EmiSubview.swift
//  ProdSuit
//
//  Created by MacBook on 08/06/23.
//

import Foundation
import UIKit


class EmiInfomationView:UIView{
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}

class TextFieldWithNameView:UIView{
    
    var titleName:String=""
    
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.tintColor = AppColor.Shared.coloBlack
        return imgView
    }()
    
     lazy var leftSideView: UIView = {
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
            //containerView.backgroundColor = AppColor.Shared.purple_500
            
            return containerView
        }()
        
    lazy var HeaderNameLabel:UILabel={
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setFontSize(12, font: .medium)
        lb.numberOfLines = 0
        lb.setTextColor(AppColor.Shared.coloBlack)
        
       return lb
    }()
        
        
    
    lazy var HeaderDetailTF:UITextField={
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setTextColor(AppColor.Shared.greydark)
        tf.setFontSize(14, font: .regular)
        tf.setBorder(width: 1, borderColor: AppColor.Shared.D6D6D6)
        tf.setCornerRadius(size: 5)
        return tf
    }()
    
    lazy var HTFStackView:UIStackView={
        let st = UIStackView(arrangedSubviews: [HeaderNameLabel,HeaderDetailTF])
        st.alignment = .leading
      
        st.distribution = .fillProportionally
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .vertical
        
        return st
    }()
    
    override func awakeFromNib() {
        self.HeaderDetailTF.leftView = leftSideView
        self.HeaderDetailTF.leftViewMode = .always
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI(){
        
        self.addSubview(HTFStackView)
        
        self.HeaderNameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        self.HeaderDetailTF.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.HTFStackView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        self.HTFStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
       
    }
    
}

class TableHeaderView:UIView{
    
    lazy var titleLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setLabelValue("List")
        lbl.textAlignment = .center
        lbl.setFontSize(15, font: .medium)
        lbl.setTextColor(AppColor.Shared.greydark)
        lbl.setBGColor(color: UIColor.clear)
    
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI(){
        self.setBGColor(color: AppColor.Shared.D6D6D6)
        self.addSubview(titleLbl)
        self.titleLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.titleLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }

    
}

class TransDateView:UIView{
    
    var titleName:String=""
    var datePickerView = UIDatePicker()
    
    lazy var leftSideImageView:UIImageView={
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.tintColor = AppColor.Shared.coloBlack
        return imgView
    }()
    
     lazy var leftSideView: UIView = {
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
            //containerView.backgroundColor = AppColor.Shared.purple_500
            
            return containerView
        }()
    
    
    lazy var HeaderNameLabel:UILabel={
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setFontSize(12, font: .medium)
        lb.numberOfLines = 0
        lb.setTextColor(AppColor.Shared.coloBlack)
        
       return lb
    }()
    
    lazy var HeaderDetailTF:UITextField={
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setTextColor(AppColor.Shared.greydark)
        tf.setFontSize(14, font: .regular)
        tf.tintColor = UIColor.clear
        tf.setBorder(width: 1, borderColor: AppColor.Shared.D6D6D6)
        tf.setCornerRadius(size: 5)
        return tf
    }()
    
    lazy var HTFStackView:UIStackView={
        let st = UIStackView(arrangedSubviews: [HeaderNameLabel,HeaderDetailTF])
        st.alignment = .leading
      
        st.distribution = .fillProportionally
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .vertical
        
        return st
    }()
    
   
    
    override func awakeFromNib() {
        self.HeaderDetailTF.leftView = leftSideView
        self.HeaderDetailTF.leftViewMode = .always
        leftSideView.addSubview(leftSideImageView)
        leftSideImageView.center = leftSideView.center
        initialzeDatePicker()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func initialzeDatePicker(){
        datePickerView.datePickerMode = .date
        datePickerView.tag = 0
        
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .compact
        } else {
            // Fallback on earlier versions
        }
        
        HeaderDetailTF.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {

             let dateFormatter = DateFormatter()

             dateFormatter.dateStyle = DateFormatter.Style.medium

             dateFormatter.timeStyle = DateFormatter.Style.none

        self.HeaderDetailTF.text = DateTimeModel.shared.stringDateFromDate(sender.date)
            self.HeaderDetailTF.resignFirstResponder()
            

        }
    
    
    
    func setUI(){
        
        self.addSubview(HTFStackView)
        
        self.HeaderNameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        self.HeaderDetailTF.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.HTFStackView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        self.HTFStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
       
    }
    
}


protocol ClosingDelegate:AnyObject{
    func hasCloseBalance(closed:Bool)
}

class BalanceView:UIView{
    
    
    var amount:String = "1,102,123.00"
    weak var closeBalanceDelegate : ClosingDelegate?
    
    lazy var balanceAmountLbl:UILabel={
        let lb = UILabel()
        lb.setFontSize(15, font: .regular)
        lb.setTextColor(AppColor.Shared.coloBlack)
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var balanceTitleLbl:UILabel={
        let lb = UILabel()
        lb.setFontSize(15, font: .medium)
        lb.setTextColor(AppColor.Shared.coloBlack)
        lb.setLabelValue("Balance : ")
        return lb
    }()
    
    lazy var balanceClosingLbl:UILabel={
        let lb = UILabel()
        lb.setFontSize(15, font: .medium)
        lb.setTextColor(AppColor.Shared.coloBlack)
        lb.setLabelValue("Closing")
        return lb
    }()
    
    let amountCheckedImg = UIImage.init(named: "checkmark")
    let amountUnCheckedImg = UIImage.init(named: "uncheckmark")
    
    lazy var closingImgview:UIImageView={
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.isUserInteractionEnabled = true
        imgView.image = amountUnCheckedImg
        return imgView
    }()
    
    
    
    var isSettledAmount:Bool=false{
        didSet{
            closingImgview.image = isSettledAmount == false ? amountUnCheckedImg : amountCheckedImg
        }
    }
    
    lazy var closingStackView:UIStackView={
        let st = UIStackView(arrangedSubviews: [closingImgview,balanceClosingLbl])
        st.alignment = .leading
        
        st.spacing = 10
        st.distribution = .fillProportionally
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .horizontal
        
        return st
    }()
    
    lazy var BalanceStackView:UIStackView={
        let st = UIStackView(arrangedSubviews: [balanceTitleLbl,balanceAmountLbl])
        st.alignment = .leading
        
        st.distribution = .fillProportionally
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .horizontal
        
        return st
    }()
    
    
    
    lazy var AmountStackView:UIStackView={
        let st = UIStackView(arrangedSubviews: [BalanceStackView,closingStackView])
        st.alignment = .leading
        st.spacing = 10
       
        st.distribution = .fillProportionally
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .horizontal
        
        return st
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUPUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUPUI()
    }
    
    func setUPUI(){
        
        self.addSubview(AmountStackView)
        
        
        
        self.AmountStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        
        self.AmountStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
        self.AmountStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        self.AmountStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
//       let amountStackHeightConstraint =  self.AmountStackView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 25)
//
//        amountStackHeightConstraint.priority = UILayoutPriority.init(rawValue: 600)
//        amountStackHeightConstraint.isActive = true
        
        self.closingImgview.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.closingImgview.heightAnchor.constraint(equalToConstant: 24).isActive = true
       
        self.balanceTitleLbl.widthAnchor.constraint(equalToConstant: (self.balanceTitleLbl.text?.widthOfString(usingFont: AppFont.medium.size(15)))!).isActive = true
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(closingButtonAction(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.closingImgview.addGestureRecognizer(tapGesture)
        self.BalanceStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6, constant: 0).isActive = true
        
    }
    
    @objc func closingButtonAction(_ tap :UITapGestureRecognizer){
        self.isSettledAmount = !isSettledAmount
        self.closeBalanceDelegate?.hasCloseBalance(closed: self.isSettledAmount)
        print(self.isSettledAmount)
    }
    
    
    
}

class NetAmountView:UIView{
    
    var amount : String = "20,203.00"
    
    lazy var topLineView : UIView = {
        let line = UIView()
        line.setBGColor(color: AppColor.Shared.D6D6D6)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    
    lazy var NetAmountTitleLabel : UILabel = {
        
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setLabelValue("Net Amount *")
        lb.setFontSize(17, font: .semiBold)
        lb.setTextColor(AppColor.Shared.coloBlack)
        return lb
    }()
    
    lazy var NetAmountLabel : UILabel = {
        
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
//        lb.setLabelValue("\(amount)")
        lb.setFontSize(16, font: .regular)
        lb.setTextColor(AppColor.Shared.coloBlack)
        return lb
        
    }()
    
    lazy var NetAmountWordLabel : UILabel = {
        
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        //lb.setLabelValue("One Thousand One Hundrud Eighty Four and Eighteen Paise Only")
        lb.numberOfLines = 0
        lb.setFontSize(12, font: .regular)
        lb.setTextColor(AppColor.Shared.purple_500)
        return lb
        
    }()
    
    
    lazy var NetAmountStackView:UIStackView={
        let sv = UIStackView(arrangedSubviews: [topLineView,NetAmountTitleLabel,NetAmountLabel,NetAmountWordLabel])
        sv.spacing = 2
        sv.axis = .vertical
        sv.distribution = .fill
       
        sv.alignment = .leading
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    
    
    func setupUI(){
        
        
        self.addSubview(NetAmountStackView)
        
        self.NetAmountTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        topLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        topLineView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -16).isActive = true
        
        
        let wordLabelHeightConstriant = self.NetAmountWordLabel.heightAnchor.constraint(equalToConstant: 13)
        wordLabelHeightConstriant.priority = UILayoutPriority.init(rawValue: 500)
        wordLabelHeightConstriant.isActive = true
        
        self.NetAmountStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        
        self.NetAmountStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.NetAmountStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    
        self.NetAmountStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        
        
        let heightAnchor = self.NetAmountStackView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 16)
        
        heightAnchor.priority = UILayoutPriority.init(rawValue: 600)
        
        heightAnchor.isActive = true
        
        
        
        
//        topLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
//        topLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
//        topLineView.bottomAnchor.constraint(equalTo: NetAmountStackView.topAnchor, constant: 8).isActive = true
       
        
        
        
    }
}


class EMITodoListNameLbl:UILabel{
    override func awakeFromNib() {
    
        self.setTextColor(AppColor.Shared.coloBlack)
        self.setFontSize(16, font: .semiBold)
    }
}

class EMITodoListTitleLbl:UILabel{
    override func awakeFromNib() {
    
        self.setTextColor(AppColor.Shared.coloBlack)
        self.setFontSize(13, font: .medium)
    }
}

class EMITodoListTextLbl:UILabel{
    override func awakeFromNib() {
    
        self.setTextColor(AppColor.Shared.coloBlack)
        self.setFontSize(13, font: .regular)
    }
}

class EMIDetailsInfoTitleLbl:UILabel{
    override func awakeFromNib() {
    
        self.setTextColor(AppColor.Shared.coloBlack)
        self.setFontSize(13, font: .medium)
    }
}

class EMIDetailsInfoValueLbl:UILabel{
    override func awakeFromNib() {
    
        self.setTextColor(AppColor.Shared.coloBlack)
        self.setFontSize(13, font: .regular)
    }
}

class EMIPaymentLbl:UILabel{
    override func awakeFromNib() {
    
        self.setTextColor(AppColor.Shared.colorWhite)
        self.setFontSize(14, font: .regular)
        self.setCornerRadius(size: 4)
    }
}

class PopUPTitleLbl:UILabel{
    override func awakeFromNib() {
    
        self.setTextColor(AppColor.Shared.coloBlack)
        self.setFontSize(15, font: .medium)
        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}

class SubmitButton:UIButton{
    override func awakeFromNib() {
    
        

        self.backgroundColor = AppColor.Shared.colorPrimary
        
        
        self.titleLabel?.textColor = AppColor.Shared.colorWhite
       
        self.titleLabel?.font = AppFont.medium.size(14)
        
        self.setCornerRadius(size: 4)

    }
}

class ClearButton:UIButton{
    override func awakeFromNib() {
    
        

        self.backgroundColor = AppColor.Shared.D6D6D6
        
        
        self.titleLabel?.textColor = AppColor.Shared.coloBlack
       
        self.titleLabel?.font = AppFont.medium.size(14)
        
        self.setCornerRadius(size: 4)

    }
}

class WhiteTintColorImageView:UIImageView{
    override func awakeFromNib() {
      let image =  self.image?.imageWithColor(color1: AppColor.Shared.colorWhite)
        self.image = image
    }
}

class PrimaryTintColorImageView:UIImageView{
    override func awakeFromNib() {
      let image =  self.image?.imageWithColor(color1: AppColor.Shared.colorPrimary)
        self.image = image
    }
}


class ApplyButton:UIButton{
    override func awakeFromNib() {
    
        

        self.backgroundColor = AppColor.Shared.colorPrimary
        
        
        self.titleLabel?.textColor = AppColor.Shared.colorWhite
       
        self.titleLabel?.font = AppFont.medium.size(14)
        
        self.setCornerRadius(size: 4)

    }
}

class PaymentBackButton:UIButton{
    override func awakeFromNib() {
    
        

        self.backgroundColor = AppColor.Shared.D6D6D6
        
        
        self.titleLabel?.textColor = AppColor.Shared.coloBlack
       
        self.titleLabel?.font = AppFont.medium.size(14)
        
        self.setCornerRadius(size: 4)

    }
}




//
//  ReusableTVC.swift
//  ProdSuit
//
//  Created by MacBook on 14/04/23.
//

import UIKit

class ReusableTVC: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var indexBGView: UIView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    
    @IBOutlet weak var infoStackview: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         cellConfigure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfigure(){
        
        titleTextLabel.font = AppFont.regular.size(15)
        titleTextLabel.textColor = AppColor.Shared.greyText
        
        detailLabel.font = AppFont.regular.size(13)
        detailLabel.textColor = AppColor.Shared.greyText
        
        otherLabel.font = AppFont.regular.size(13)
        otherLabel.textColor = AppColor.Shared.greyText
        
        
    }

}

class SubtitleTableViewCell: UITableViewCell {
    
    lazy var bgView:UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
       // view.backgroundColor = AppColor.Shared.greypink
        return view
    }()
    
    lazy var horizontalStack : UIStackView = {
      
      let stack = UIStackView(arrangedSubviews: [indexView,dataView])
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fill
        //stack.backgroundColor = AppColor.Shared.teal_200
        stack.translatesAutoresizingMaskIntoConstraints = false
      return stack
    }()
    
    lazy var VStack : UIStackView = {
      
      let stack = UIStackView(arrangedSubviews: [titleLabel,detailsLabel,otherLabel])
        stack.axis = .vertical
        stack.spacing = 1
        stack.distribution = .fill
       // stack.backgroundColor = AppColor.Shared.teal_700
        stack.translatesAutoresizingMaskIntoConstraints = false
      return stack
    }()
    
    lazy var titleLabel:UILabel = {
       
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFont.regular.size(15)
        label.textColor = AppColor.Shared.greyText
        
        return label
    }()
    
    lazy var detailsLabel:UILabel = {
       
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFont.regular.size(13)
        label.textColor = AppColor.Shared.greyText
        
        
        return label
    }()
    
    lazy var otherLabel:UILabel = {
       
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFont.regular.size(13)
        label.textColor = AppColor.Shared.greyText
        return label
    }()
    
    lazy var indexView : UIView = {
        let view = UIView()
       
        return view
    }()
    
    lazy var dataView : UIView = {
        let view = UIView()
       // view.backgroundColor = AppColor.Shared.ColorWarm
        return view
    }()
    
    
    
    lazy var separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Shared.greyText.withAlphaComponent(0.75)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var indexLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AppColor.Shared.greyText
        label.font = AppFonts.Shared.Regular.withSize(14)
        label.sizeToFit()
        
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    func addcontentView(cell:UITableViewCell) {
        
        indexView.addSubview(indexLabel)
        dataView.addSubview(VStack)
        horizontalStack.addSubview(separatorView)
        bgView.addSubview(horizontalStack)
        cell.addSubview(bgView)
        
        var HStackConstraint = [NSLayoutConstraint]()
        HStackConstraint.append(horizontalStack.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 0))
        HStackConstraint.append(horizontalStack.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -20))
        
        
        HStackConstraint.append(horizontalStack.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 1))
        HStackConstraint.append(horizontalStack.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -2))
        
       

        NSLayoutConstraint.activate(HStackConstraint)
         
        
        var bgconstraint = [NSLayoutConstraint]()
         bgconstraint.append(bgView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0))
         bgconstraint.append(bgView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0))
         bgconstraint.append(bgView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0))
        bgconstraint.append(bgView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 0))
        NSLayoutConstraint.activate(bgconstraint)
        
        var indexViewConstrint = [NSLayoutConstraint]()
        
        indexViewConstrint.append(indexView.widthAnchor.constraint(equalToConstant: 40))
        
        separatorView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 10).isActive = true
        
        separatorView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: 0).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 0).isActive = true
        
        separatorView.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
        
        NSLayoutConstraint.activate(indexViewConstrint)
        
        indexLabel.leadingAnchor.constraint(equalTo: indexView.leadingAnchor, constant: 5).isActive = true
        indexLabel.trailingAnchor.constraint(equalTo: indexView.trailingAnchor, constant: -5).isActive = true
        indexLabel.centerYAnchor.constraint(equalTo: indexView.centerYAnchor).isActive = true
        
        var VstackConstraints = [NSLayoutConstraint]()
        VstackConstraints.append(VStack.leadingAnchor.constraint(equalTo: dataView.leadingAnchor, constant: 8))
        VstackConstraints.append(VStack.trailingAnchor.constraint(equalTo: dataView.trailingAnchor, constant: -8))
        
        
        VstackConstraints.append(VStack.topAnchor.constraint(equalTo: dataView.topAnchor, constant: 5))
        VstackConstraints.append(VStack.bottomAnchor.constraint(equalTo: dataView.bottomAnchor, constant: -5))
        
        NSLayoutConstraint.activate(VstackConstraints)
        
    }
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//      super.init(style: .subtitle, reuseIdentifier: nil)
//
//
//  }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    
    
}


class ExtratitleTableViewCell:UITableViewCell{
    
}

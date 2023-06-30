//
//  SliderBottomView.swift
//  ProdSuit
//
//  Created by MacBook on 14/02/23.
//

import UIKit

protocol sliderActionDelegate:AnyObject{
    func selectedButtonIndex(index:Int)
}

class SliderBottomView: UIView {
    
    
    weak var delegate : sliderActionDelegate?
    
    lazy var stackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [skipBtn,pageControllView,nextBtn])
        stackView.axis = .horizontal
        
        
        stackView.spacing = 4
        stackView.distribution = .fillEqually
     return stackView
    }()
    
    lazy var skipBtn : UIButton = {
        
        let skipBtn = UIButton()
        skipBtn.titleLabel?.font = AppFonts.Shared.Medium
        skipBtn.setTitleColor(UIColor.white, for: .normal)
        skipBtn.setTitle(skipBtnName, for: .normal)
        skipBtn.addTarget(self, action: #selector(skipButtonAction), for: .touchUpInside)
        return skipBtn
    }()
    
    lazy var nextBtn : UIButton = {
        
        let nextBtn = UIButton()
        
        nextBtn.titleLabel?.font = AppFonts.Shared.Medium
        nextBtn.setTitleColor(UIColor.white, for: .normal)
        nextBtn.setTitle(nextBtnName, for: .normal)
        nextBtn.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        return nextBtn
    }()
    
    lazy var pageControllView : UIView = {
        let pageControllView = UIView()
        
        return pageControllView
    }()
    
    private let pageControll = UIPageControl()
    
    
    var selectedIndex = 0 {
        didSet{
            self.nextBtn.setTitle(selectedIndex >= 2 ? "GOT IT" : "NEXT", for: .normal)
            self.skipBtn.setTitle(selectedIndex >= 2 ? "" : "SKIP", for: .normal)
            skipBtn.isEnabled =  selectedIndex >= 2 ? false : true
            pageControlConfigure(selectedPage: selectedIndex)
            UIView.animate(withDuration: 0, delay: 0) {
                self.layoutIfNeeded()
            }
        }
    }
    
    var skipBtnName = "SKIP"
    var nextBtnName = "NEXT"
    
   
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    @objc func skipButtonAction(){
        
        
        delegate?.selectedButtonIndex(index: -1)
    }
    
    @objc func nextButtonAction() {
        selectedIndex += 1
        delegate?.selectedButtonIndex(index: selectedIndex > 2 ? 3 : selectedIndex)
        
    }
    
    private func pageControlConfigure(selectedPage:Int,numberofPages:Int = 3){
        pageControll.numberOfPages = numberofPages
        pageControll.currentPage = selectedPage
        pageControll.currentPageIndicatorTintColor = AppColor.Shared.teal_200
        pageControll.pageIndicatorTintColor = AppColor.Shared.colorWhite
    }
    
    private func commonInit(){
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        var stackViewAnchor = [NSLayoutConstraint]()
        stackViewAnchor.append(stackView.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 8))
        stackViewAnchor.append(stackView.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant: -8))
        stackViewAnchor.append(stackView.topAnchor.constraint(equalTo:self.topAnchor, constant: 10))
        stackViewAnchor.append(stackView.bottomAnchor.constraint(equalTo:self.bottomAnchor, constant: -8))
        NSLayoutConstraint.activate(stackViewAnchor)
        
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        self.pageControllView.addSubview(pageControll)
        
        var pageControlAnchor = [NSLayoutConstraint]()
        //pageControll.backgroundColor = UIColor.systemBlue
        pageControlAnchor.append(pageControll.leadingAnchor.constraint(equalTo: pageControllView.leadingAnchor, constant: 3))
        pageControlAnchor.append(pageControll.trailingAnchor.constraint(equalTo: pageControllView.trailingAnchor, constant: -3))
        pageControlAnchor.append(pageControll.heightAnchor.constraint(equalToConstant: 35))
        pageControlAnchor.append(pageControll.centerYAnchor.constraint(equalTo: pageControllView.centerYAnchor, constant: 0))
        
        NSLayoutConstraint.activate(pageControlAnchor)
        pageControlConfigure(selectedPage: selectedIndex)
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

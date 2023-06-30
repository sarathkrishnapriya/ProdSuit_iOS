//
//  HomeSliderVC.swift
//  ProdSuit
//
//  Created by MacBook on 13/02/23.
//

import UIKit



class HomeSliderVC: UIViewController {
    
    
    
    private let scrollView : UIScrollView = {
        let scrolView  = UIScrollView()
        scrolView.backgroundColor = UIColor.white
        scrolView.alwaysBounceVertical = false
        scrolView.showsVerticalScrollIndicator = false
        scrolView.showsHorizontalScrollIndicator = false
        scrolView.bounces = false
        scrolView.isPagingEnabled = true
        return scrolView
    }()
    
    private let bottomView : SliderBottomView = {
       
        let bottomSection = SliderBottomView()
       
        //bottomSection.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return bottomSection
    }()
    
    var pageSelected = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        setupScrollView()
        
       

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupScrollView()
    }
    
    func setupScrollView(){
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        self.scrollView.delegate = self
        var scrollViewAnchors = [NSLayoutConstraint]()
        
        scrollViewAnchors.append(scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))
        
        scrollViewAnchors.append(scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        
        scrollViewAnchors.append(scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0))
        scrollViewAnchors.append(scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0))
        NSLayoutConstraint.activate(scrollViewAnchors)
        pagScroll()
        
    }
    
    func pagScroll(count:Int=3){
        
        let numberOfPages = count
        let scrollWidth = CGFloat(numberOfPages) * self.view.frame.width
        let scrollHeight = scrollView.frame.size.height
        let scrollY = scrollView.frame.origin.y
        let contentWidth = self.view.frame.width
        var x : CGFloat = 0
        
        
        for i in 0..<numberOfPages{
            
            
            x = CGFloat(i) * CGFloat(contentWidth)
            
            
            let singleview : UIView = UIView(frame: CGRect(x: Int(x), y: Int(scrollY), width: Int(contentWidth), height: Int(scrollHeight)))
            
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstSliderVC") as! FirstSliderVC
            
            vc.index = i
            
            //let vc = AppVC.Shared.LoginSliderPage
            
            vc.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
            //vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParent: self)
            self.addChild(vc)
            vc.didMove(toParent: self)
            singleview.addSubview(vc.view)
            scrollView.addSubview(singleview)
            
            
            //singleview.backgroundColor = i == 0 ? UIColor.green : i == 1 ? UIColor.red : UIColor.orange
            
            
            
        }
        
        scrollView.contentSize = CGSize.init(width: scrollWidth, height: scrollHeight)
        
        //let window = UIApplication.shared.windows.last
        self.view.addSubview(self.bottomView)
        self.view.bringSubviewToFront(self.bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints  = false
        bottomView.delegate = self
        var bottomViewConstraint = [NSLayoutConstraint]()
        
        bottomViewConstraint.append(self.bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))
        bottomViewConstraint.append(self.bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        bottomViewConstraint.append(self.bottomView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0))
        bottomViewConstraint.append(self.bottomView.heightAnchor.constraint(equalToConstant: 75))
        NSLayoutConstraint.activate(bottomViewConstraint)
        
//        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 75))
//        self.bottomView.addSubview(label)
//        label.backgroundColor = UIColor.green
//        label.text = "hello"
        
    }
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension HomeSliderVC : UIScrollViewDelegate,sliderActionDelegate{
    
    func selectedButtonIndex(index: Int) {
        //print("selected Index --- \(index)")
        
        if index == -1{
            
            if SharedPreference.Shared.onBoardCompleted == false{
                SharedPreference.Shared.onBoardCompleted = true
            }else{
                print("onboard_complete == \(SharedPreference.Shared.onBoardCompleted)")
            }
            let welcomePage = AppVC.Shared.WelcomePage
            var navlist = self.navigationController?.viewControllers
            navlist!.removeLast()
            navlist!.append(welcomePage)
            self.navigationController?.setViewControllers(navlist!, animated: true)
            
        }else{
           
            let selectedIndex = index > 2 ? 2 : index
            
            if index == 3{
                
                if SharedPreference.Shared.onBoardCompleted == false{
                    SharedPreference.Shared.onBoardCompleted = true
                }else{
                    print("onboard_complete == \(SharedPreference.Shared.onBoardCompleted)")
                }
                let welcomePage = AppVC.Shared.WelcomePage
                var navlist = self.navigationController?.viewControllers
                navlist!.removeLast()
                navlist!.append(welcomePage)
                self.navigationController?.setViewControllers(navlist!, animated: true)
                return
            }
            pageSelected = selectedIndex
            
            let scrollWidth = self.scrollView.frame.width
            scrollView.setContentOffset(CGPoint(x: selectedIndex * Int(scrollWidth), y: 0), animated: true)
            
        }
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //print("\(scrollView.contentOffset.x) ===== \(scrollView.contentSize.width) == \(scrollView.contentOffset.x/scrollView.frame.width)")
//        if !(scrollView.contentOffset.x/scrollView.frame.width).isNaN{
//        pageSelected = Int(scrollView.contentOffset.x/scrollView.frame.width)
//        }
//        scrollView.setContentOffset(CGPoint(x: pageSelected * Int(scrollView.frame.width), y: 0), animated: true)
        scrollView.contentOffset.y = 0
        
        
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        pageSelected = Int(scrollView.contentOffset.x/scrollView.frame.width)
        //selectedPageDelegate?.selectedPage(index: pageSelected)
        self.bottomView.selectedIndex = pageSelected
        print("reached page - \(pageSelected)")
        
    }
    

}

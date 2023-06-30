//
//  DashboardVC.swift
//  ProdSuit
//
//  Created by MacBook on 22/02/23.
//

import UIKit


class DashboardVC: UIViewController {
    
    @IBOutlet weak var sideMenuBGView: UIView!
    @IBOutlet weak var sidMenuWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuBgView: MenuBgView!
    @IBOutlet weak var imageSliderView: ImageSliderView!
    
    @IBOutlet weak var companyLogImageView: UIImageView!
    @IBOutlet weak var companyLogNameLabel: UILabel!
    @IBOutlet weak var stackBGView: UIView!
    @IBOutlet weak var dashCurveView: PentagonView!
    @IBOutlet weak var reminderLabel: UILabel!
    
    @IBOutlet weak var quitLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    
    
    @IBOutlet weak var stackBgHeightConstriant: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var collectionVW: UICollectionView!
    
    @IBOutlet weak var sideMenuTableView: SidemenuTableVieWs!
    
    
    //var DashboardNavController : UINavigationController?
    var preference = SharedPreference.Shared
    var menuClicked = false
    var selectedTabbar = -1
    unowned var dashboardVM : DashboardVCViewModel!
    var itemcount = 0
    var tabbarlabelList = [UILabel]()
    var tabbarTitle = [String]()
    
    lazy var notificationList : [NotificationDetailsInfo] = [] {
        didSet{
            print("read")
        }
    }
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        menuBgView.isHidden = true
        sideMenuBGView.isHidden = true
        self.tabbarTitle = ["Reminder","Log out","Quit"]
        self.tabbarlabelList = [reminderLabel,logoutLabel,quitLabel]
        
        self.sidMenuWidthConstraint.constant = self.view.frame.width
        
        print(allControllers)
        
        print("dashboard saved token : \(preference.User_Token)")
        
        
        
        dashboardVM = DashboardVCViewModel(controller: self)
        
        
        loadDashBoardApi()
        
        
        tableViewDelegate(tableview:sideMenuTableView)
        collectionViewDelegate(dashBoardVC: self)
        
       

        // Do any additional setup after loading the view.
    }
    
    fileprivate func loadDashBoardApi() {
        
        let dispatchqueue = DispatchGroup()
        
        dispatchqueue.enter()
        
         print("image and company logo loading")
        
        dispatchqueue.leave()
        
        
        
        dispatchqueue.notify(queue: DispatchQueue.main) {
            if let dashVm = DashboardVCViewModel.init(controller: self) as? DashboardVCViewModel {
                self.dashboardVM = dashVm
                if self.dashboardVM.bannerDetailsList.count == 0{
                    print(dashVm.bannerDetailsList.count)
                    
                    
                    self.dashboardVM.bannerDetailsAPICall(vc: self, nil)
                    
                }
                
            }
        }
        
           
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.viewControllers.removeAll(where: { (vc) -> Bool in
            return vc.isKind(of: DashboardVC.self) ? false : true

        })
        
        filterMenueItems()
        itemcount = menuItemList.count
        if let dashVm = DashboardVCViewModel.init(controller: self) as? DashboardVCViewModel{
            dashVm.notificationListApiCall()
        }
        
        
        resetTabbar()
        
          
        
           
        
        
        
    }
    
    func filterMenueItems(){
        var list:[(module:String,show:Bool)] = []
        
        if preference.User_module_LEAD == false{
            list.append((module: "Leads", show: false))
        }
        
        if preference.User_module_ACCOUNTS == false{
            list.append((module: "Collection", show: false))
        }
        
        if preference.User_module_SERVICE == false{
            list.append((module: "Service", show: false))
        }
        
        if preference.User_module_DELIVERY == false{
            list.append((module: "Pickup Delivery", show: false))
        }
        
        if preference.User_module_LOCATION_TRACKING == false{
            list.append((module: "Location Details", show: false))
        }
        
        print("module list : \(list)")
        
        if list.count > 0{
            
       for item in list{
        for i in 0..<menuItemList.count - 1{
            
                if menuItemList.indices.contains(i){
                    if menuItemList[i].name.lowercased() == item.module.lowercased(){
                    
                    menuItemList.remove(at: i)
                   }
                }
            }
         }
            
//            DispatchQueue.main.async {
//                self.collectionVW.reloadData()
//            }
        }
        //print(menuItemList)
        
    }
    
    
    func collectionViewDelegate(dashBoardVC:DashboardVC) {
       dashBoardVC.collectionVW.delegate = self
       dashBoardVC.collectionVW.dataSource = self
   }
    
    func tableViewDelegate(tableview:UITableView) {
        
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .none
        tableview.bounces = false
        tableview.backgroundColor = AppColor.Shared.colorWhite
     
        
        
   }
    
    deinit {
        
        self.imageSliderView.stop()
    
        self.dashboardVM = DashboardVCViewModel(controller: self)
        
    }
    
  
    fileprivate func menuViewHideShow() {
        self.sidMenuWidthConstraint.constant = menuClicked == false ? self.view.frame.size.width * 1 : 0

        
        UIView.animate(withDuration: 0.35, delay: 0, options: .transitionFlipFromLeft) {
            self.view.layoutIfNeeded()
        } completion: { complete in
            self.menuClicked = !self.menuClicked
        }
    }
    
    fileprivate func showHideSideMenue() {
        if menuBgView.isHidden == true{
            self.sidMenuWidthConstraint.constant = 0
        }
        
        menuBgView.isHidden = false
        sideMenuBGView.isHidden = false
        menuViewHideShow()
    }
    
    @IBAction func sideMenuButtonAction(_ sender: UIButton) {
        
        showHideSideMenue()

        
    }
    
    
    fileprivate func tabBarActionMethod() {
        switch selectedTabbar{
        case 0:
              
            let reminderPopUPVC = AppVC.Shared.ReminderPage
            reminderPopUPVC.modalTransitionStyle = .crossDissolve
            reminderPopUPVC.modalPresentationStyle = .overCurrentContext
            self.present(reminderPopUPVC, animated: true)
            
        case 1:
            self.popupAlert(title: "Log Out", message: logoutMessage, actionTitles: [no_cancel_title,yesTitle], actions: [{ action1 in
                print("no")
                self.resetTabbar()
            },{action2 in
                print("yes")
                self.resetTabbar()
                self.imageSliderView.stop()
                self.preference.logOut()
            },nil])
        case 2:
            self.popupAlert(title: "Quit", message: quitMessage, actionTitles: [no_cancel_title,yesTitle], actions: [{ action1 in
                print("no")
                print(self.navigationController?.viewControllers)
                self.resetTabbar()
            },{action2 in
                print("yes")
                self.resetTabbar()
                exit(0)
            },nil])
        default:
            self.resetTabbar()
        }
    }
    
    @IBAction func tabBarButtonAction(_ sender: UIButton) {
        
        selectedTabbar = sender.tag
        
        self.tabbarlabelList.enumerated().map{ (index,label) in
            
            label.text = index == selectedTabbar ? tabbarTitle[index] : ""
            UIView.animate(withDuration: 0.325, delay: 0, options: UIView.AnimationOptions.curveEaseInOut) {
                self.view.layoutIfNeeded()
            }
             
            print("selected index \(index)")
        }
        
        self.tabBarActionMethod()
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == self.sideMenuBGView{
            self.menuViewHideShow()
        }
    }
    
    func resetTabbar(){
        selectedTabbar = -1
        self.tabbarlabelList.map { $0.text = "" }
        
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


extension DashboardVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemcount > 9 ? 9 : itemcount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCVC", for: indexPath) as! DashboardMenuCVC
        let info = menuItemList[indexPath.item]
        
        
            let unreadMessageList = self.notificationList.filter{
            return $0.IsRead == 0
        }
        
        print(unreadMessageList.count)
            
        
        cell.fetchMenuDetails(info: info, unreadMessageList.count)
            
        
        //cell.contentView.backgroundColor = AppColor.Shared.colorPrimary
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch menuItemList[indexPath.row].name {
            
            
             
            
        case "Dashboard":
            let chartVc = AppVC.Shared.ChartPage
            DispatchQueue.main.async {[weak self] in
                if !(self?.allControllers.contains(chartVc))!{
                    self?.navigationController?.pushViewController(chartVc, animated: true)
                }else{
                    print("all ready contain")
                }
                
            }
        case "Notification":
            
            let notificationVC = AppVC.Shared.NotificationPage
            DispatchQueue.main.async {[weak self] in
                if !(self?.allControllers.contains(notificationVC))!{
                    self?.navigationController?.pushViewController(notificationVC, animated: true)
                }else{
                    print("all ready contain")
                }
            }
            
        case "Leads":
            let leadsVC = AppVC.Shared.leadsPage
            //leadsVC.DashboardNavController = DashboardNavController
            DispatchQueue.main.async {[weak self] in
                if !(self?.allControllers.contains(leadsVC))!{
                    self?.navigationController?.pushViewController(leadsVC, animated: true)
                }else{
                    print("all ready contain")
                }
            }
            
        case "Collection":
            weak var emiVC = AppVC.Shared.emiCategories
            emiVC?.fromPrevious = true
            DispatchQueue.main.async {[unowned self] in
                if !(self.allControllers.contains(emiVC!)){
                    self.navigationController?.pushViewController(emiVC!, animated: true)
                }else{
                    print("all ready contain")
                }
            }
            
            
        default:
            print("home collection view default case")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3
        let itemsCount = itemcount > 9 ? 9 : itemcount
        let reminder = itemsCount % 3 == 1 ? 1 : itemsCount % 3 == 2 ? 2 : 0
      
        let rem = reminder == 0 ? 0 : 1
        
        let noOfCellsInColumn = ((itemsCount - reminder)/3) + rem
        
        print("column :\(noOfCellsInColumn) reminder:\(reminder)")

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = .vertical

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        let totalHeightSpace = flowLayout.sectionInset.top + flowLayout.sectionInset.bottom + flowLayout.minimumLineSpacing * CGFloat(noOfCellsInColumn - 1)
        
        let heightSize = Int((collectionView.bounds.height - totalHeightSpace) / CGFloat(noOfCellsInColumn))

        return CGSize(width: size, height: heightSize)
    }
    
    
}

extension DashboardVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0 : return 1
        case 1 : return sideMenueItemList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch  indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuHeaderTVC") as! SideMenuHeaderTVC
            //cell.contentView.backgroundColor = AppColor.Shared.colorWhite
            cell.configureCellDetails()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenueContentTVC") as! SideMenueContentTVC
            cell.contentView.backgroundColor = AppColor.Shared.colorWhite
            let menuInfo = sideMenueItemList[indexPath.item]
            cell.menuDetails(menuInfo)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            showHideSideMenue()
            switch indexPath.item{
               case 0:
                let profilePage = AppVC.Shared.ProfilePage
                //profilePage.DashboardNavController = DashboardNavController
                self.navigationController?.pushViewController(profilePage, animated: true)
               case 1:
                let changeMpin = AppVC.Shared.ChangeMpinPage
                changeMpin.modalTransitionStyle = .crossDissolve
                changeMpin.modalPresentationStyle = .overCurrentContext
                changeMpin.delegate = self
                self.present(changeMpin, animated: true)
                
              case 2:
                let aboutUs = AppVC.Shared.AboutPage
                
                //aboutUs.DashboardNavController = DashboardNavController
                self.navigationController?.pushViewController(aboutUs, animated: true)
                
             case 3:
                let contactUs = AppVC.Shared.ContactUsPage
                //contactUs.DashboardNavController = DashboardNavController
                self.navigationController?.pushViewController(contactUs, animated: true)
            case 4:
                let text = shareTextMessage
                let usersFocused = shareFocusPeopleTextMessage
                   
                let shareUrlString = preference.AppStoreLink
                    let myWebsite = URL(string: shareUrlString)
                    let shareAll  = [text,usersFocused,myWebsite!] as [Any]
                    let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
                    activityViewController.popoverPresentationController?.sourceView = self.view
                    self.present(activityViewController, animated: true, completion: nil)
            case 5:
                self.popupAlert(title: "Log Out", message: logoutMessage, actionTitles: [no_cancel_title,yesTitle], actions: [{ action1 in
                    print("no")
                    
                },{action2 in
                    print("yes")
                    self.imageSliderView.stop()
                    self.preference.logOut()
                },nil])
            case 6:
                self.popupAlert(title: "Quit", message: quitMessage, actionTitles: [no_cancel_title,yesTitle], actions: [{ action1 in
                    print("no")
                    //print(self.navigationController?.viewControllers)
                    
                },{action2 in
                    print("yes")
                    
                    exit(0)
                },nil])
            default:
                print("default case")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 200
        case 1: return 55
        default:
            return 50
        }
    }
    
   
    

}

extension DashboardVC:ChangeMPINProtocol{
  
    func changeMPINAction(changeMPINVC: ChangeMpinVC) {
        changeMPINVC.changeMPINVM.changeMPINCancellable.dispose()
        print(self.navigationController!.viewControllers)
        self.popToViewController(ofClass: MpinVC.self, controllers: self.navigationController!.viewControllers)
        
    }
  
}

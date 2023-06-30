//
//  ProfileVC.swift
//  ProdSuit
//
//  Created by MacBook on 17/03/23.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var profileHeaderView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    //var DashboardNavController : UINavigationController?
    
    @IBOutlet weak var bgView: UIView!
    
    
    var preference = SharedPreference.Shared

    fileprivate func tableInitialize() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        //profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.separatorStyle = .none
        profileTableView.estimatedRowHeight = 61
    }
    
    fileprivate func bgViewConstraintSetup() {
       
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.backgroundColor = AppColor.Shared.colorWhite
        var bgViewConstraints = [NSLayoutConstraint]()
        bgViewConstraints.append(bgView.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor, constant: 0))
        bgViewConstraints.append(bgView.leadingAnchor.constraint(equalTo: self.profileTableView.leadingAnchor, constant: 0))
        bgViewConstraints.append(bgView.trailingAnchor.constraint(equalTo: self.profileTableView.trailingAnchor, constant: 0))
        bgViewConstraints.append(bgView.bottomAnchor.constraint(equalTo: self.profileTableView.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(bgViewConstraints)
    }
    
    fileprivate func userInfoFetch() {
        self.nameLabel.text = preference.User_UserName
        self.dateLabel.text = preference.User_LoggedDate
        nameLabel.font = AppFonts.Shared.Medium.withSize(18)
        nameLabel.textColor = AppColor.Shared.coloBlack
        
        dateLabel.font = AppFonts.Shared.Regular.withSize(12)
        dateLabel.textColor = UIColor.darkText.withAlphaComponent(0.6)
        
        
        
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.sizeToFit()
        nameLabel.adjustsFontSizeToFitWidth = true
        //self.profileTableView.tableHeaderView = profileHeaderView
       // self.profileTableView.frame.size.height =
        bgViewConstraintSetup()
        tableInitialize()
        userInfoFetch()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonAction(_ sender: BackButtonCC) {
        
        let profilePage = AppVC.Shared.ProfilePage
        
        if allControllers.contains(profilePage){
            self.navigationController?.popViewController(animated: true)
        }
        
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

extension ProfileVC : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return profileDetilsList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileHeaderTVC_cell") as! ProfileHeaderTVC
            cell.headerNameLabel.text = "Personal Info"
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileTVC_cell") as! ProfileTVC
            let info = profileDetilsList[indexPath.item]
            cell.viewModel = info
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected index \(indexPath.row)")
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let headerView = UIView(frame: CGRect(x: 0, y: self.bgView.frame.origin.y, width: self.profileTableView.frame.width, height: 60))
//        headerView.backgroundColor = AppColor.Shared.color_warning
//        return headerView
//
//    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 60
        }else{
            return UITableView.automaticDimension
        }
    }
    
}

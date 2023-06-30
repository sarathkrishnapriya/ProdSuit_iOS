//
//  AboutUsVC.swift
//  ProdSuit
//
//  Created by MacBook on 17/03/23.
//

import UIKit

class AboutUsVC: UIViewController {
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var versionLbl: AboutusTitleLabel!
    //var DashboardNavController : UINavigationController?
    
    var preference = SharedPreference.Shared

    fileprivate func aboutUsDetailsInfo() {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.1"
        self.versionLbl.text = "Version : \(appVersion)"
        self.descriptionLbl.text = preference.AboutUs
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutUsDetailsInfo()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: BackButtonCC) {
        
        let aboutUs = AppVC.Shared.AboutPage
        if allControllers.contains(aboutUs){
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

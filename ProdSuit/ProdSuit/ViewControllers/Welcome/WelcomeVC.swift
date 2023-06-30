//
//  WelcomeVC.swift
//  ProdSuit
//
//  Created by MacBook on 15/02/23.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func welcomeGetStarted(_ sender: UIButton) {
        
        sender.opacityAnimation()
        
        if SharedPreference.Shared.welcomedPageCompleted == false{
            
            SharedPreference.Shared.welcomedPageCompleted = true
            
        }else{
            print("Welcome Page completed = \(SharedPreference.Shared.welcomedPageCompleted)")
        }
        
         
        let loginVc = AppVC.Shared.LoginPage
        var navlist = self.navigationController?.viewControllers
        navlist!.removeLast()
        navlist!.append(loginVc)
        self.navigationController?.setViewControllers(navlist!, animated: true)
        
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

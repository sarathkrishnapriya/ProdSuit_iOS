//
//  LeadManagementOverDueVC.swift
//  ProdSuit
//
//  Created by MacBook on 10/05/23.
//

import UIKit

class LeadManagementOverDueVC: UIViewController{

    var fromViewController = "todo"
    @IBOutlet weak var lmTableview: UITableView!
    
   // @IBOutlet weak var tabLayout: TabLayout!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lmTableview.backgroundColor = fromViewController == "todo" ? AppColor.Shared.purple_200 : AppColor.Shared.leadstages_color11
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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

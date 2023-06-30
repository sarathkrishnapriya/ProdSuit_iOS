//
//  NotificationVC.swift
//  ProdSuit
//
//  Created by MacBook on 29/03/23.
//

import UIKit

class NotificationVC: UIViewController {

    weak var notificationVm:NotificationVCViewModel!
    @IBOutlet weak var notificationTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        notificationVm = NotificationVCViewModel(controller: self)
        tableDelegateDatasourceCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notificationVm = NotificationVCViewModel(controller: self)
    }
    
    func tableDelegateDatasourceCall() {
       self.notificationTableView.dataSource = self
       self.notificationTableView.delegate = self
        
   }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationVm.notificationDetailsCancellable.dispose()
    }
    
    
    
    @IBAction func backButtonAction(_ sender: BackButtonCC) {
        
        self.navigationController?.popViewController(animated: true)
        
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

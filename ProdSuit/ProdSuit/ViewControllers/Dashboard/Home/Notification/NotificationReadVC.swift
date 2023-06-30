//
//  NotificationReadVC.swift
//  ProdSuit
//
//  Created by MacBook on 29/03/23.
//

import UIKit

protocol NotificationReadStatusDelegate:AnyObject{
    func didReadNotification(item:NotificationDetailsInfo)
}

class NotificationReadVC: UIViewController {
    
    var viewModel:NotificationDetailsInfo?
    weak var delegate : NotificationReadStatusDelegate?
    @IBOutlet weak var messageTitleLabel: UILabel!
    @IBOutlet weak var messageTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.messageTitleLabel.text = viewModel?.Title
        self.messageTextLabel.text = viewModel?.Message
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            
            self.messageTitleLabel.text = ""
            self.messageTextLabel.text = ""
            self.delegate?.didReadNotification(item: self.viewModel!)
            
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

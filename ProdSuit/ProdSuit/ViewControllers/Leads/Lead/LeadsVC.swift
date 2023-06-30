//
//  LeadsVC.swift
//  ProdSuit
//
//  Created by MacBook on 03/04/23.
//

import UIKit

class LeadsVC: UIViewController {
    
    @IBOutlet weak var leadManagementView: RoundCornerView!
    @IBOutlet weak var leadGenerationView: RoundCornerView!
    
    @IBOutlet weak var walkingCustomerView: BorderView!
    
    //var DashboardNavController : UINavigationController?
    weak var leadsVm : LeadsVCViewModel?
    
    var leadGenerationDefaultValueSettingsInfo : LeadGenerationDefaultValueModel!

    fileprivate func setUI() {
        self.leadGenerationView.setBGColor(color: AppColor.Shared.leadGenColor)
        self.leadManagementView.setBGColor(color: AppColor.Shared.leadMangeColor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("leads vc")
        
        setUI()
       
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        leadsVm = LeadsVCViewModel(controller: self)
    }
    
    @IBAction func backButtonAction(_ sender: BackButtonCC) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func leadGenerationButtonAction(_ sender: UIButton) {
        
        leadGenerationView.flash( withDutation: 0.35, repeatCount: 1)
        print("generate")
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.45) {
            let leadGenerationPage = AppVC.Shared.leadGenerationPage
            //leadGenerationPage.DashboardNavController = self.DashboardNavController
            
            leadGenerationPage.leadGenerationDefaultValueSettingsInfo = self.leadGenerationDefaultValueSettingsInfo
            DispatchQueue.main.async {[weak self] in
                if !(self?.allControllers.contains(leadGenerationPage))!{
                    self?.navigationController?.pushViewController(leadGenerationPage, animated: true)
                }else{
                    print("all ready contain")
                }
            }
        }
       
        
    }
    
    @IBAction func leadManagementButtonAction(_ sender: UIButton) {
        
        leadManagementView.flash( withDutation: 0.42, repeatCount: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.45) {
            let leadManagementPage = AppVC.Shared.leadManagementPage
            leadManagementPage.leadGenerationDefaultValueSettingsInfo = self.leadGenerationDefaultValueSettingsInfo
            leadManagementPage.fromFilter = false
            DispatchQueue.main.async {[weak self] in
                if !(self?.allControllers.contains(leadManagementPage))!{
                    self?.navigationController?.pushViewController(leadManagementPage, animated: true)
                }else{
                    print("all ready contain")
                }

            }
        }
        
        
    }
    
    
    @IBAction func walkingCustomerButtonAction(_ sender: UIButton) {
        
        
        
       
        
        walkingCustomerView.flash( withDutation: 0.42, repeatCount: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.45) {
            
            let walkCustomerPage = AppVC.Shared.walkingCustomerPage
            
            
            DispatchQueue.main.async {[weak self] in
                if !(self?.allControllers.contains(walkCustomerPage))!{
                    self?.navigationController?.pushViewController(walkCustomerPage, animated: true)
                }else{
                    print("all ready contain")
                }

            }
        }
        
    }
    
    deinit {
        self.leadsVm = LeadsVCViewModel(controller: self)
        
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

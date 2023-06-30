//
//  LeadManagementVC.swift
//  ProdSuit
//
//  Created by MacBook on 03/04/23.
//

import UIKit

class LeadManagementVC: UIViewController {
    
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var todoBGView: UIView!{
        didSet{
            self.todoBGView.setBGColor(color: AppColor.Shared.todolist_Color)
            self.todoBGView.setCornerRadius(size: self.todoBGView.bounds.width/2)
        }
    }
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var overDueLabel: UILabel!
    @IBOutlet weak var overDueBGView: UIView!{
        didSet{
            self.overDueBGView.setBGColor(color: AppColor.Shared.overdue_Color)
            self.overDueBGView.setCornerRadius(size: self.overDueBGView.bounds.width/2)
        }
    }
    @IBOutlet weak var upcomingWorksLabel: UILabel!
    
    @IBOutlet weak var upcomingBGView: UIView!{
        didSet{
            self.upcomingBGView.setBGColor(color: AppColor.Shared.upcomung_Color)
            self.upcomingBGView.setCornerRadius(size: self.upcomingBGView.bounds.width/2)
        }
    }
    @IBOutlet weak var myleadLabel: UILabel!
    
    @IBOutlet weak var myLeadBGView: UIView!{
        didSet{
            self.myLeadBGView.setBGColor(color: AppColor.Shared.leadManageMyLead)
            self.myLeadBGView.setCornerRadius(size: self.myLeadBGView.bounds.width/2)
        }
    }
    
    
    @IBOutlet weak var todoView: BorderView!
    {
        didSet{
            todoView.setBGColor(color: AppColor.Shared.todolist_Color)
        }
    }
    
    @IBOutlet weak var overdueView: BorderView!
    {
        didSet{
            overdueView.setBGColor(color: AppColor.Shared.overdue_Color)
        }
    }
    
    @IBOutlet weak var upcomingWorkView: BorderView!
    {
        didSet{
            upcomingWorkView.setBGColor(color: AppColor.Shared.upcomung_Color)
        }
    }
    
    @IBOutlet weak var myleadsView: BorderView!
    {
        didSet{
            myleadsView.setBGColor(color: AppColor.Shared.leadManageMyLead)
        }
    }
    
    
    @IBOutlet weak var filterView: UIView!
    
    
    // MARK: - VARIABLES
    unowned var leadManagementViewModel : LeadManagementViewModel!
    var leadGenerationDefaultValueSettingsInfo : LeadGenerationDefaultValueModel!
    
    
    lazy var overDue_count : NSNumber = 0{
        didSet{
            //print("OVER DUE  \(overDue_count)")
           
            self.overDueLabel.text = "\(overDue_count)"
            
        }
    }
    
    lazy var todo_count : NSNumber = 0{
        didSet{
            //print("TODO \(todo_count)")
            
            self.todoLabel.text = "\(todo_count)"
        }
    }
    
    lazy var task_count : NSNumber = 0{
        didSet{
            //print("UPCOMING WORKS \(task_count)")
            
            self.upcomingWorksLabel.text = "\(task_count)"
        }
    }
    
    lazy var lead_count : NSNumber = 0{
        didSet{
            //print("MY LEADS \(lead_count)")
            self.myleadLabel.text = "\(lead_count)"
        }
    }
    
    var getAllEmployeeList : [EmployeeAllDetails] = []
    
    var selectedEmployee : EmployeeAllDetails?
    var fromFilter:Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
       
        if fromFilter == false {
        if let leadManagementVm = LeadManagementViewModel(vc: self)  as? LeadManagementViewModel{
        leadManagementViewModel = leadManagementVm
        
        leadManagementViewModel.initializeUILabel()
        leadManagementViewModel.leadManagementPendingCountDetailsAPICall()
        }
        }
        
    }
    
    deinit {
        leadManagementViewModel = LeadManagementViewModel(vc: self)
    }
    
    
    
    @IBAction func backButtonAction(_ sender: BackButtonCC) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        filterView.flash( withDutation: 0.35, repeatCount: 1)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.40) {
            
            let filterVC = AppVC.Shared.leadManagementFilterPage
            filterVC.selectedEmployee = self.selectedEmployee
            filterVC.getAllEmployeeList = self.getAllEmployeeList
            filterVC.lmDelegate = self
            filterVC.modalTransitionStyle = .coverVertical
            filterVC.modalPresentationStyle = .overCurrentContext
            self.present(filterVC, animated: true, completion: nil)
            
            
        }
    }
    
    @IBAction func todoButtonAction(_ sender: UIButton) {
        todoView.flash( withDutation: 0.35, repeatCount: 1)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.40) {
            print("todo button clicked")
            let leadManageMentSubpage = AppVC.Shared.leadManagementCategoryList
            leadManageMentSubpage.leadGenerationDefaultValueSettingsInfo = self.leadGenerationDefaultValueSettingsInfo
            
            if let info = self.selectedEmployee{
                leadManageMentSubpage.fk_Employee = "\(info.ID_Employee)"
                leadManageMentSubpage.selectedEmployee = info
            }
            
            leadManageMentSubpage.fromViewController = "todo"
            leadManageMentSubpage.subMode = SubMode.Shared.lmTodo
          
            DispatchQueue.main.async {[weak self] in
                if !(self?.allControllers.contains(leadManageMentSubpage))!{
                    self?.navigationController?.pushViewController(leadManageMentSubpage, animated: true)
                }else{
                    print("all ready contain")
                }
            
            }
        }
    }
    
    
    @IBAction func overDueButtonAction(_ sender: UIButton) {
        overdueView.flash( withDutation: 0.35, repeatCount: 1)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.40) {
            print("over due button clicked")
            let leadManageMentSubpage = AppVC.Shared.leadManagementCategoryList
            leadManageMentSubpage.leadGenerationDefaultValueSettingsInfo = self.leadGenerationDefaultValueSettingsInfo
            if let info = self.selectedEmployee{
                leadManageMentSubpage.fk_Employee = "\(info.ID_Employee)"
                leadManageMentSubpage.selectedEmployee = info
            }
            leadManageMentSubpage.fromViewController = "overdue"
            leadManageMentSubpage.subMode = SubMode.Shared.lmOverdue
            DispatchQueue.main.async {[weak self] in
                if !(self?.allControllers.contains(leadManageMentSubpage))!{
                    self?.navigationController?.pushViewController(leadManageMentSubpage, animated: true)
                }else{
                    print("all ready contain")
                }
            }
        }
    }
    
    @IBAction func upcomingworkButtonAction(_ sender: UIButton) {
        upcomingWorkView.flash( withDutation: 0.35, repeatCount: 1)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.40) {
            let leadManageMentSubpage = AppVC.Shared.leadManagementCategoryList
            leadManageMentSubpage.leadGenerationDefaultValueSettingsInfo = self.leadGenerationDefaultValueSettingsInfo
            if let info = self.selectedEmployee{
                leadManageMentSubpage.fk_Employee = "\(info.ID_Employee)"
                leadManageMentSubpage.selectedEmployee = info
            }
            leadManageMentSubpage.fromViewController = "upcoming"
            leadManageMentSubpage.subMode = SubMode.Shared.lmUpcoming
            DispatchQueue.main.async {[weak self] in
                if !(self?.allControllers.contains(leadManageMentSubpage))!{
                    self?.navigationController?.pushViewController(leadManageMentSubpage, animated: true)
                }else{
                    print("all ready contain")
                }
            }
        }
    }
    
    
    @IBAction func myleadButtonAction(_ sender: UIButton) {
        myleadsView.flash( withDutation: 0.35, repeatCount: 1)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.40) {
            let leadManageMentSubpage = AppVC.Shared.leadManagementCategoryList
            leadManageMentSubpage.leadGenerationDefaultValueSettingsInfo = self.leadGenerationDefaultValueSettingsInfo
            if let info = self.selectedEmployee{
                leadManageMentSubpage.fk_Employee = "\(info.ID_Employee)"
                leadManageMentSubpage.selectedEmployee = info
            }
            
            leadManageMentSubpage.fromViewController = "mylead"
            leadManageMentSubpage.subMode = SubMode.Shared.lmMyleads
            DispatchQueue.main.async {[weak self] in
                if !(self?.allControllers.contains(leadManageMentSubpage))!{
                    self?.navigationController?.pushViewController(leadManageMentSubpage, animated: true)
                }else{
                    print("all ready contain")
                }
            }
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

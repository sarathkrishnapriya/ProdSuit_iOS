//
//  LeadManagementFilterVC.swift
//  ProdSuit
//
//  Created by MacBook on 09/05/23.
//

import UIKit


protocol LeadManagementFilterDelegate:AnyObject{
    func employeePendingsChange(info:EmployeeAllDetails)
}

class LeadManagementFilterVC: UIViewController {

    @IBOutlet weak var filterBGView: UIView!
    @IBOutlet weak var selectedEmployeeTF: FilterTF!
    @IBOutlet weak var cancelButton: FilterCancelBtn!
    
    @IBOutlet weak var resetView: UIView!
    @IBOutlet weak var okButton: FilterSubmitBtn!
    
    var selectedEmployee : EmployeeAllDetails?
    
    var getAllEmployeeList = [EmployeeAllDetails]()
    
    weak var lmDelegate : LeadManagementFilterDelegate?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let info = self.selectedEmployee{
            self.selectedEmployeeTF.text = info.EmpName
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == filterBGView{
            self.dismiss(animated: true)
        }
    }
    

    @IBAction func searchButtonAction(_ sender: UIButton) {
        employeeListPopUPPageCall(list: self.getAllEmployeeList)
    }
    
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        resetView.flash( withDutation: 0.35, repeatCount: 1)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.40) {
            self.resetEmployee(id_employee: preference.User_Fk_Employee)
        }
    }
    
    
    @IBAction func cancelButtonAction(_ sender: FilterCancelBtn) {
        cancelButton.flash( withDutation: 0.35, repeatCount: 1)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.40) {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func submitButtonAction(_ sender: FilterSubmitBtn) {
        okButton.flash( withDutation: 0.35, repeatCount: 1)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.40) {
            if let info = self.selectedEmployee{
            self.lmDelegate?.employeePendingsChange(info: info)
            }
            self.dismiss(animated: true)
        }
    }
    
    func employeeListPopUPPageCall(list:[EmployeeAllDetails]){
        
        let popUpVC = ReusableTableVC(items: list) { (cell:SubtitleTableViewCell, item, table )in
            cell.addcontentView(cell: cell)
            
            //let indexLevel = table.indexPath(for: cell)
            if let index = cell.tag as? Int{
                cell.indexLabel.text = "\(index + 1)"
                
            }
            cell.titleLabel.text = item.EmpName
            cell.detailsLabel.text = item.DesignationName
            cell.accessoryType = .disclosureIndicator
            UIView.animate(withDuration: 0.1) {
                cell.layoutIfNeeded()
            }
        } selectHandler: { item in
            
            self.selectedEmployee = item
            if let info = self.selectedEmployee{
            self.selectedEmployeeTF.text = info.EmpName
            }
            print(self.selectedEmployee)
        }
        
        popUpVC.listingTitleString = "EMPLOYEE"
        
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.present(popUpVC, animated: false)
        
        
    }
    
    func resetEmployee(id_employee:NSNumber){
        let result = getAllEmployeeList.filter{ $0.ID_Employee == id_employee }
        
        if let resetResult = result[0] as? EmployeeAllDetails{
            self.selectedEmployee = resetResult
            if let info = self.selectedEmployee{
            self.selectedEmployeeTF.text = info.EmpName
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

extension LeadManagementVC:LeadManagementFilterDelegate{
    func employeePendingsChange(info: EmployeeAllDetails) {
        fromFilter = true
        self.selectedEmployee = info
        
        if let leadManagementVm = LeadManagementViewModel(vc: self)  as? LeadManagementViewModel{
        leadManagementViewModel = leadManagementVm
        leadManagementViewModel.leadManagementPendingCountDetailsAPICall(fk_employee: info.ID_Employee,fromFilter: fromFilter)
        }
    }
    
    
}

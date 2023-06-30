//
//  LeadGenConfirmVC.swift
//  ProdSuit
//
//  Created by MacBook on 03/05/23.
//

import UIKit

protocol LeadDetailsConfirmDelegate:AnyObject {
    func leadDetailsConfirmationAction()
}

class LeadGenConfirmVC: UIViewController {

    var leadGenerateConfirmList : [LeadConfirmationDetails]!
    var filterdeList:[LeadConfirmationDetails]!
    weak var leadConfirmDetailsDelegate:LeadDetailsConfirmDelegate?
    
    @IBOutlet weak var leadDetailsConfirmTableView: UITableView!
    fileprivate func tableInitialize() {
        if #available(iOS 15.0, *) {
            self.leadDetailsConfirmTableView.sectionHeaderTopPadding  = 0
        } else {
            
            // Fallback on earlier versions
            self.leadDetailsConfirmTableView.contentInsetAdjustmentBehavior = .never
        }
        self.leadDetailsConfirmTableView.backgroundColor = AppColor.Shared.colorWhite
        self.leadDetailsConfirmTableView.dataSource  = self
        self.leadDetailsConfirmTableView.delegate = self
        self.leadDetailsConfirmTableView.setCornerRadius(size: 5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        tableInitialize()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filterdeList = []
        
        for i in 0..<leadGenerateConfirmList.count{
            let rowItem = leadGenerateConfirmList[i]
            let rowFiltered = rowItem.row.filter{ return $0.details != "" }
            let item = LeadConfirmationDetails(sectionTitle: rowItem.sectionTitle, row: rowFiltered)
            filterdeList.append(item)
            
        }
        
        //print(filterdeList!)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                self.leadConfirmDetailsDelegate?.leadDetailsConfirmationAction()
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

extension LeadGenConfirmVC:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return filterdeList.count
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //leadGenerateConfirmList[section].row.filter{return $0.details != "" }
        return filterdeList[section].row.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.shared.leadGenConfirmCell) as! LeadGenConfirmTVC
        let info = filterdeList[indexPath.section].row[indexPath.item]
        cell.titleLabel.sizeToFit()
        cell.titleLabel.adjustsFontSizeToFitWidth = true
        cell.titleLabel.minimumScaleFactor = 0.6
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.lineBreakMode = .byWordWrapping
        cell.titleLabel.text = info.name
        cell.noteLabel.text = info.details
        cell.selectionStyle = .gray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return leadGenerateConfirmList[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = AppColor.Shared.greylight
            let label = UILabel()
            label.frame = CGRect.init(x: 10, y: 5, width: headerView.frame.width-20, height: headerView.frame.height-10)
            label.text = "\(leadGenerateConfirmList[section].sectionTitle)"
        label.font = AppFont.medium.size(14)
        label.textAlignment = .center
        label.textColor = AppColor.Shared.coloBlack
            
            headerView.addSubview(label)
            
            return headerView
        }
    
    
}

extension LeadGenerationVC:LeadDetailsConfirmDelegate{
    func leadDetailsConfirmationAction() {
        print("lead generation save api call")
        
        leadGenerationVm.leadGenerationAPICall()
    }
    
    
}

//
//  ReusableTableVC.swift
//  ProdSuit
//
//  Created by MacBook on 12/04/23.
//

import UIKit
import Combine

class ReusableTableVC<Element:HasValue,Cell:UITableViewCell,table:UITableView>: UITableViewController,UITextFieldDelegate{
    
    let topView: UIView = {
        let tv = UIView()
        tv.backgroundColor = AppColor.Shared.statusBarColor
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    var listingTitleString : String = ""
    lazy var searchCancellable = Set<AnyCancellable>()
    let topLabel : UILabel = {
        
      let titleLabel = UILabel()
        
        titleLabel.font = AppFont.semiBold.size(15)
        titleLabel.textColor = AppColor.Shared.colorWhite
        titleLabel.textAlignment = .center
        
        
        
        
        return titleLabel
    }()
    
    let searchTextFields : UITextField = {
        
      let searchField = UITextField()
        searchField.addDonButton()
        searchField.font = AppFont.regular.size(15)
        searchField.textColor = AppColor.Shared.greyText
        searchField.autocorrectionType = .no
        searchField.customPlaceholder(color: AppColor.Shared.greyLite, text: "Search Here")
        searchField.tintColor = AppColor.Shared.greyText
        searchField.borderStyle = .roundedRect
        
        return searchField
    }()

    
    lazy var filterItems : [Element] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var cellIdentifier = "Cell"
    var items:[Element]{
            didSet{
                tableView.reloadData()
            }
        }
        var configure: (Cell,Element,table) -> Void
        var selectHandler : (Element) -> Void
    
        init(items:[Element],configure:@escaping (Cell,Element,table) -> Void,selectHandler:@escaping (Element) -> Void) {
            self.items = items
            self.configure = configure
            self.selectHandler = selectHandler
            super.init(style: UITableView.Style.plain)
            self.tableView.register(Cell.self, forCellReuseIdentifier: cellIdentifier)
    
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    fileprivate func navbarColor() {
        if #available(iOS 13, *)
        {
            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = AppColor.Shared.statusBarColor
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        } else {
            // ADD THE STATUS BAR AND SET A CUSTOM COLOR
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = AppColor.Shared.statusBarColor
            }
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()

        navbarColor()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding  = 0
        } else {
            
            // Fallback on earlier versions
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.separatorStyle = .none
        searchTextFields.delegate = self
        searchItemFromList()
        
      }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.filterItems = []
        self.items = []
    }
    
    func searchItemFromList(){
        textFieldPublisher.sink { text in
            self.filterItems = self.items.lazy.filter({
                
                $0.value.range(of: text, options: .caseInsensitive) != nil })
            print("total count: \(self.items.count) == filtered count : \(self.filterItems.count)")
        
        }.store(in: &searchCancellable)
    }
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filterItems.count > 0 ? filterItems.count : items.count
          }
          //2
          override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell
              let item = filterItems.count > 0 ? filterItems[indexPath.row] : items[indexPath.row]
              cell.tag = indexPath.row
              configure(cell, item, tableView as! table)
            return cell
       
          }
          //3
          override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let item = filterItems.count > 0 ? filterItems[indexPath.row] : items[indexPath.row]
            selectHandler(item)
            searchCancellable.dispose()
            self.dismiss(animated: false)
          }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let size = tableView.bounds
        let topStackView = UIStackView(arrangedSubviews: [topLabel,searchTextFields])
        topStackView.axis = .vertical
        
        topView.addSubview(topStackView)
        topLabel.text = listingTitleString
        topStackView.spacing = 10
        topStackView.distribution = .fillEqually
        
//        topStackView.backgroundColor = AppColor.Shared.color_warning
        topStackView.frame = CGRect(x: 15, y: 15, width: size.width-30, height: 90)
        
        return topView
       }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        
        
//        self.topStackView.backgroundColor = AppColor.Shared.grey
//        var stackViewConstraint = [NSLayoutConstraint]()
//        stackViewConstraint.append(self.topStackView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20))
//
//        stackViewConstraint.append(self.topStackView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 20))
//
//        stackViewConstraint.append(self.topStackView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 15))
//        stackViewConstraint.append(self.topStackView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 15))
        
     //   NSLayoutConstraint.activate(stackViewConstraint)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
//     func textFieldShouldReturn(textField: UITextField) -> Bool {
//
//        //textField code
//
//        textField.resignFirstResponder()  //if desired
//
//        return true
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextFields.resignFirstResponder()
        return true
    }
    
    deinit{
        self.dismiss(animated: false)
        self.searchCancellable.dispose()
    }

}



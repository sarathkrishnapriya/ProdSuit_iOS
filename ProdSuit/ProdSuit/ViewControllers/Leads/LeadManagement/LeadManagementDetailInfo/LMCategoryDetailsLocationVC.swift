//
//  LMCategoryDetailsLocationVC.swift
//  ProdSuit
//
//  Created by MacBook on 19/05/23.
//

import UIKit
import Combine
import GoogleMaps
import GooglePlaces

class LMCategoryDetailsLocationVC: UIViewController,LocationImageApiDelegate {
    
    var apiParserVm: APIParserManager!

    var parserVm: GlobalAPIViewModel!
    
        let gMapView:GMSMapView={
        let map = GMSMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    lazy var messageLabel:LMDLeadContactLbl={
        let label = LMDLeadContactLbl()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No location available"
        label.textAlignment = .center
        return label
    }()
    
    var gmsMapConstraint = [NSLayoutConstraint]()
    var messageConstraint = [NSLayoutConstraint]()
    
    var info : LeadImageLocationDetailsModel!
    
    lazy var locationCancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.apiParserVm = APIParserManager()
        self.parserVm = GlobalAPIViewModel(bgView: self.view)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func showLocation(){
        
       
        if info.LocationLatitude != "" && info.LocationLongitude != ""{
            
           
          
            
            self.view.addSubview(gMapView)
            gmsMapConstraint.append(self.gMapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0))
            gmsMapConstraint.append(self.gMapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0))
            gmsMapConstraint.append(self.gMapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0))
            gmsMapConstraint.append(self.gMapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0))
            self.gmsMapCameraViewSetUp(info)
            NSLayoutConstraint.activate(gmsMapConstraint)
            self.view.bringSubviewToFront(gMapView)
           
        }else{
            self.view.addSubview(messageLabel)
            messageConstraint.append(self.messageLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0))
            messageConstraint.append(self.messageLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0))
            messageConstraint.append(self.messageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0))
            messageConstraint.append(self.messageLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0))
            NSLayoutConstraint.activate(messageConstraint)
            self.view.bringSubviewToFront(messageLabel)
        }
                                    
            
    }
    
    func removeLocationView(){
        gMapView.removeFromSuperview()
        messageLabel.removeFromSuperview()
        NSLayoutConstraint.deactivate(gmsMapConstraint)
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
         removeLocationView()
    }
    
    
    func locationImageAPICall(_ ID_LeadGenerate:String,_ ID_LeadGenerateProduct:String,_ fk_employee:String) {
        
        
        let requestMode = RequestMode.shared.leadLocationAndImage
        let token = preference.User_Token
        let bankKey = preference.appBankKey
        let fk_company = "\(preference.User_FK_Company)"
        let fk_Employee = fk_employee
        let id_LeadGenerate = ID_LeadGenerate
        let leadGenerateProduct_id = ID_LeadGenerateProduct
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           
            let efk_Employee = instanceOfEncryptionPost.encryptUseDES(fk_Employee, key: SKey),
           let eid_LeadGenerate = instanceOfEncryptionPost.encryptUseDES(id_LeadGenerate, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let eProductId = instanceOfEncryptionPost.encryptUseDES(leadGenerateProduct_id, key: SKey){
           
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Company":efk_company,"ID_LeadGenerateProduct":eProductId,"ID_LeadGenerate":eid_LeadGenerate,"FK_Employee":efk_Employee]
            let request = apiParserVm.request(urlPath: URLPathList.Shared.leadLocationAndImage,arguMents: arguMents)
           
                parserVm.modelInfoKey = "LeadImageDetails"
                //parserVm.progressBar.showIndicator()
                parserVm.parseApiRequest(request)
                parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    //self.parserVm.progressBar.hideIndicator()
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    
                    if statusCode == 0{
                        self.info = LeadImageLocationDetailsModel(datas: responseHandler.info)
                        DispatchQueue.main.async {
                            self.showLocation()
                        }
                    }else{
                       print("lead location : \(message)")
                    }
                    
                    print(responseHandler.info)
                    self.locationCancellable.dispose()
                }.store(in: &locationCancellable)
            
        }
        
    }
    
    func gmsMapCameraViewSetUp(_ datas:LeadImageLocationDetailsModel){
        
        let latitue = (datas.LocationLatitude == "" ? 0.00 : Double(datas.LocationLatitude))!
        let longitude = datas.LocationLongitude == "" ? 0.00 : Double(datas.LocationLongitude)
        let camera = GMSCameraPosition.camera(withLatitude: latitue, longitude: longitude!, zoom: 14)
        gMapView.camera = camera
        
        if datas.LocationLatitude != "" && datas.LocationLongitude != ""{
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitue, longitude: longitude!)
        
            marker.title = datas.LocationName
        
        marker.snippet = ""
        marker.map = self.gMapView
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

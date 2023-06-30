//
//  NotificationVCViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 29/03/23.
//

import Foundation
import UIKit
import Combine

class NotificationVCViewModel{
    
    lazy var notificationVCController:NotificationVC = {
        
        let notificationVC = NotificationVC()
        
        
        return notificationVC
    }()
    
    lazy var parserViewModel : APIParserManager = APIParserManager()
    
    lazy var notificationList : [NotificationDetailsInfo] = [] {
        didSet{
            self.notificationVCController.notificationTableView.reloadData()
        }
    }
    
    var parserVm : GlobalAPIViewModel!
    
    lazy var notificationDetailsCancellable = Set<AnyCancellable>()
    lazy var notificationReadStatusCancellable = Set<AnyCancellable>()
    
    
    
    init(controller:NotificationVC) {
        self.notificationVCController = controller
        parserVm = GlobalAPIViewModel(bgView: controller.view)
        self.notificationListApiCall()
       
        
    }
    
    //MARK: - notificationReadStatusAPICall()
    func notificationReadStatusAPICall(notificationID:String){
        
        let requestMode = RequestMode.shared.NotificationStatusUpdate
        let bankKey = preference.appBankKey
        let token = preference.User_Token
        let id_user = "\(preference.User_ID_User)"
        let fk_company = "\(preference.User_FK_Company)"
        let id_notification = notificationID
        
        if let ereqMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let eid_user = instanceOfEncryptionPost.encryptUseDES(id_user, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           let enotificationID = instanceOfEncryptionPost.encryptUseDES(id_notification, key: SKey)
        {
            
            let arguMents = ["ReqMode":ereqMode,"BankKey":ebankKey,"Token":etoken,"FK_Company":efk_company,"FK_User":eid_user,"ID_NotificationDetails":enotificationID]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.notificationStatusUpdate, arguMents: arguMents)
            
            self.parserVm.parseApiRequest(request)
            self.parserVm.modelInfoKey = "NotificationDetails"
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    let notficationInfo = responseHandler.info.value(forKey: "NotificationInfo") as? [NSDictionary] ?? []
                    
                    let notificationLists = notficationInfo.map{ NotificationDetailsInfo(datas: $0) }
                    
                    self.notificationList = notificationLists.filter{ return $0.IsRead == 0 }

                    
                }.store(in: &notificationReadStatusCancellable)
            
        }
        
    }
    
    //MARK: - notificationListApiCall()
     func notificationListApiCall(){
        
        let requestMode = RequestMode.shared.HomeNotificationList
        let bankKey = preference.appBankKey
        let id_user = "\(preference.User_ID_User)"
        let fk_company = "\(preference.User_FK_Company)"
        let token = preference.User_Token
        
        if let ereqMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let eid_user = instanceOfEncryptionPost.encryptUseDES(id_user, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey)
        {
            
            let arguMents = ["ReqMode":ereqMode,"BankKey":ebankKey,"Token":etoken,"FK_Company":efk_company,"FK_User":eid_user]
            
            let request = self.parserViewModel.request(urlPath: URLPathList.Shared.homeNotificationList, arguMents: arguMents)
            
            self.parserVm.parseApiRequest(request)
            self.parserVm.modelInfoKey = "NotificationDetails"
            self.parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    //print(responseHandler.info)
                    let notficationInfo = responseHandler.info.value(forKey: "NotificationInfo") as? [NSDictionary] ?? []
                    
                    let notificationLists = notficationInfo.map{ NotificationDetailsInfo(datas: $0) }
                    
                    self.notificationList = notificationLists.filter{ return $0.IsRead == 0 }
                    
                    
                    
            
                    
                    print("notification count : \(self.notificationList.count)")
                    
                }.store(in: &self.notificationDetailsCancellable)
        }
        
        
        
        
    }
    
    
    
    
    
}

extension NotificationVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationVm.notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.shared.notificationCell) as! NotificationTVC
        
        let notificationData = notificationVm.notificationList[indexPath.item]
            cell.viewModel = notificationData
            cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let readMessagePage = AppVC.Shared.ReadNotificationPage
        readMessagePage.modalTransitionStyle = .coverVertical
        readMessagePage.modalPresentationStyle = .overCurrentContext
        readMessagePage.delegate = self
        readMessagePage.viewModel = notificationVm.notificationList[indexPath.row]
        //print("message:\(self.notificationVm.notificationList[indexPath.item])")
        self.present(readMessagePage, animated: true) {
            let cell = tableView.cellForRow(at: indexPath) as! NotificationTVC
           cell.contentView.backgroundColor = AppColor.Shared.greyLite.withAlphaComponent(0.5)
           UIView.animate(withDuration: 1) {
               cell.contentView.backgroundColor = AppColor.Shared.colorWhite
               
               
           }
        }
        
        
        
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
}

extension NotificationVC:NotificationReadStatusDelegate{
    func didReadNotification(item: NotificationDetailsInfo) {
        print("Read notification: \(item)")
        UIView.animate(withDuration: 0.2) {
            self.notificationVm.notificationReadStatusAPICall(notificationID: "\(item.ID_Notification)")
        } completion: { completed in
            self.notificationVm.notificationReadStatusCancellable.dispose()
        }

        
    }
    
    
}

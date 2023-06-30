//
//  GlobalAPIViewModel.swift
//  ProdSuit
//
//  Created by MacBook on 27/02/23.
//

import Foundation
import Combine
import UIKit

class GlobalAPIViewModel{
   
    private var cancellables = Set<AnyCancellable>()
    lazy var bannerImageCancellable = Set<AnyCancellable>()
    let reachability  = Reachability()
    lazy var parserViewModel : APIParserManager = APIParserManager()
    var modelInfoKey : String = ""
    var isInternetConnected = Bool()
    let progressBar = Indicator()
    var successErrorView : SuccessErrorView!
    @Published  var responseHandler:successErrorHandler = successErrorHandler(statusCode: -11, message: "", info: [:])
    var datas : NSDictionary = [:]
    
    
    
    init(bgView:UIView){
        
    
        
        
        self.successErrorView = SuccessErrorView(bgView: bgView)
        
    }
    
    func NetworkCheck(){
        reachability.$isActive.sink { connected in
          self.isInternetConnected = connected
           
        }.store(in: &cancellables)
    }
    
    func parseApiRequest(_ request:URLRequest){
        
            
            cancellables.dispose()
        
            //let apiRequest = request
            
            parserViewModel.run(request)
            
                .receive(on: DispatchQueue.main)
                
                .sink { completion in
                
                switch completion{
                case .finished:
                    
                    print("successfully completed api call")
                    self.cancellables.dispose()
                    
                case.failure(let parserError):
                    switch parserError {
                    
                    case .customError(let _statusCode, let _msg):
                        print("status == \(_statusCode) msg == \(_msg)")
                        var message = ""
                        switch _msg{
                        case "The request timed out.":
                            message = "Timed out."
                        case "The network connection was lost.":
                            message = "No internet connection"
                        case "Could not connect to the server.":
                            message = generalErrorMsg
                        default:
                            message = generalErrorMsg
                        }
                        self.responseHandler = successErrorHandler(statusCode: _statusCode, message: "\(message)", info: [:])
                    case .internalError(_, _):
                        print("error")
                    case .serverError(_, _):
                        print("error")
                    }
                }
                
                
            } receiveValue: {[unowned self] result in
            
              let response = result.response as! HTTPURLResponse
                
                switch response.statusCode{
                case 200...299:
                   
                    let statusCode = result.value.value(forKey: "StatusCode") as! Int
                    let exMessage = result.value.value(forKey: "EXMessage") as? String ?? ""
                    let info =  self.modelInfoKey == "" ? result.value : result.value.value(forKey: self.modelInfoKey) as? NSDictionary ?? [:]
                    if statusCode == 0{
                        DispatchQueue.main.async {[weak self] in
                            self?.responseHandler = successErrorHandler(statusCode: statusCode, message: exMessage, info: info)
                        }
                        
                    }else{
                        
                        DispatchQueue.main.async {[weak self] in
                            self?.responseHandler = successErrorHandler(statusCode: statusCode, message: exMessage, info: [:])}
                        //self.successErrorView.showMessage(msg: exMessage,style: .failed)
                    }
                    
                case 400...499:
                    DispatchQueue.main.async {[weak self] in
                        self?.responseHandler = successErrorHandler(statusCode: response.statusCode, message: generalErrorMsg, info: [:])}
                    //self.successErrorView.showMessage(msg: generalErrorMsg,style: .failed)
                case 500:
                    DispatchQueue.main.async {[weak self] in
                        self?.responseHandler = successErrorHandler(statusCode: response.statusCode, message: generalErrorMsg, info: [:])}
                    //self.successErrorView.showMessage(msg: generalErrorMsg,style: .failed)
                    
                default:
                    print("default")
                }
                
                
            }.store(in: &cancellables)
            

            
       
        
    }
    
     func loadImage(urlString:String,imageView:UIImageView){
         if let url = URL(string: urlString){
            URLSession.init(configuration: .default, delegate: MySessionDelegate(), delegateQueue: nil)
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }   // 2
            .replaceError(with: nil)          // 3
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .assign(to: \.image, on: imageView)
            .store(in: &bannerImageCancellable)
         }
    }
    
    func statusCheck(data:NSDictionary,modelKey:String="",controller:UIViewController,actionHandler:@escaping()->Void){
        
        datas = [:]
        let statusCode = data.value(forKey: "StatusCode") as? Int ?? -99
        let message = data.value(forKey: "EXMessage") as? String ?? ""
        
        if statusCode == 0{
            
            datas = data.value(forKey: modelKey) as? NSDictionary ?? [:]
            
            
        }else{
            
            controller.popupAlert(title: "", message: message, actionTitles: ["Ok"], actions: [
                { action1 in
                    actionHandler()
                },nil
            ])
            
        }
    }
    
    
    func mainThreadCall(_ timeIntervel:TimeInterval=0.2,completion:@escaping()->()){
        DispatchQueue.main.asyncAfter(deadline: .now() + timeIntervel) {
            completion()
        }
    }
    
    
}

struct successErrorHandler{
    
    var statusCode:Int
    var message : String
    var info:NSDictionary
  
}

typealias DisposeBag = Set<AnyCancellable>

extension DisposeBag {
    mutating func dispose() {
        forEach { $0.cancel() }
        removeAll()
    }
}

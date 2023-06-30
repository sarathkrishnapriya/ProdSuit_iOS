//
//  NetworkReachability.swift
//  ProdSuit
//
//  Created by MacBook on 16/02/23.
//

import Foundation
import Network

class Reachability : ObservableObject{
    
    private let monitor = NWPathMonitor()
    
    private let queue = DispatchQueue(label: "Monitor")
    
    @Published var isActive = false
    
    @Published var isExpensive = false
    
    @Published var isConstrained = false
    
    @Published var connectionType = NWInterface.InterfaceType.other
    
    init() {
        
        monitor.pathUpdateHandler = { path in
            
            DispatchQueue.main.async {
                
                self.isActive = path.status == .satisfied
                
                self.isExpensive = path.isExpensive
                
                self.isConstrained = path.isConstrained
                
                let connectionTypes : [NWInterface.InterfaceType] = [.cellular,.wifi,.wiredEthernet]
                
                self.connectionType = connectionTypes.first(where: path.usesInterfaceType) ?? .other
                
            }
            
        }// pathHandler
        
        monitor.start(queue: queue)
        
    }
}

var allHeaderFields  = ["Accept": "application/json",
                       "Content-Type": "application/json",
                       "Authorization": "Bearer 12345678",
                       "Host": "api.producthunt.com"]

enum allHttpHeaderFields:String{
   
    
    
    case content_type = "Content-Type"
    case authorization = "Authorization"
    case accept = "Accept"
    

    
}


class AppExit{
    
    func exitApp(){
        
         exit(0)
        
    }
   
}


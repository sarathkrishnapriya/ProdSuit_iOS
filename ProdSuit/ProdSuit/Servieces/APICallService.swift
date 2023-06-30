//
//  APICallService.swift
//  ProdSuit
//
//  Created by MacBook on 22/02/23.
//

import Foundation
import UIKit
import Combine




var instanceOfEncryptionPost    : EncryptionPost    = EncryptionPost()

struct APIHeaders {
    
    static var ContentTypeKey = "Content-Type"
    static var ContentTypeValue = "application/json"
    
    static var TokenKey = "Authorization"
    
}

enum HTTPMethod:String{
    case POST = "POST"
    case GET = "GET"
    case DELETE = "DELETE"
    case PUT = "PUT"
}



enum ServiceErrors: Error {
    case internalError(_ statusCode: Int,_ msg:String)
    case serverError(_ statusCode: Int,_ msg:String)
    case customError(_statusCode:Int,_msg:String)
}



struct APIParserManager {
    
    
    
    
    struct Response<T> { // 1
        let value: T
        let response: URLResponse
    }
    
    
    
    mutating func run<T: NSDictionary>(_ request: URLRequest) -> AnyPublisher<Response<T>, ServiceErrors> { // 2
        let startDate = Date()
        let requestExecutionTime = Date().timeIntervalSince(startDate)
        return URLSession.init(configuration: .default, delegate: MySessionDelegate(), delegateQueue: nil)
            .dataTaskPublisher(for: request) // 3
            
            .tryMap { result -> Response<T> in
                let response = result.response
                guard let httpResponse = result.response as? HTTPURLResponse,
                        200..<300 ~= httpResponse.statusCode else {
                            switch (response as! HTTPURLResponse).statusCode {
                            case (400...499):
                                throw ServiceErrors.internalError((response as! HTTPURLResponse).statusCode,"Something went wrong. Do you want to continue")
                            default:
                                throw ServiceErrors.serverError((response as! HTTPURLResponse).statusCode,"Something went wrong. Do you want to continue")
                            }
                        }
                
                let value = try! JSONSerialization.jsonObject(with: result.data, options: []) as? NSDictionary ?? [:]// 4
                let executionTimeWithSuccess = Date().timeIntervalSince(startDate)
                print("time:\(executionTimeWithSuccess)")
                
                return Response(value: value as! T, response: result.response) // 5
            }
        
            
            .mapError{
                
                
                 ServiceErrors.customError(_statusCode: -999, _msg: "\($0.localizedDescription)")
                
                
            }
        
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher() // 7
            
        
        
    }
    
  
    
    func request(urlPath:String,method:HTTPMethod=HTTPMethod.POST,arguMents:[String:Any]=[:],token:Bool=false,hasImage:Bool=false,imageParam:[ImageData]=[])->URLRequest{
        
        let baseUrl = APIBaseUrl + APIBaseUrlPart + urlPath
        
        print("{BaseUrl:\(baseUrl),Method:\(method.rawValue),Arguments:\(arguMents)}")
        
        var request = URLRequest(url: URL(string: baseUrl)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 30)
        
        request.httpMethod = method.rawValue
        
        var multipart = MultipartRequest()
        
        if token == true{
            print("token")
            //request.setValue("", forHTTPHeaderField: APIHeaders.TokenKey)
        }
        if hasImage == true{
            
            
            
            for field in arguMents {
                multipart.add(key: field.key, value: field.value as! String)
            }
            
            for imgItem in imageParam{
                multipart.add(
                    key: "file",
                    fileName: imgItem.fileName,
                    fileMimeType: "image/png",
                    fileData: imgItem.imgData
                )
            }
            
            
            request.setValue(multipart.httpContentTypeHeadeValue, forHTTPHeaderField: "Content-Type")
            request.httpBody = multipart.httpBody
            
            
            
        }else{
            request.httpBody = try! JSONSerialization.data(withJSONObject: arguMents, options: .prettyPrinted)
            
            request.setValue(APIHeaders.ContentTypeValue, forHTTPHeaderField: APIHeaders.ContentTypeKey)
        }
        
        print(request)
        return request
    }
}


public struct MultipartRequest {
    
    public let boundary: String
    
    private let separator: String = "\r\n"
    private var data: Data

    public init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
        self.data = .init()
    }
    
    private mutating func appendBoundarySeparator() {
        data.append("--\(boundary)\(separator)")
    }
    
    private mutating func appendSeparator() {
        data.append(separator)
    }

    private func disposition(_ key: String) -> String {
        "Content-Disposition: form-data; name=\"\(key)\""
    }

    public mutating func add(
        key: String,
        value: String
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + separator)
        appendSeparator()
        data.append(value + separator)
    }

    public mutating func add(
        key: String,
        fileName: String,
        fileMimeType: String,
        fileData: Data
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + "; filename=\"\(fileName)\"" + separator)
        data.append("Content-Type: \(fileMimeType)" + separator + separator)
        data.append(fileData)
        appendSeparator()
    }

    public var httpContentTypeHeadeValue: String {
        "multipart/form-data; boundary=\(boundary)"
    }

    public var httpBody: Data {
        var bodyData = data
        bodyData.append("--\(boundary)--")
        return bodyData
    }
}


public extension Data {

    mutating func append(
        _ string: String,
        encoding: String.Encoding = .utf8
    ) {
        guard let data = string.data(using: encoding) else {
            return
        }
        append(data)
    }
}

struct ImageData{
    var fileName:String
    var imgData:Data
}


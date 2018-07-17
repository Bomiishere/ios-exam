//
//  DataLoader.swift
//  MVVMPractice
//
//  Created by Bomi on 2018/7/2.
//  Copyright © 2018年 Bomi. All rights reserved.
//

import Foundation

protocol NetworkService {
    
    @discardableResult
    func getData(url: URL, headers: [String: String]?, completion: @escaping (Result<Data>) -> Void) -> RequestToken
}

class DataLoader: NetworkService {
    
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    @discardableResult
    func getData(url: URL, headers: [String : String]?, completion: @escaping (Result<Data>) -> Void) -> RequestToken {
        
        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            return request
        }()
        
        let task = session.dataTask(with: request) { (data, response, error) in
            //TODO: use response
            
            switch (data, error) {
                
            case (_, let error?):
                
                completion(.error(error))
            
            case (let data?, _):
                
                completion(.success(data))
                
            case (nil, nil):
                completion(.error(NetworkError.dataTaskError))
            
            default:
                break
            }
            
        }
        
        task.resume()
        
        return RequestToken(task: task)
    }
    
}

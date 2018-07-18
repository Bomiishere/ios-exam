//
//  UserProvider.swift
//  MVVMPractice
//
//  Created by Bomi on 2018/7/4.
//  Copyright © 2018年 Bomi. All rights reserved.
//

import Foundation

protocol UserProvidable {
    func getUsers(completion: @escaping ([User]?, Error?) -> Swift.Void)
}

class UserProvider: UserProvidable {
    
    private var dataLoader: NetworkService
    
    private var url: URL? {
        let urlComp = NSURLComponents(string: "http://123.192.166.185/api/users/userinfo")!
        var items = [URLQueryItem]()
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        return urlComp.url
    }
    
    private var params: [String: String] {
        return ["index": "\(offset)", "size": "\(size)"]
    }
    
    private var headers: [String: String]? = ["authorization" : "c91432a9b67d080e9bbc25a12553dedd#0#examId"] // fake
    
    private var offset = 0
    
    private let size = 10
    
    private var requestToken: RequestToken? = nil
    
    private let userCache = NSCache<NSString, NSData>()
    
    init(dataLoader: DataLoader) {
        self.dataLoader = dataLoader
    }
    
    func getUsers(completion: @escaping ([User]?, Error?) -> Void) {
        
        guard let url = self.url else {
            completion(nil, NetworkError.URLFormFail)
            return
        }
        
        //Cache
        if let cacheData = self.userCache.object(forKey: NSString(string: url.absoluteString)) {
            
            do {
                let users = try JSONDecoder().decode([User].self, from: Data(referencing: cacheData))
                
                completion(users, nil)
                
                return
                
            } catch {
                
                completion(nil, error)
                
                return
            }
        }
        
        //Requst
        requestToken = dataLoader.getData(url: url, headers: headers, completion: { [unowned self] (result) in
            
            switch result {
                
            case .success(let data):
                
                let decoder: JSONDecoder = JSONDecoder()
                
                do {
                    //parse
                    let dataJson = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    guard let data = dataJson as? [String: AnyObject], let usersJsonObject = data[ParserKey.users] as? [NSDictionary] else {
                        completion (nil, NetworkError.parseError)
                        return
                    }
                    
                    //transfer to model
                    let usersArrData = try JSONSerialization.data(withJSONObject: usersJsonObject, options: .prettyPrinted)
                    
                    
                    // save cache
                    self.userCache.setObject(NSData(data: usersArrData), forKey: NSString(string: url.absoluteString))
                    
                    let users = try decoder.decode([User].self, from: usersArrData)
                    
                    self.offset += self.size
                    
                    completion(users, nil)
                    
                } catch {
                    
                    completion(nil, error)
                    
                }
                
                break
                
            case .error(let error):
                
                completion(nil, error)
                
                break
                
            }
        })
        
    }
    
}

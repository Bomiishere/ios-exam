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
        let urlComp = NSURLComponents(string: "http://123.192.166.185/api/User/AllUser")!
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
    private var headers: [String: String]? = ["authorization" : "c91432a9b67d080e9bbc25a12553dedd#0#examId"]
    private var offset = 0
    private let size = 10
    
    private var requestToken: RequestToken? = nil
    
    init(dataLoader: DataLoader) {
        self.dataLoader = dataLoader
    }
    
    func getUsers(completion: @escaping ([User]?, Error?) -> Void) {
        
        guard let url = url else {
            completion(nil, NetworkError.URLFormFail)
            return
        }
        
        requestToken = dataLoader.getData(url: url, headers: headers, completion: { [unowned self] (result) in
            
            switch result {
                
            case .success(let data):
                
                let decoder: JSONDecoder = JSONDecoder()
                
                do {
                    //parse
//                    var data = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                    
//                    data = fakeData as [String : AnyObject]
                    
//                    guard let usersArr = data?[ParserKey.users] as? [AnyObject]  else {
//                        completion (nil, NetworkError.parseError)
//                        return
//                    }

                    let usersJson = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    guard let usersJsonObject = usersJson as? [NSDictionary] else {
                        completion (nil, NetworkError.parseError)
                        return
                    }
                    
                    //transfer to model
                    let usersArrData = try JSONSerialization.data(withJSONObject: usersJsonObject, options: .prettyPrinted)
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

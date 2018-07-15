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
    private let url: String = "http://stage-api-dot-framy-cloud-163005.appspot.com/test1.0/backstage/exm1"
    private var headers: [String: String]? = ["authorization" : "c91432a9b67d080e9bbc25a12553dedd#0#examId"]
    private var requestToken: RequestToken? = nil
    private var offset = 0
    
    init(dataLoader: DataLoader) {
        self.dataLoader = dataLoader
    }
    
    func getUsers(completion: @escaping ([
        User]?, Error?) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(nil, NetworkError.URLFormFail)
            return
        }
        
        requestToken = dataLoader.getData(url: url, headers: headers, completion: { [unowned self] (result) in
            
            switch result {
                
            case .success(let data):
                
                let decoder: JSONDecoder = JSONDecoder()
                
                do {
                    //parse
                    var data = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                    
                    data = fakeData as [String : AnyObject]
                    
                    guard let usersArr = data?[ParserKey.users] as? [AnyObject]  else {
                        completion (nil, NetworkError.parseError)
                        return
                    }
                    
                    //transfer to model
                    let usersArrData = try JSONSerialization.data(withJSONObject: usersArr, options: .prettyPrinted)
                    let users = try decoder.decode([User].self, from: usersArrData)
                    
                    self.offset += 10
                    
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

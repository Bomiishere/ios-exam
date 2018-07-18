//
//  UserListViewModel.swift
//  UserListsMVVM
//
//  Created by Bomi on 2018/7/15.
//  Copyright © 2018年 Bomi. All rights reserved.
//

import Foundation

struct UserListViewModel: MutatingClosure {
    
    var viewController: UserListViewController?
    
    var binder: Binder?
    
    var title: String? = "User List"
    
    var users: [UserViewModel] = [UserViewModel]()
    
    private let userProvider: UserProvider = UserProvider(dataLoader: DataLoader())
}

extension UserListViewModel {
    init(vc: UserListViewController & Binder) {
        self.viewController = vc
        self.binder = vc
    }
}

extension UserListViewModel {
    
    mutating func loadUsers() {
        
        let copySelf = self
        
        userProvider.getUsers { (users, error) in
            
            copySelf.mutating({ (mutatingSelf: inout UserListViewModel) in
                
                if let error = error {
                    //TODO: Handle errors
                    print(error)
                    return
                }
                
                guard let users = users else {
                    return;
                }
                
                let userViewModels = users.compactMap({ UserViewModel(user: $0) })
              
                mutatingSelf.users.append(contentsOf: userViewModels)
            })
            
        }
    }
}

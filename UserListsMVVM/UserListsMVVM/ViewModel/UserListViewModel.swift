//
//  UserListViewModel.swift
//  UserListsMVVM
//
//  Created by Bomi on 2018/7/15.
//  Copyright © 2018年 Bomi. All rights reserved.
//

import Foundation

struct UserListViewModel {
    var title: String? = "User List"
    var users: [UserViewModel] = [UserViewModel]()
}

extension UserListViewModel {
    init(users: [UserViewModel]) {
        self.users = users
    }
}

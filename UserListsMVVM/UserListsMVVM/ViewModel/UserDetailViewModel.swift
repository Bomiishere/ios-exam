//
//  UserDetailViewModel.swift
//  UserListsMVVM
//
//  Created by Bomi on 2018/7/15.
//  Copyright © 2018年 Bomi. All rights reserved.
//

import Foundation

struct UserDetailViewModel {
    let title: String = "Detail"
    var titles: [String] = []
    var descriptions: [String] = []
    private var user: UserViewModel? = nil
}

extension UserDetailViewModel {
    
    init(user: UserViewModel) {
        self.user = user
        
        let userMirror = Mirror(reflecting: user)
        for item in userMirror.children {
            guard let label = item.label else { continue }
            if label != "id" {
                self.titles.append(label)
            }
        }
        
        self.descriptions = [
            user.firstName ?? "",
            user.lastName ?? "",
            user.birthday ?? "",
            user.age ?? "",
            user.email ?? "",
            user.mobile ?? "",
            user.address ?? "",
            user.contactPerson ?? "",
            user.contactPersonPhone ?? "",
        ]
    }
}

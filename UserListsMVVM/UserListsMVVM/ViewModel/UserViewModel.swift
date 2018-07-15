//
//  UserViewModel.swift
//  UserListsMVVM
//
//  Created by Bomi on 2018/7/15.
//  Copyright © 2018年 Bomi. All rights reserved.
//

import Foundation

struct UserViewModel {
    let id : String
    let firstName : String?
    let lastName : String?
    let birthday : String?
    let age : String?
    let email : String?
    let mobile : String?
    let address : String?
    let contactPerson : String?
    let contactPersonPhone : String?
}

extension UserViewModel {
    init(user: User) {
        self.id = user.id
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.birthday = user.birthday
        self.age = user.age
        self.email = user.email
        self.mobile = user.mobile
        self.address = user.address
        self.contactPerson = user.contactPerson
        self.contactPersonPhone = user.contactPersonPhone
    }
}


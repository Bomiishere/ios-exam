//
//  User.swift
//  UserListsMVVM
//
//  Created by Bomi on 2018/7/15.
//  Copyright © 2018年 Bomi. All rights reserved.
//

import Foundation

struct User: Codable  {
    let id : Int
    let firstName : String?
    let lastName : String?
    let birthday : String?
    let age : Int?
    let email : String?
    let mobile : String?
    let address : String?
    let contactPerson : String?
    let contactPersonPhone : String?
    
    init(id: Int, firstName: String? = nil, lastName: String? = nil, birthday: String? = nil, age: Int? = nil, email: String? = nil, mobile: String? = nil, address: String? = nil, contactPerson: String? = nil, contactPersonPhone: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.birthday = birthday
        self.age = age
        self.email = email
        self.mobile = mobile
        self.address = address
        self.contactPerson = contactPerson
        self.contactPersonPhone = contactPersonPhone
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(birthday, forKey: .birthday)
        try container.encode(age, forKey: .age)
        try container.encode(email, forKey: .email)
        try container.encode(mobile, forKey: .mobile)
        try container.encode(address, forKey: .address)
        try container.encode(contactPerson, forKey: .contactPerson)
        try container.encode(contactPersonPhone, forKey: .contactPersonPhone)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case birthday = "birthday"
        case age = "age"
        case email = "email"
        case mobile = "mobile"
        case address = "address"
        case contactPerson = "contact_person"
        case contactPersonPhone = "contact_person_phone"
    }
}

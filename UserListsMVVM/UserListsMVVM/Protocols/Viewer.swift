//
//  Viewer.swift
//  UserListsMVVM
//
//  Created by Bomi on 2018/7/18.
//  Copyright © 2018年 Bomi. All rights reserved.
//

public protocol Viewer: Binder {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
}

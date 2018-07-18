//
//  Binder.swift
//  UserListsMVVM
//
//  Created by Bomi on 2018/7/18.
//  Copyright © 2018年 Bomi. All rights reserved.
//

import UIKit

public protocol Binder: class {
    
    var dataContext: Any? { get set}
    
}

public protocol Viewer: Binder {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
}

extension Binder where Self: Viewer {
    
    public var dataContext: Any? {
        
        get {
            return viewModel
        }
        
        set {
            viewModel = newValue as! ViewModelType
        }
        
    }
    
}




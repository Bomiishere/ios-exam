//
//  MutatingClosure.swift
//  UserListsMVVM
//
//  Created by Bomi on 2018/7/18.
//  Copyright © 2018年 Bomi. All rights reserved.
//

import UIKit

public protocol MutatingClosure {
    
    var binder: Binder? { get }
    
    func mutating(_ closure: (_ mutatingSelf: inout Self) -> Void) -> Void
    
    // 立即寫回ViewController
    func commit()
    
}

extension MutatingClosure {
    
    public func mutating(_ closure: (_ mutatingSelf: inout Self) -> Void) -> Void {
        
        guard var viewModel = binder?.dataContext as? Self else {
            return
        }
        
        closure(&viewModel)
        
        binder?.dataContext = viewModel
        
    }
    
    public func commit() {
        binder?.dataContext = self
    }
    
}

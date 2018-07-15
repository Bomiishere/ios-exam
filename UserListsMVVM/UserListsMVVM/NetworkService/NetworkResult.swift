//
//  NetworkResult.swift
//  MVVMPractice
//
//  Created by Bomi on 2018/7/2.
//  Copyright © 2018年 Bomi. All rights reserved.
//

import Foundation

enum Result<T> {
    
    case success(T)
    
    case error(Error)
}

enum NetworkError: Error {
    
    case dataTaskError
    
    case parseError
    
    case URLFormFail
    
}

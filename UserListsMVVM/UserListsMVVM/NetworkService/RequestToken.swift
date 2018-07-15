//
//  RequestToken.swift
//  MVVMPractice
//
//  Created by Bomi on 2018/7/2.
//  Copyright © 2018年 Bomi. All rights reserved.
//

import Foundation

class RequestToken {
    
    private weak var task: URLSessionTask?
    
    init(task: URLSessionTask? = nil) {
        self.task = task
    }
    
    func cancel() {
        task?.cancel()
    }
    
}

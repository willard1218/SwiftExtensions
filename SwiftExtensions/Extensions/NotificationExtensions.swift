//
//  NotificationExtensions.swift
//  SwiftExtensions
//
//  Created by willard on 2017/12/31.
//  Copyright © 2017年 willard. All rights reserved.
//

import Foundation
protocol Notifiable {
    var name: Notification.Name { get }
    func observe(by observer: Any, withSelector selector: Selector, object: Any?)
    func post(object: Any? ,userInfo: [AnyHashable: Any]?)
    static func remove(observer: Any)
}


extension Notifiable {
    func observe(by observer: Any, withSelector selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
    
    func post(object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
    }
    
    static func remove(observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
}

enum Notifier: String, Notifiable {
    case updateData
    
    var name: Notification.Name {
        return Notification.Name(rawValue)
    }
    
    enum System: Notifiable {
        case keyBoardWillHide, keyBoardWillShow
        
        var name: Notification.Name {
            switch self {
            case .keyBoardWillHide:
                return Notification.Name.UIKeyboardWillHide
            case .keyBoardWillShow:
                return Notification.Name.UIKeyboardWillShow
            }
        }
    }
}

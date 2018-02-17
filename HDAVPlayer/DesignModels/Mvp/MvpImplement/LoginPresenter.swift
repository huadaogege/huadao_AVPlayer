//
//  LoginPresenter.swift
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/2/16.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

import UIKit

class LoginPresenter: NSObject, MvpPresenter {
    private let model = LoginModel()
    private var view:LoginView?
    
    func attachView(view:LoginView) {
        self.view = view
    }
    
    func detachView(view:LoginView) {
        self.view = nil
    }
    
    func login(name:String, pwd:String) {
        model.login(name: name, pwd: pwd) { (result) in
            if (self.view != nil) {
                self.view?.onLoginResult(data: result as NSObject)
            }
        }
    }
}

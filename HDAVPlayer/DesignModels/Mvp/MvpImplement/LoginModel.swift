//
//  LoginModel.swift
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/2/16.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

import UIKit

class LoginModel: NSObject, MvpModel {
    func login(name: String, pwd: String, callBack:@escaping ((String) -> Swift.Void)) {
        HttpUtils.post(name: name, pwd: pwd) { (result) in
            callBack(result)
        }
    }
}

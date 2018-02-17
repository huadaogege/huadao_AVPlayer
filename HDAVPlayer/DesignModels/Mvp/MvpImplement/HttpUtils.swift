//
//  HttpUtils.swift
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/2/17.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

import UIKit

class HttpUtils: NSObject {
    class func post (name:String, pwd:String, callBack:@escaping ((String) -> Swift.Void)) {
        let url = URL(string:"https://www.baidu.com")
        var request = URLRequest(url:url!)
        request.httpMethod = "POST"
        let params = "userName=\(name)&password=\(pwd)"
        request.httpBody = params.data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("请求失败！")
            } else {
                print("请求成功！")
                let resultStr = String(data: data!, encoding:String.Encoding.utf8)
                callBack(resultStr!)
            }
        }
        dataTask.resume()
    }
}

//
//  MvpViewController.swift
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/2/17.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

import UIKit

class MvpViewController: UIViewController, LoginView {
    
    private let presenter = LoginPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        // Do any additional setup after loading the view.
    }
    
    func onLoginResult(data: NSObject) {
        print("回到了UI层")
    }
    
    @IBAction func loginRequest(_ sender: Any) {
        self.presenter.login(name: "cuiyuguan", pwd: "cyg08212611")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        presenter.detachView(view: self)
        // Dispose of any resources that can be recreated.
    }
    
}


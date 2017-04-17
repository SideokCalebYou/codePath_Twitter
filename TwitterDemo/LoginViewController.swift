//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by sideok you on 4/14/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func onLoginButton(_ sender: Any) {
    let client = TwitterClient.sharedInstance?.login(success: {
      //segue here
      self.performSegue(withIdentifier: "loginSegue", sender: nil)
      
    }, failure: { (error:Error) in
      print("error \(error.localizedDescription)")
    })
    
  }
}

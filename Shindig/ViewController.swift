//
//  ViewController.swift
//  Shindig
//
//  Created by Ryann Consalo on 2017/06/20.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class ViewController: UIViewController, LoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .userFriends])
        loginButton.delegate = self
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        
        // Code from facebook 
        /*
    - (void)viewDidLoad
    {
    [super viewDidLoad];
    if ([FBSDKAccessToken currentAccessToken]) {
    // User is logged in, do work such as go to next view controller.
    }
         }
    */
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        // Successfully logged in --> what to do now
        /*
         let homeView = self.storyboard?.instantiateViewController(withIdentifier: "HomeView")
        self.present(homeView!, animated: true, completion: nil)
         */
        
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        //logged out
    }



}


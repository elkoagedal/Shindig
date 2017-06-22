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
//import FirebaseAuth

class ViewController: UIViewController, LoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let accessToken = AccessToken.current

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
        /*
        let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
        
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                // ...
                return
                
            }
            // User is signed in
            // ...
            
            let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainView")
            self.present(ViewController!, animated: true, completion: nil)
            
        }
        

 */
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainView")
        self.present(ViewController!, animated: true, completion: nil)


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


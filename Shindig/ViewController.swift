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
import FBSDKCoreKit
import Firebase
import FirebaseDatabase
//import FirebaseAuth

class ViewController: UIViewController, LoginButtonDelegate {
    
    var userData: [String:Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let params = ["fields": "id, first_name, last_name, name, email, picture"]
        
       // let accessToken = AccessToken.current

        let loginButton = LoginButton(readPermissions: [ .publicProfile, .userFriends, .email])
        loginButton.delegate = self
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        /*
        let graphRequest = FBSDKGraphRequest(graphPath: "/me", parameters: params)
        let connection = FBSDKGraphRequestConnection()
        connection.add(graphRequest, completionHandler: { (connection, result, error) in
            if error == nil {
                if let userData = result as? [String:Any] {
                    //print(userData)
                    let data = userData["data"] as! NSArray
                    var d = data[0] as! NSDictionary
                    print(d)
                    for (key, value) in d {
                        if (key as! String == "id") {
                            UserDefaults.standard.set(value, forKey: "Username")
                        }
                    }
                } else {
                    print("Error Getting Data \(error)");
                }
                
            }
        })
        connection.start()
        */
        /*if let accessToken = AccessToken.current {
            // grabbing access token
            let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print(user?.displayName)
                
            }
        }
        */
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainView")
        self.present(ViewController!, animated: true, completion: nil)
        

        
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
        
        let params = ["fields": "id, first_name, last_name, name, email, picture"]
        
        let graphRequest = FBSDKGraphRequest(graphPath: "/me", parameters: params)
        let connection = FBSDKGraphRequestConnection()
        connection.add(graphRequest, completionHandler: { (connection, result, error) in
            if error == nil {
                if let userData = result as? [String:Any] {
                    print(userData)
                    //let data = userData["data"] as! NSArray
                    var d = userData as! NSDictionary
                    print(d)
                    for (key, value) in d {
                        if (key as! String == "id") {
                            UserDefaults.standard.set(value, forKey: "Username")
                            print(UserDefaults.standard.value(forKey: "Username"))
                        }
                    }
                } else {
                    print("Error Getting Data \(error)");
                }
                
            }
        })
        connection.start()

        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainView")
        self.present(ViewController!, animated: true, completion: nil)

        
        
        
        
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


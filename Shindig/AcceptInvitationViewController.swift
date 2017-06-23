//
//  AcceptInvitationViewController.swift
//  Shindig
//
//  Created by Emily Koagedal on 6/22/17.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AcceptInvitationViewController: UIViewController {
    
    var key : String?

    @IBAction func acceptButton(_ sender: Any) {
        var ref = Database.database().reference().child("Events").child(key!).child("Attendees").child(UserDefaults.standard.string(forKey: "Username")!).setValue("coming")
    }
    
    
    @IBAction func noButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "goToDetails") {
            
            let details = segue.destination as! IPOverviewViewController
            //let details2 = details.topViewController as! HPOverviewViewController
                
            details.key = key

        }
    }
    

}

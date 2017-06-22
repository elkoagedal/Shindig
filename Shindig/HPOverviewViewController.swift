//
//  HPOverviewViewController.swift
//  Shindig
//
//  Created by Emily Koagedal on 6/20/17.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import UIKit
import CircleAnimatedMenu
import Firebase
import FirebaseDatabase

class HPOverviewViewController: UIViewController, CircleAnimatedMenuDelegate {
    
    var key : String?
    
    @IBOutlet weak var testMenu: CircleAnimatedMenu!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var totalPoolLabel: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        testMenu.imageSize = 40
        testMenu.outerRadius = 150
        testMenu.innerRadius = 50
        testMenu.closerBorderWidth = 0
        testMenu.menuWidthLine = 1
        testMenu.titleFont = UIFont.systemFont(ofSize: 14)
        testMenu.delegate = self
        testMenu.highlightedColors = [.red, .orange, .yellow, .green, .blue, .cyan, .purple]
        testMenu.tuplesArray = [("http://www.freeiconspng.com/uploads/profile-icon-9.png", "Emily"), ("instagram-1", "Instagram"), ("Twitter", "Twitter"),
                                ("LinkedIn", "LinkedIn"), ("Google Plus +", "GooglePlus"), ("Pinterest", "Pinterest"),
                                ("RSS", "RSS"), ("YouTube", "YouTube"), ("Bloglovin", "Bloglovin"),
                                ("Emai", "Email"), ("Flickr", "Flickr"), ("github", "GitHub")]
        testMenu.reloadInputViews()
        
        var ref = Database.database().reference().child("Events").child(key!)
        var dat = ref.observe(.value, with: { (snapshot) in
            
            // If no supplies exist, display alert
            if !snapshot.exists() {
                let alertController = UIAlertController(title: "No Supplies Found", message: " ", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
                
                
                // Put supplies in the supplies array
            else {
                print(snapshot)
                let dict1 = snapshot.value as! NSDictionary
                
                for (key, value) in dict1 {
                    if ((key as! String) == "date") {
                        self.dateLabel.text = value as! String
                    }
                    
                    if ((key as! String) == "details") {
                        self.detailsLabel.text = value as! String
                    }
                    
                    if ((key as! String) == "location") {
                        self.locationLabel.text = value as! String
                    }
                    
                    /*if (key == "name") {
                        nameLable.text = value
                    }
                    */
                    
                    if ((key as! String) == "price") {
                        self.priceLabel.text = value as! String
                    }
                    
                    if ((key as! String) == "time") {
                        self.timeLabel.text = value as! String
                    }
            
                }
            }
        })

        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        image.layer.zPosition = 999
    }
    
    func sectionSelected(text: String, index: Int) {
        print(text)
        image.image = #imageLiteral(resourceName: "add")
    }

/*
    extension HPOverviewViewController: CircleAnimatedMenuDelegate {
        func sectionSelected(text: String, index: Int) {
            print("text - \(text), index - \(index)")
        }
    }
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "editDetails") {
            let edit = segue.destination as! EditYourShindigViewController
            edit.key = key
        }
        
        if (segue.identifier == "navToSupplies") {
            let sup = segue.destination as! HPSuppliesTableViewController
            sup.key = key
        }
    }
    

}

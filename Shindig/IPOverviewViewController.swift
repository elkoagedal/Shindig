//
//  IPOverviewViewController.swift
//  Shindig
//
//  Created by Emily Koagedal on 6/20/17.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import UIKit
import CircleAnimatedMenu
import Firebase
import FirebaseDatabase

class IPOverviewViewController: UIViewController {
    @IBOutlet weak var testMenu: CircleAnimatedMenu!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextView!
    
    var key : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        testMenu.imageSize = 40
        testMenu.outerRadius = 150
        testMenu.innerRadius = 50
        testMenu.closerBorderWidth = 0
        testMenu.menuWidthLine = 1
        testMenu.titleFont = UIFont.systemFont(ofSize: 9)
        testMenu.delegate = self as? CircleAnimatedMenuDelegate
        testMenu.highlightedColors = [.cyan, .yellow, .purple, .red, .brown]
        testMenu.tuplesArray = [("Emily", "Emily"), ("Ryann", "Ryann"), ("Elise", "Elise"),
                                ("Katherine", "Katherine"), ("Fran", "Fran"), ("Claire", "Claire"),
                                ("Hannah", "Hannah"), ("Grace", "Grace"), ("Lea", "Lea")]
        
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
                        self.dateTextField.text = value as! String
                    }
                    
                    if ((key as! String) == "details") {
                        self.detailsTextField.text = value as! String
                    }
                    
                    if ((key as! String) == "location") {
                        self.locationTextField.text = value as! String
                    }
                    
                    /*if (key == "name") {
                     nameLable.text = value
                     }
                     */
                    
                    if ((key as! String) == "price") {
                        self.priceTextField.text = value as! String
                    }
                    
                    if ((key as! String) == "time") {
                        self.timeTextField.text = value as! String
                    }
                    
                }
            }
        })
        

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    extension IPOverviewViewController: CircleAnimatedMenuDelegate {
        func sectionSelected(text: String, index: Int) {
            print("text - \(text), index - \(index)")
        }
    }
 */


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "deets") {
            var b = segue.destination as! IPSuppliesTableViewController
            b.key = key
        }
        
    }
    

}

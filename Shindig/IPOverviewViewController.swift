//
//  IPOverviewViewController.swift
//  Shindig
//
//  Created by Emily Koagedal on 6/20/17.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import UIKit
import CircleAnimatedMenu

class IPOverviewViewController: UIViewController {
    @IBOutlet weak var testMenu: CircleAnimatedMenu!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        testMenu.imageSize = 40
        testMenu.outerRadius = 150
        testMenu.innerRadius = 50
        testMenu.closerBorderWidth = 0
        testMenu.menuWidthLine = 1
        testMenu.titleFont = UIFont.systemFont(ofSize: 14)
        testMenu.delegate = self as? CircleAnimatedMenuDelegate
        testMenu.highlightedColors = [.green, .yellow, .purple, .red, .brown]
        testMenu.tuplesArray = [("Facebook-1", "Facebook"), ("instagram-1", "Instagram"), ("Twitter", "Twitter"),
                                ("LinkedIn", "LinkedIn"), ("Google Plus +", "GooglePlus"), ("Pinterest", "Pinterest"),
                                ("RSS", "RSS"), ("YouTube", "YouTube"), ("Bloglovin", "Bloglovin"),
                                ("Emai", "Email"), ("Flickr", "Flickr"), ("github", "GitHub")]
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

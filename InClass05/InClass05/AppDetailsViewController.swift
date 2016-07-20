//
//  AppDetailsViewController.swift
//  InClass05
//
//  Created by Carlos Rosario on 7/19/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import SDWebImage

class AppDetailsViewController: UIViewController {

    
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appLargeImage: UIImageView!
    @IBOutlet weak var appDeveloperName: UILabel!
    @IBOutlet weak var appReleaseDate: UILabel!
    @IBOutlet weak var appPrice: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        updateUI()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func closeButton(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true) { 
            
        }
        
    }
    
    var data: (title: String, developer: String, imgSmall: String, imgLarge: String, price: String, releaseDate: String)?
    
    private func updateUI(){
        
        //reset any existing information
        appLargeImage?.image = nil
        appReleaseDate?.text = nil
        appTitle?.text = nil
        appDeveloperName?.text = nil
        appPrice?.text = nil
        
        
        // set image view
        let imageUrl:NSURL? = NSURL(string: (data?.imgLarge)!)
        
        if let url = imageUrl{
            appLargeImage.sd_setImageWithURL(url)
        }
        
        // set release date
        appReleaseDate?.text = data?.releaseDate
        
        // set app title
        appTitle?.text = data?.title
        
        // set app developer name
        appDeveloperName?.text = data?.developer
        
        // set app price
        if let price = data?.price{
            let readablePrice = price.substringWithRange(Range<String.Index>(start: price.startIndex, end: price.startIndex.advancedBy(4)))
            appPrice?.text = "$" + readablePrice
        }
        else {
            appPrice?.text = data?.price
        }
        
    }

    
    
}

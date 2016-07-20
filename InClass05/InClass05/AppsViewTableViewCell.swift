//
//  AppsViewTableViewCell.swift
//  InClass05
//
//  Created by Carlos Rosario on 7/19/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import SDWebImage

class AppsViewTableViewCell: UITableViewCell {


    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appReleaseDate: UILabel!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appDeveloperName: UILabel!
    @IBOutlet weak var appPrice: UILabel!
    
    var data: (title: String, developer: String, imgSmall: String, imgLarge: String, price: String, releaseDate: String)? {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        
        //reset any existing information
        appImageView?.image = nil
        appReleaseDate?.text = nil
        appTitle?.text = nil
        appDeveloperName?.text = nil
        appPrice?.text = nil
        
        
        // set image view
        let imageUrl:NSURL? = NSURL(string: (data?.imgSmall)!)
        
        if let url = imageUrl{
                appImageView.sd_setImageWithURL(url)
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

//
//  SummaryTableViewCell.swift
//  InClass07
//
//  Created by Carlos Rosario on 7/26/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import SDWebImage

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    var data: (category: String, artist: String, name: String, squareImage: String, releaseDate: String, price: String, summary: String)? {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        // reset any existing information
        thumbImageView?.image = nil
        name?.text = nil
        title?.text = nil
        releaseDate?.text = nil
        price?.text = nil
        summary?.text = nil
        
        // set image view
        let imageUrl:NSURL? = NSURL(string: (data?.squareImage)!)
        if let url = imageUrl{
            thumbImageView.sd_setImageWithURL(url)
        }
        
        // set developer name
        name?.text = data?.artist
        
        // set app title
        title?.text = data?.name
        
        // set release date
        releaseDate?.text = data?.releaseDate
        
        // set price
        price?.text = "$" + (data?.price)!
        
        // set summary
        summary?.text = data?.summary
    }
}

//
//  NormalTableViewCell.swift
//  InClass07
//
//  Created by Carlos Rosario on 7/26/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import SDWebImage

class NormalTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var data: (category: String, artist: String, name: String, squareImage: String, releaseDate: String, price: String)? {
        didSet{
            updateUI()
        }
    }

    private func updateUI(){
//        // reset any existing information
//        smallImage?.image = nil
        thumbImageView?.image = nil
        releaseDate?.text = nil
        title?.text = nil
        price?.text = nil
        descriptionLabel?.text = nil
        
        
        // set image view
        let imageUrl:NSURL? = NSURL(string: (data?.squareImage)!)
        if let url = imageUrl{
            thumbImageView.sd_setImageWithURL(url)
//            thumbImageView.frame = CGRect(x:0, y: 0, width:50, height:50)
        }
        
        releaseDate?.text = data?.releaseDate
        title?.text = data?.name
        descriptionLabel?.text = data?.artist
        price?.text = "$" + (data?.price)!
    }
}

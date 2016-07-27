//
//  LargeImageTableViewCell.swift
//  InClass07
//
//  Created by Carlos Rosario on 7/26/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import SDWebImage
class LargeImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var largeImage: UIImageView!
    
    var data: (category: String, artist: String, name: String, squareImage: String, releaseDate: String, price: String, otherImage: String)? {
        didSet{
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateUI(){
//        // reset any existing information
        thumbImageView?.image = nil
        name?.text = nil
        title?.text = nil
        releaseDate?.text = nil
        price?.text = nil
        largeImage?.image = nil
        
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
        
        // set large image
        let largeImageUrl:NSURL? = NSURL(string: (data?.otherImage)!)
        if let largeUrl = largeImageUrl{
            largeImage.sd_setImageWithURL(largeUrl)
        }
    }

}

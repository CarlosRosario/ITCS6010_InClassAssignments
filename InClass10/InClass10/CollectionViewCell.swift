//
//  CollectionViewCell.swift
//  InClass10
//
//  Created by Carlos Rosario on 8/4/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var data: (image: String, other: String)? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI(){
        // reset any existing information
        imageView?.image = nil
        
        let imageURL:NSURL? = NSURL(string: (data!.image))
        if let url = imageURL{
            imageView.sd_setImageWithURL(url)
        }
        
    }
    
}

//
//  NormalTableViewCell.swift
//  InClass06
//
//  Created by Carlos Rosario on 7/21/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class NormalTableViewCell: UITableViewCell {

    var data: (category: String, artist: String, name: String, squareImage: String, releaseDate: String, price: String)? {
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var smallImage: UIImageView!
    @IBOutlet weak var developerName: UILabel!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var releaseDAte: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateUI(){
        // reset any existing information
        smallImage?.image = nil
        developerName?.text = nil
        appTitle?.text = nil
        releaseDAte?.text = nil
        price?.text = nil
        
        // set image view
        let imageUrl:NSURL? = NSURL(string: (data?.squareImage)!)
        if let url = imageUrl{
            smallImage.sd_setImageWithURL(url)
            smallImage.frame = CGRect(x:0, y: 0, width:50, height:50)
        }
        
        // set developer name
        developerName?.text = data?.artist
        
        // set app title
        appTitle?.text = data?.name
        
        // set release date
        releaseDAte?.text = data?.releaseDate
        
        // set price
        price?.text = "$" + (data?.price)!
    }
    

}

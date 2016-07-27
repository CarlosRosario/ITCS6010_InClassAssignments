//
//  CategoriesTableViewController.swift
//  InClass06
//
//  Created by Carlos Rosario on 7/21/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON

class CategoriesTableViewController: UITableViewController {

    var categories = [String]()
    var totalRows = 0
    
    var json: JSON?{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = SummerAPI.summerAPIEndPoint
        
        Alamofire.request(.GET, urlString).responseJSON { response in
            let jsonData = JSON(data: response.data!) // json contains the entire json data
            self.totalRows = 20
            
            if let feed = jsonData["feed"].array { // feed is the top level array inside of the json with 20 elements
                for item in feed{ // each item is a dictionary with 8 key/value pairs
                    let category : String = item["category"]["attributes"]["term"].string!
                    //print(item["category"]["attributes"]["term"])
                    
                    // If category is not already in the categories array, lets add it.
                    if(!self.categories.contains(category)){
                        self.categories.append(category)
                    }
                }
                // Make sure the categories are alphabetically sorted
                self.categories.sortInPlace()
                self.json = jsonData
                //print(self.categories)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.rowHeight = 80
        tableView.estimatedRowHeight = self.tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return categories.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        if let feed = json!["feed"].array{
//            return feed.count
//        } else {
//            return 20 // ugly thing to do i guess
//        }
        return totalRows
    }
    
//    // I don't think i'm using this method correctly
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let feed = json!["feed"].array{
            return feed[section]["category"]["attributes"]["term"].string!
        }
        else {
            return "section title"
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let feed = json!["feed"].array
        
        let otherImage = feed![indexPath.row]["otherImage"]
        let summary = feed![indexPath.row]["summary"]
        
        if(otherImage != nil || !otherImage.isEmpty){
            
            let cell = tableView.dequeueReusableCellWithIdentifier("largeImageCell", forIndexPath: indexPath)
            
            if let largeImageCell = cell as? LargeImageTableViewCell{
                let row = indexPath.row
                //print(row)
                var cellData = (category: "", artist: "", name: "", squareImage: "", releaseDate: "", price: "", otherImage: "")
                cellData.category = feed![row]["category"]["attributes"]["term"].string!
                cellData.artist = feed![row]["artist"]["label"].string!
                cellData.name = feed![row]["name"]["label"].string!
                cellData.squareImage = feed![row]["squareImage"][0]["label"].string!
                cellData.releaseDate = feed![row]["releaseDate"]["label"].string!
                //cellData.price = feed![row]["price"]["amount"].string!
                cellData.otherImage = feed![row]["otherImage"][0]["label"].string!
                largeImageCell.data = cellData
            }
            return cell

        } else if(summary != nil || !summary.isEmpty){
            
            let cell = tableView.dequeueReusableCellWithIdentifier("summaryCell", forIndexPath: indexPath)
            
            if let summaryCell = cell as? SummaryTableViewCell{
                let row = indexPath.row
                //print(row)
                var cellData = (category: "", artist: "", name: "", squareImage: "", releaseDate: "", price: "", summary: "")
                cellData.category = feed![row]["category"]["attributes"]["term"].string!
                cellData.artist = feed![row]["artist"]["label"].string!
                cellData.name = feed![row]["name"]["label"].string!
                cellData.squareImage = feed![row]["squareImage"][0]["label"].string!
                cellData.releaseDate = feed![row]["releaseDate"]["label"].string!
                //cellData.price = feed![row]["price"]["amount"].string!
                cellData.summary = feed![row]["summary"]["label"].string!
                summaryCell.data = cellData
            }
            return cell

            }
        else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("normalCell", forIndexPath: indexPath)
            
            if let normalCell = cell as? NormalTableViewCell{
                let row = indexPath.row
                //print(row)
                var cellData = (category: "", artist: "", name: "", squareImage: "", releaseDate: "", price: "")
                cellData.category = feed![row]["category"]["attributes"]["term"].string!
                cellData.artist = feed![row]["artist"]["label"].string!
                cellData.name = feed![row]["name"]["label"].string!
                cellData.squareImage = feed![row]["squareImage"][0]["label"].string!
                cellData.releaseDate = feed![row]["releaseDate"]["label"].string!
                //cellData.price = feed![row]["price"]["amount"].string!
                normalCell.data = cellData
            }
            return cell
//            print("normalMode")
        }
    }
}

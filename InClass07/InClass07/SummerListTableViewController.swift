//
//  SummerListTableViewController.swift
//  InClass07
//
//  Created by Carlos Rosario on 7/26/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class SummerListTableViewController: UITableViewController , NSXMLParserDelegate{

    var xmlParser: NSXMLParser!
    var keysArray = [String]()
    var summerDictionary = Dictionary<String, Array<SummerList>>()
    var summerlist = [SummerList]()
    
    func refreshSummerList(){
        let urlString = NSURL(string: SummerAPI.summerAPIEndPoint)
        let request: NSURLRequest = NSURLRequest(URL: urlString!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error == nil && data != nil {
                self.xmlParser = NSXMLParser(data: data!)
                self.xmlParser.delegate = self
                self.xmlParser.parse()
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshSummerList()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if keysArray.isEmpty {
            return 0
        }
        else {
            return keysArray.count
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if keysArray.isEmpty {
            return ""
        }
        else {
            return keysArray[section]
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if keysArray.isEmpty {
            return 0
        }
        else {
                return summerDictionary[keysArray[section]]!.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        print(section)
        print(row)
        let summerListItem = summerDictionary[keysArray[section]]![row]
        let otherImage = summerListItem.otherImage
        let summary = summerListItem.summary
        
        if(!otherImage.isEmpty){
            print("LargeImageCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("largeImageCell", forIndexPath: indexPath)
            
            if let largeImageCell = cell as? LargeImageTableViewCell{
                var cellData = (category: "", artist: "", name: "", squareImage: "", releaseDate: "", price: "", otherImage: "")
                cellData.category = summerListItem.category
                cellData.artist = summerListItem.artist
                cellData.name = summerListItem.name
                cellData.squareImage = summerListItem.squareImage
                cellData.releaseDate = summerListItem.releaseDate
                cellData.price = summerListItem.price
                cellData.otherImage = otherImage
                largeImageCell.data = cellData
            }
            return cell
            
        } else if(!summary.isEmpty){
            print("SummaryCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("summaryCell", forIndexPath: indexPath)
            
            if let summaryCell = cell as? SummaryTableViewCell{
                var cellData = (category: "", artist: "", name: "", squareImage: "", releaseDate: "", price: "", summary: "")
                cellData.category = summerListItem.category
                cellData.artist = summerListItem.artist
                cellData.name = summerListItem.name
                cellData.squareImage = summerListItem.squareImage
                cellData.releaseDate = summerListItem.releaseDate
                cellData.price = summerListItem.price
                cellData.summary = summerListItem.summary
                summaryCell.data = cellData
            }
            return cell
            
        }
        else {
            print("NormalCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("normalCell", forIndexPath: indexPath)
            
            if let normalCell = cell as? NormalTableViewCell{
                var cellData = (category: "", artist: "", name: "", squareImage: "", releaseDate: "", price: "")
                cellData.category = summerListItem.category
                cellData.artist = summerListItem.artist
                cellData.name = summerListItem.name
                cellData.squareImage = summerListItem.squareImage
                cellData.releaseDate = summerListItem.releaseDate
                cellData.price = summerListItem.price
                normalCell.data = cellData
            }
            return cell
    }
}
    
    var entryCategory: String!
    var entryArtist: String!
    var entryName: String!
    var entrySquareImage: String!
    var entryReleaseDate: String!
    var entryPrice: String!
    var entryOtherImage: String!
    var entrySummary: String!
    var currentParsedElement = String()
    var weAreInAFeedItem = false
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == "feed" {
            weAreInAFeedItem = true
            entryCategory = attributeDict["category"]! as String
            entryPrice = attributeDict["price"]! as String
            currentParsedElement = "feed"
        }
        
        if weAreInAFeedItem {
            switch elementName {
                
                case "artist":
                    entryArtist = String()
                    currentParsedElement = "artist"
                
                
               case "name":
                    entryName = String()
                    currentParsedElement = "name"
                
               case "squareImage":
                if let thumbnailImage = attributeDict["url"] as String?{
                    entrySquareImage = thumbnailImage
                }
                
                    currentParsedElement = "squareImage"
                
            case "otherImage":
                if let thumbnailImage = attributeDict["url"] as String?{
                    entryOtherImage = thumbnailImage
                }
                currentParsedElement = "otherImage"
                
                case "summary":
                    currentParsedElement = "summary"
                
                case "releaseDate":
                    entryReleaseDate = String()
                    currentParsedElement = "releaseDate"
                
                
            default: break
                
            }
        }
    }
    
    func parser(parser: NSXMLParser, foundCDATA CDATABlock: NSData) {
        //print(CDATABlock)
        let cdataNSString = NSString(data: CDATABlock, encoding: NSUTF8StringEncoding)
        entrySummary = cdataNSString as! String
        //print(entrySummary)
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if weAreInAFeedItem {
            switch currentParsedElement{
                case "artist":
                    entryArtist = entryArtist + string
                
                case "name":
                    entryName = entryName + string
                
                case "releaseDate":
                    entryReleaseDate = entryReleaseDate + string
                
            default: break
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if weAreInAFeedItem {
            currentParsedElement = ""
        }
        
        if elementName == "feed" {
            let summerItem = SummerList()
            summerItem.category = entryCategory
            summerItem.artist = entryArtist
            summerItem.name = entryName
            summerItem.releaseDate = entryReleaseDate
            summerItem.price = entryPrice
            summerItem.squareImage = entrySquareImage
            
            if entryOtherImage != nil && !entryOtherImage.isEmpty {
                    summerItem.otherImage = entryOtherImage
            }
            
            if entrySummary != nil && !entrySummary.isEmpty {
                let r = entrySummary.startIndex.advancedBy(0)..<entrySummary.endIndex.advancedBy(-200)
                summerItem.summary = entrySummary
                summerItem.summary.removeRange(r)
            }
            summerlist.append(summerItem)
            
            // Clear out data for next iteration
            entryCategory = ""
            entryArtist = ""
            entryName = ""
            entryReleaseDate = ""
            entryPrice = ""
            entrySquareImage = ""
            entryOtherImage = ""
            entrySummary = ""
            weAreInAFeedItem = false
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            for item in self.summerlist {
                if(!self.keysArray.contains(item.category)){
                    self.summerDictionary[item.category] = []
                    self.keysArray.append(item.category)
                }
                self.summerDictionary[item.category]?.append(item)
            }
            self.tableView.reloadData()
        }
    }
}

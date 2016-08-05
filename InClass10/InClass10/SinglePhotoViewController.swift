//
//  SinglePhotoViewController.swift
//  InClass10
//
//  Created by Carlos Rosario on 8/4/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class SinglePhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    weak var refreshPhotosDelegateObject: refreshPhotosDelegate?
    
    let rootRef = FIRDatabase.database().reference()
    
    
    var imageURL = ""
    var row = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageView?.image = nil
        
        let imageURL:NSURL? = NSURL(string: self.imageURL)
        if let url = imageURL{
            imageView.sd_setImageWithURL(url)
        }
    }
    
    func deletion(alert: UIAlertAction!){
        
        
        let currentUser = AppDelegate.user
        rootRef.child("Users").child((currentUser?.firebaseGeneratedId)!).child("imageURLs").child(String(row)).removeValue()
            self.refreshPhotosDelegateObject?.refresh(row)
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func deletePhoto(sender: UIBarButtonItem) {
        
        let refreshAlert = UIAlertController(title: "Photo Delete", message: "Do you want to delete this photo?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: deletion))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func goBack(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}

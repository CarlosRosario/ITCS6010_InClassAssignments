//
//  ViewController.swift
//  InClass04b
//
//  Created by Carlos Rosario on 7/14/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private struct baseImageWebService {
        static let baseURL = "http://dev.theappsdr.com/lectures/inclass_http/index.php?pid="
    }
    
    var currentPhoto = 0
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Load the initial image
        imageURL = convertStringToNSURL(baseImageWebService.baseURL + String(currentPhoto))
        
    }
    
    //Image computed property
    private var image: UIImage?{
        get {
            return imageview.image
        }
        set {
            imageview.image = newValue
            if((spinner?.isAnimating()) != nil){
                spinner?.stopAnimating()
                enableButtons()
            }
        }
    }
    
    
    var imageURL: NSURL?{
        didSet {
            image = nil
            
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    private func fetchImage(){
        if let url = imageURL{
            disableButtons()
            spinner?.startAnimating()
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
                let contentsOfURL = NSData(contentsOfURL: url)
                
                dispatch_async(dispatch_get_main_queue()){ [weak weakSelf = self] in
                    if let imageData = contentsOfURL{
                        weakSelf?.image = UIImage(data: imageData)
                    }
                    else {
                        weakSelf?.spinner?.stopAnimating()
                        weakSelf?.enableButtons()
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if image == nil {
            fetchImage()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func convertStringToNSURL(url: String) -> NSURL? {
        return NSURL(string: url)
    }
    
    private func disableButtons(){
        leftButton.enabled = false
        rightButton.enabled = false
        leftButton.alpha = 0.5
        rightButton.alpha = 0.5
    }
    
    private func enableButtons(){
        leftButton.enabled = true
        rightButton.enabled = true
        leftButton.alpha = 1
        rightButton.alpha = 1
    }
    
    
    @IBAction func previousPhoto(sender: UIButton) {
        
        if(currentPhoto == 0){
            currentPhoto = 19
        }
        else {
            currentPhoto = currentPhoto - 1
        }
        
        imageURL = convertStringToNSURL(baseImageWebService.baseURL + String(currentPhoto))
    }
    
    
    @IBAction func nextPhoto(sender: UIButton) {
        
        if(currentPhoto == 19){
            currentPhoto = 0
        }
        else {
            currentPhoto = currentPhoto + 1
        }
        
        imageURL = convertStringToNSURL(baseImageWebService.baseURL + String(currentPhoto))
    }
    
    
}


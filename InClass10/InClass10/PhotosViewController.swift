//
//  PhotosViewController.swift
//  InClass10
//
//  Created by Carlos Rosario on 8/4/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import Firebase

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, refreshPhotosDelegate {

    let rootRef = FIRDatabase.database().reference()
    
    @IBOutlet weak var collectionView: UICollectionView!
    var chosenImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
//        var tempUser = AppDelegate.user
//        print(AppDelegate.user?.userName)
//        var x = 1
        self.collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let currentUser = AppDelegate.user {
            if let images = currentUser.images {
                return images.count
            }
            else {
                return 0
            }
        }
        else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        if let currentUser = AppDelegate.user {
            if let images = currentUser.images {
                var cellData = (image: "", other: "")
                cellData.image = images[indexPath.row]
                cell.data = cellData
            }
        }
        return cell
    }
    
    var selectedRow = -1
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row
        self.performSegueWithIdentifier("showPhotoViewSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPhotoViewSegue" {
            let vc = segue.destinationViewController.contentViewController as! SinglePhotoViewController
            vc.imageURL = (AppDelegate.user?.images![selectedRow])!
            vc.row = selectedRow
            vc.refreshPhotosDelegateObject = self
        }
    }
    
    func handleSelectProfileImageView(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true // allows you to crop image before saving
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            chosenImage = selectedImage
        }
        
        updateFirebase()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addNewPhoto(sender: UIBarButtonItem) {
        handleSelectProfileImageView()
    }
    
    @IBAction func logoutTouched(sender: UIBarButtonItem) {
        try! FIRAuth.auth()!.signOut()
        AppDelegate.user = nil
        self.dismissViewControllerAnimated(true) {}
    }
    
    private func updateFirebase(){
        // Push image to firebase storage
        let uuid = NSUUID().UUIDString
        let storageRef = FIRStorage.storage().reference().child("profile_images").child(uuid)
        
        if let uploadData = UIImagePNGRepresentation(self.chosenImage!){
            // Push image to firebase storage
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                if let imageURL = metadata?.downloadURL()?.absoluteString {
                    // Push image to firebase database
                    let currentUser = AppDelegate.user
                    let userChild = AppDelegate.user?.firebaseGeneratedId
                    let userImageReference = self.rootRef.child("Users").child(userChild!)
                    AppDelegate.user?.images?.append(imageURL)
                    let values = ["imageURLs" : (AppDelegate.user?.images)!] as [NSObject : AnyObject]
                    userImageReference.updateChildValues(values){
                        (error, reference) in
                        
                        if(error != nil){
                            print(error)
                            return
                        } else {
                            self.collectionView.reloadData()
                        }
                    }
                }
                
                print(metadata)
            }
        }
    }
    
    func refresh(row: Int){
        let currentUser = AppDelegate.user
        currentUser?.images?.removeAtIndex(row)
        self.collectionView.reloadData()
    }
    
    

}

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        }
        else {
            return self
        }
    }
}

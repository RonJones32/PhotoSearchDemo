//
//  PhotoAPIViewController.swift
//  CNNAssessment
//
//  Created by Ronald Jones on 11/25/19.
//  Copyright © 2019 Ron Jones Jr. All rights reserved.
//

import UIKit
import UnsplashPhotoPicker

class PhotoAPIViewController: UIViewController, UnsplashPhotoPickerDelegate, UINavigationControllerDelegate {
    
    //declare variables
    var unsplashPhotoPicker: UnsplashPhotoPicker?
    var config: UnsplashPhotoPickerConfiguration?
    var i = 0
    var j = 0
    var imagesToShare: [Any]?
    var imagesStringArray = [String]()
    
    //create a convenience initializer to handle set up
    convenience init (accessK: String,
    secretK: String,
    givenQuery: String,
    allowsMS: Bool,
    memoryCap: Int,
    diskCap: Int) {
        
        self.init()
        
        self.config = UnsplashPhotoPickerConfiguration(accessKey: accessK,
        secretKey: secretK,
        query: givenQuery,
        allowsMultipleSelection: allowsMS,
        memoryCapacity: memoryCap,
        diskCapacity: diskCap)
        
    }
    
    //present the api once variables are initialized
    override func viewDidAppear(_ animated: Bool) {
         presentApi()
    }
    
    //function to present the api
    func presentApi() {
        self.unsplashPhotoPicker = UnsplashPhotoPicker(configuration: self.config!)
        self.unsplashPhotoPicker?.photoPickerDelegate = self
        
        self.present(unsplashPhotoPicker!, animated: true, completion: nil)
    }
    
    //send images upon selection
    func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
                
        for photo in photos {
            let link = photo.urls.first?.value
            
            imagesStringArray.append(link!.description)
            
            print (link!.description)
        i += 1
        }
        
        photoPicker.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true) {
            let searchView = SearchPhotosViewController()
            searchView.sendImages(data: self.imagesStringArray)
        }
    }
    
    //function to send images using activity view controller
    func sendImages(data: [String]) {
        let searchView = SearchPhotosViewController()
        let objectsToShare = [data]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        //
                    //New Excluded Activities Code
                    activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
                
                activityVC.popoverPresentationController?.sourceView = searchView.view
                present(activityVC, animated: true, completion: nil)
    }
    
    //handle cancel action
    func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {
        photoPicker.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

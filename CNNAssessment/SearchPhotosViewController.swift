//
//  SearchPhotosViewController.swift
//  CNNAssessment
//
//  Created by Ronald Jones on 11/25/19.
//  Copyright © 2019 Ron Jones Jr. All rights reserved.
//

import UIKit
import UnsplashPhotoPicker

class SearchPhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UINavigationControllerDelegate {
    
    //set outlets
    @IBOutlet weak var searchOut: UISearchBar!
    @IBOutlet weak var tbleView: UITableView!
    //declare variables
    var suggestedSearches = [String]()
    var pastSearches = [String]()
    //create an arraay of suggestions
    var suggestOption = ["Animals", "Motivation", "Beaches", "News", "Fall", "Winter", "Summer", "Spring", "Art", "Travel", "Sports", "Models", "Design", "Movies", "Earth"]
    //create a refresh control to handle refreshing options
    let refreshControls = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register table view and set delegate/datasource.
        tbleView.dataSource = self
        tbleView.delegate = self
        tbleView.register(UINib(nibName: "SearchesTableViewCell", bundle: nil), forCellReuseIdentifier: "Search")
        
        //implement refresh
        refreshControls.addTarget(self, action: #selector(refr), for: .valueChanged)
        tbleView.refreshControl = refreshControls
        
        //configure seearch bar
        searchOut.placeholder = "Search Photos"
        searchOut.delegate = self
        searchOut.enablesReturnKeyAutomatically = true
        
        //adjust view to handle smooth transition
        definesPresentationContext = true
        
        //shuffle the search options
        suggestOption = suggestOption.shuffled()
    }
    
    //search function
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //configure api view
        let unsplashView = PhotoAPIViewController(accessK: "a91b212c416c22d4c3a542472461ce703ee7cb6f1a6161416437e7e5e9d200ca", secretK: "98764558797bf095b9d8908204a8f4dce84abc095562d2193e9b33213c8ecb6f", givenQuery: searchBar.text ?? suggestOption[0], allowsMS: true, memoryCap: 50, diskCap: 100)
        
        //create user defaults to store searches in past array
        let userDefault = UserDefaults.standard
        var pastArray = userDefault.value(forKey: "recentSearches") as? [String]
        
        //check if past array is nil and display data accordingly
        if pastArray != nil {
            pastArray!.append(searchBar.text ?? suggestOption[0])
            userDefault.set(pastArray, forKey: "recentSearches")
        }
        else {
            let pastSearch = searchBar.text
            userDefault.set([pastSearch ?? suggestOption[0]], forKey: "recentSearches")
        }
        
        //present api
        self.present(unsplashView, animated: true, completion: nil)
    }
    
    @objc func refr() {
        //handle refresh
        self.suggestOption = suggestOption.shuffled()
        self.tbleView.reloadData()
        self.refreshControls.endRefreshing()
    }
    
    
    //configure table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Suggested Searches"
        }
        else if section == 1 {
            return "Recent Searches"
        }
        else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create table view cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "Search", for: indexPath) as! SearchesTableViewCell
        
        let userDefault = UserDefaults.standard
        let pastArray = userDefault.value(forKey: "recentSearches") as? [String]
        if pastArray != nil {
            self.pastSearches = pastArray!
            self.pastSearches = self.pastSearches.reversed()
        }
        
        if indexPath.row == 0 && indexPath.section == 0 {
            cell.searchText.text = suggestOption[indexPath.row]
        }
        else if indexPath.row == 1 && indexPath.section == 0 {
            cell.searchText.text = suggestOption[indexPath.row]
        }
        else if indexPath.row == 2 && indexPath.section == 0 {
            cell.searchText.text = suggestOption[indexPath.row]
        }
        else if indexPath.row == 3 && indexPath.section == 0 {
            cell.searchText.text = suggestOption[indexPath.row]
        }
        else if indexPath.row == 4 && indexPath.section == 0 {
            cell.searchText.text = suggestOption[indexPath.row]
        }
        else if indexPath.row == 0 && indexPath.section == 1 {
            if pastSearches.count > indexPath.row {
            cell.searchText.text = pastSearches[indexPath.row]
            }
            else {
                cell.goArrow.image = nil
                cell.searchText.text = nil
            }
        }
        else if indexPath.row == 1 && indexPath.section == 1 {
            if pastSearches.count > indexPath.row {
            cell.searchText.text = pastSearches[indexPath.row]
            }
            else {
                cell.goArrow.image = nil
                cell.searchText.text = nil
            }        }
        else if indexPath.row == 2 && indexPath.section == 1 {
            if pastSearches.count > indexPath.row {
            cell.searchText.text = pastSearches[indexPath.row]
            }
            else {
                cell.goArrow.image = nil
                cell.searchText.text = nil
            }        }
        else if indexPath.row == 3 && indexPath.section == 1 {
            if pastSearches.count > indexPath.row {
            cell.searchText.text = pastSearches[indexPath.row]
            }
            else {
                cell.goArrow.image = nil
                cell.searchText.text = nil
            }
        }
        else if indexPath.row == 4 && indexPath.section == 1 {
            if pastSearches.count >= indexPath.row {
            cell.searchText.text = pastSearches[indexPath.row]
            }
            else {
                cell.goArrow.image = nil
                cell.searchText.text = nil
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //create cell action for selection
        let cell = tableView.cellForRow(at: indexPath) as! SearchesTableViewCell
        let unsplashView = PhotoAPIViewController(accessK: "a91b212c416c22d4c3a542472461ce703ee7cb6f1a6161416437e7e5e9d200ca", secretK: "98764558797bf095b9d8908204a8f4dce84abc095562d2193e9b33213c8ecb6f", givenQuery: cell.textLabel!.text ?? suggestOption[indexPath.row], allowsMS: true, memoryCap: 50, diskCap: 100)
        self.present(unsplashView, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //create an activity controller to share images upon click
    func sendImages(data: [String]) {
        let app = UIApplication.shared.delegate as? AppDelegate
        let window = app!.window
        let objectsToShare = [data]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
                    //New Excluded Activities Code
                    activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
                
        activityVC.popoverPresentationController?.sourceView = window?.topViewController()!.view

        window?.topViewController()?.present(activityVC, animated: true, completion: nil)
        //present(activityVC, animated: true, completion: nil)
    }
    
    
    

}

//create an extension to find top view controller in stack to create easier presentations
extension UIWindow {
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}

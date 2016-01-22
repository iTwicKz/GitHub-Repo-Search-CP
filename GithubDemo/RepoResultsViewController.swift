//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    @IBOutlet weak var tableView: UITableView!
    
    var repoDict: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
//
//        // initialize UISearchBar
//        searchBar = UISearchBar()
//        searchBar.delegate = self
//
//        // add search bar to navigation bar
//        searchBar.sizeToFit()
//        navigationItem.titleView = searchBar
//
//        doSearch()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 20
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("githubCell", forIndexPath: indexPath) as! githubCell
        
        return cell
    }

    private func doSearch() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        GithubRepo.fetchRepos(searchSettings, successCallback: { (repos) -> Void in
            for repo in repos {
                print(repo)
                repoDict += (repo)
            }
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }, error: { (error) -> Void in
            print(error)
        })
    }
}

extension RepoResultsViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
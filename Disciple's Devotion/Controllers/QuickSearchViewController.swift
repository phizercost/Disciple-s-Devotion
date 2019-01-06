//
//  QuickSearchViewController.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/20/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import UIKit

class QuickSearchViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate, UITableViewDelegate {

    
    @IBOutlet weak var tableViewResults: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var txtSearchBar: UITextField!
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.94, alpha:1.0)
        tableViewResults.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.94, alpha:1.0)
        tableViewResults.dataSource = self
        tableViewResults.delegate = self
        txtSearchBar.delegate = self

    }
    
    //MARK:-UITableViewDatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.shared.searchResults.data.total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchVerseCell", for: indexPath) as! SearchTableViewCell
        let verse = Global.shared.searchResults.data.verses[(indexPath as NSIndexPath).row].text
        let reference = Global.shared.searchResults.data.verses[(indexPath as NSIndexPath).row].reference
        cell.textLabel?.text = verse
        cell.detailTextLabel?.text = reference
        cell.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.94, alpha:1.0)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VerseDetailViewController") as! VerseDetailViewController
        let verse = Global.shared.searchResults.data.verses[(indexPath as NSIndexPath).row].text
        let reference = Global.shared.searchResults.data.verses[(indexPath as NSIndexPath).row].reference

        Global.shared.verseSearched  = verse
        Global.shared.referenceSearched = reference
        self.navigationController!.pushViewController(detailController, animated: true)
     }
    //MARK:= UITextFieldDelegates
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        txtSearchBar.resignFirstResponder()
        txtSearchBar.text = ""
        Global.shared.searchResults = SearchParser.init(data: DataElements(query: "", total: 0, verses: []))
        tableViewResults.reloadData()
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (txtSearchBar.text?.count) != 0 {
            txtSearchBar.resignFirstResponder()
            quickSearchInBible(text: textField.text!)
        } else {
             self.raiseAlert(title: "ERROR", notification: "Please enter the keyword to search for")
        }
        return true
    }
    
    private func quickSearchInBible(text: String) {
        activityIndicator.startAnimating()
        Global.shared.quickSearch(text: text, completionHandler: {(searchResults, error) in
            if (searchResults != nil) {
                Global.shared.searchResults = searchResults!
                self.tableViewResults.reloadData()
                self.activityIndicator.stopAnimating()
                
            } else {
                DispatchQueue.main.async {
                    self.raiseAlert(title: "ERROR", notification: error!)
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }

}

//
//  BibleStudyCollectionViewController.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/24/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class BibleStudyCollectionViewController: UICollectionViewController {

    @IBOutlet weak var collectionViewActivityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.94, alpha:1.0)
        collectionViewActivityIndicator.startAnimating()
        fetchBibleStudies ()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Global.shared.bibleStudies?.items.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BSCollectionViewCell", for: indexPath) as! BibleStudiesCollectionViewCell
        cell.imageView.image = nil
        cell.sectionsLbl.text = ""
        cell.activityIndicator.startAnimating()
        cell.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.94, alpha:1.0)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let bibleStudy = Global.shared.bibleStudies!.items[(indexPath as NSIndexPath).row]
        let bibleStudyViewCell = cell as! BibleStudiesCollectionViewCell
        bibleStudyViewCell.thumbUrl = bibleStudy.thumb
        
        configBibleStudyImage(using: bibleStudyViewCell, bibleStudy: bibleStudy, collectionView: collectionView, index: indexPath)
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "LessonCollectionViewController") as! LessonCollectionViewController
        detailController.item = Global.shared.bibleStudies!.items[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    // MARK: - Helpers
    
    private func configBibleStudyImage(using cell: BibleStudiesCollectionViewCell, bibleStudy: ItemElements, collectionView: UICollectionView, index: IndexPath) {
            Global.shared.imageDownload(imageUrl: cell.thumbUrl) { (data, error) in
                if let _ = error {
                    return
                } else if let data = data {
                    DispatchQueue.main.async {
                        
                        if let currentCell = collectionView.cellForItem(at: index) as? BibleStudiesCollectionViewCell {
                            currentCell.imageView.image = UIImage(data: data)
                            currentCell.sectionsLbl.text = "Number of lessons:" + bibleStudy.num_lessons
                            currentCell.activityIndicator.stopAnimating()
                        }
                        
                    }
                }
            }
        
        
    }

    
    private func fetchBibleStudies () {
        Global.shared.downloadBibleStudies(completionHandler: {(searchResults, error) in
            if (searchResults != nil) {
                Global.shared.bibleStudies = searchResults!
                self.collectionViewActivityIndicator.stopAnimating()
                self.collectionView.reloadData()
            } else {
                DispatchQueue.main.async {
                    self.collectionViewActivityIndicator.stopAnimating()
                    self.raiseAlert(title: "ERROR", notification: error!)
                }
            }
        })
    }

}

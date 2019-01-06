//
//  LessonCollectionViewController.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/27/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class LessonCollectionViewController: UICollectionViewController {

    @IBOutlet weak var lessonActivityIndicator: UIActivityIndicatorView!
    var item: ItemElements!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.94, alpha:1.0)
        lessonActivityIndicator.startAnimating()
        fetchLessons()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Global.shared.lessons?.items.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LCollectionViewCell", for: indexPath) as! LessonCollectionViewCell
        
        cell.imageView.image = nil
        cell.titleLbl.text = ""
        cell.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.94, alpha:1.0)
        cell.activityIndicator.startAnimating()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lesson = Global.shared.lessons!.items[(indexPath as NSIndexPath).row]
        let lessonViewCell = cell as! LessonCollectionViewCell
        lessonViewCell.url = lesson.image_mq
        
        configLessonImage(using: lessonViewCell, lesson: lesson, collectionView: collectionView, index: indexPath)
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let url = URL(string: Global.shared.lessons!.items[(indexPath as NSIndexPath).row].url) {
            UIApplication.shared.open(url, options: [:])
        }else {
            self.raiseAlert(title: "ERROR", notification: "The link to the lesson is broken. Try again later")
        }
        
    }
    
    private func fetchLessons () {
        Global.shared.downloadLessons(serie: self.item, completionHandler: {(searchResults, error) in
            if (searchResults != nil) {
                Global.shared.lessons = searchResults!
                self.lessonActivityIndicator.stopAnimating()
                self.collectionView.reloadData()
            } else {
                DispatchQueue.main.async {
                    self.lessonActivityIndicator.stopAnimating()
                    self.raiseAlert(title: "ERROR", notification: error!)
                }
            }
        })
    }
    
    private func configLessonImage(using cell: LessonCollectionViewCell, lesson: Items, collectionView: UICollectionView, index: IndexPath) {
        Global.shared.imageDownload(imageUrl: cell.url) { (data, error) in
            if let _ = error {
                return
            } else if let data = data {
                DispatchQueue.main.async {
                    
                    if let currentCell = collectionView.cellForItem(at: index) as? LessonCollectionViewCell {
                        currentCell.imageView.image = UIImage(data: data)
                        currentCell.titleLbl.text = lesson.title
                        currentCell.activityIndicator.stopAnimating()
                    }
                    
                }
            }
        }
        
        
    }
}

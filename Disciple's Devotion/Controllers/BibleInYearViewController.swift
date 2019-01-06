//
//  BibleInYearViewController.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 1/2/19.
//  Copyright © 2019 Phizer Cost. All rights reserved.
//

import UIKit
import CoreData

class BibleInYearViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
   
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var ltbList: UITableView!
    var currentDay: Float = 0.0
    override func viewDidLoad() {

        super.viewDidLoad()
        resetButton.addTarget(self, action: #selector(resetProgress(sender:)), for: .touchUpInside)
        self.view.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.94, alpha:1.0)
        let persistedBiblePlan = PersistenceService.loadYearPlan()
        if (persistedBiblePlan?.count)! > 0 {
            Global.shared.biblePlan = persistedBiblePlan!
            if nextToUnCheck() == 0 {
                currentDay = 0.0
            } else {
                currentDay = Float(nextToUnCheck() - 1)
            }
            updateProgress()
        }
        else if let filepath = Bundle.main.path(forResource: "plan", ofType: "json") {
            do {
                let plans = try String(contentsOfFile: filepath)
                let jsonDecoder = JSONDecoder()
                let jsonData = Data(plans.utf8)
                let parsedBiblePlan = try jsonDecoder.decode(BiblePlanParser.self, from: jsonData)
                
                for index in 0 ..< parsedBiblePlan.plan.count {
                    let biblePlan = BiblePlan(context: PersistenceService.context)
                    biblePlan.day = parsedBiblePlan.plan[index].day
                    biblePlan.references = getReferences(reference: parsedBiblePlan.plan[index].references)
                    biblePlan.status = false
                    
                    Global.shared.biblePlan.append(biblePlan)
                }
                PersistenceService.saveContext()
            } catch let _ as NSError {
                raiseAlert(title: "ERROR", notification: "Unable to get the plan")
            }
        } else {
            raiseAlert(title: "ERROR", notification: "Unable to get the plan")
        }
        
        
        ltbList.register(UINib.init(nibName: "BibleInYearCell", bundle: nil), forCellReuseIdentifier: "CheckListIdentifier")
        ltbList.dataSource = self
        ltbList.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.shared.biblePlan.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListIdentifier") as! BibleInYearCell
        cell.lblTitle.text = "Day-" + Global.shared.biblePlan[indexPath.row].day! +  ": " + Global.shared.biblePlan[indexPath.row].references!
           cell.selectionStyle = .none
        cell.chkBtn.indexPath = indexPath
        if (Global.shared.biblePlan[indexPath.row].status) {
            cell.chkBtn.isSelected = true
            cell.backgroundColor = UIColor.lightGray
        } else {
            cell.chkBtn.isSelected = false
            cell.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.94, alpha:1.0)
        }
        cell.chkBtn.addTarget(self, action: #selector(bibleInYearCellClicked(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func bibleInYearCellClicked(sender: CellButton) {
        if sender.isSelected {
            let toUncheck = nextToUnCheck()
            if toUncheck == (sender.indexPath?.row)! + 1 {
                Global.shared.biblePlan[(sender.indexPath?.row)!].status = false
            } else {
                raiseAlert(title: "Error", notification: "You can only uncheck the latest read plan on Day " + String(toUncheck))
            }
        }
        else {
            let toCheck = nextToCheck()
            if toCheck == (sender.indexPath?.row)! {
                Global.shared.biblePlan[(sender.indexPath?.row)!].status = true
            }
            else {
                raiseAlert(title: "Error", notification: "You can only check the next reading plan on Day " + String(toCheck + 1))
            }
            
        }
        PersistenceService.saveContext()
        ltbList.reloadData()
    }
    
    private func getReferences(reference:[String]) -> String {
        var references = "";
        var i = 0
        for ref in reference {
            i = i + 1
            if references.count == i {
             references = references + ref
            } else {
                references = references + ref + ", "
            }
        }
        return references
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DayPlanViewController") as! DayPlanViewController
        detailController.reference = Global.shared.biblePlan[indexPath.row].references
        detailController.title = "Day " + Global.shared.biblePlan[indexPath.row].day! + " Scripture Reading"
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    @objc fileprivate func resetProgress(sender: UIButton) {
        
        
        
        if Global.shared.biblePlan[0].status {
            let refreshAlert = UIAlertController(title: "Reset", message: "All the progress made will be lost.", preferredStyle: UIAlertController.Style.alert)
            
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                for plan in Global.shared.biblePlan {
                    plan.status = false
                }
                PersistenceService.saveContext()
                self.ltbList.reloadData()
                self.currentDay = 0.0
                self.updateProgress()
            }))
            
            
            
            present(refreshAlert, animated: true, completion: nil)
        } else  {
            
            raiseAlert(title: "Reset", notification: "You have not made any progress to reset")
        }
    }
    
    func nextToCheck() -> Int {
        var toCheck = 0
        if !Global.shared.biblePlan[0].status {
            toCheck = 0
        } else {
            for plan in Global.shared.biblePlan {
                let day = plan.day
                if !plan.status {
                    toCheck = Int(day!)! - 1
                    break
                }
            }
        }
        return toCheck
    }
    
    func nextToUnCheck() -> Int {
        var toUnCheck = 0
        if Global.shared.biblePlan[Global.shared.biblePlan.count - 1].status {
            toUnCheck = 365
        } else {
            for plan in Global.shared.biblePlan {
                let day = plan.day
                if !plan.status {
                    toUnCheck = Int(day!)! - 1
                    break
                }
            }
        }
        return toUnCheck
    }
    
    func updateProgress() {
        currentDay = currentDay + 1
        progressView.setProgress(currentDay, animated: true)
        perform(#selector(setProgress), with:nil)
    }
    
    @objc func setProgress() {
        let MAX: Float = 365.0
        progressView.progress = currentDay/MAX
    }
}

//
//  ProfileViewController.swift
//  FeedTabs
//
//  Created by Alvin Chen on 11/30/20.
//

import UIKit

class ProfileViewController: UIViewController {

    //imageView
    @IBOutlet weak var imageView: UIImageView!
    
    //tableView
    @IBOutlet weak var tableView: UITableView!
    
    
    //editBarButton
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    
    
    
    var goals: [GoalListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.frame =  CGRect(x: view.frame.size.width/2, y: 10, width: 150, height: 150)
        
        var centerImageView: CGPoint = imageView.center
        centerImageView.x = self.view.center.x
        imageView.center = centerImageView

        
        
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailTwoViewController
            
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.goalDetailListItem = goals[selectedIndexPath.row]
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue) {
        let source = segue.source as! DetailViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            goals[selectedIndexPath.row] = source.goalListItem
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: goals.count, section: 0)
            goals.append(source.goalListItem)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        
        
    }

    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            editBarButton.title = "Edit"
           
        } else {
            tableView.setEditing(true, animated: true)
            editBarButton.title = "Done"
            
        }
    }
    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.goalLabel?.text = goals[indexPath.row].goal
        cell.subLabelOne?.text = goals[indexPath.row].subgoalOne
        cell.subLabelTwo?.text = goals[indexPath.row].subgoalTwo
        cell.subLabelThree?.text = goals[indexPath.row].subGoalThree
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    
    
}

//@IBOutlet weak var imageView: UIImageView!
//
//@IBOutlet weak var viewNew: UIView!
//
//@IBOutlet weak var tableView: UITableView!
//
//var goals = ["Goal"]
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    imageView.frame =  CGRect(x: view.frame.size.width/2, y: 10, width: 150, height: 150)
//
//    var centerImageView: CGPoint = imageView.center
//    centerImageView.x = self.view.center.x
//    imageView.center = centerImageView
//
//
//
//    imageView.layer.borderWidth = 1
//    imageView.layer.masksToBounds = false
//    imageView.layer.borderColor = UIColor.black.cgColor
//    imageView.layer.cornerRadius = imageView.frame.height/2
//    imageView.clipsToBounds = true
//
//    tableView.delegate = self
//    tableView.dataSource = self
//
//}
//
//
//}
//
//extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
//func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    goals.count
//}
//
//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//    cell.textLabel?.text = goals[indexPath.row]
//    return cell
//}

//
//  DetailViewController.swift
//  FeedTabs
//
//  Created by Alvin Chen on 12/7/20.
//

import UIKit

class DetailViewController: UIViewController {

    //goalTextField
    @IBOutlet weak var goalTextField: UITextField!
    
    
    //subFieldOne
    @IBOutlet weak var subFieldOne: UITextField!
    
    //subFieldTwo
    @IBOutlet weak var subFieldTwo: UITextField!
    
    
    //subFieldThree
    @IBOutlet weak var subFieldThree: UITextField!
    
    
    
    var goalListItem: GoalListItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if goalListItem == nil {
            goalListItem = GoalListItem(goal: "", subgoalOne: "", subgoalTwo: "", subGoalThree: "")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        goalListItem.goal = goalTextField.text ?? ""
        goalListItem.subgoalOne = subFieldOne.text!
        goalListItem.subgoalTwo = subFieldTwo.text!
        goalListItem.subGoalThree = subFieldThree.text!
    }
    

//cancelBarButton
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    


    
}

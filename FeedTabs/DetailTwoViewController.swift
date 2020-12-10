//
//  DetailTwoViewController.swift
//  FeedTabs
//
//  Created by Alvin Chen on 12/10/20.
//

import UIKit
import AVFoundation

class DetailTwoViewController: UIViewController {

    var goalDetailListItem: GoalListItem!
    
    @IBOutlet weak var lockButton: UIButton!
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var subLabel2: UILabel!
    
    @IBOutlet weak var subLabel3: UILabel!
    
    var videoPicker: VideoPicker!
    @IBOutlet weak var videoView: VideoView!
    @IBOutlet weak var videoPickerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if goalDetailListItem == nil {
            goalDetailListItem = GoalListItem(goal: "", subgoalOne: "", subgoalTwo: "", subGoalThree: "")
        }
        
        subLabel.text = goalDetailListItem.subgoalOne
        subLabel2.text = goalDetailListItem.subgoalTwo
        subLabel3.text = goalDetailListItem.subGoalThree
        
        self.videoView.contentMode = .scaleAspectFill
        self.videoView.player?.isMuted = true
        self.videoView.repeat = .loop
        
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func lockButtonPressed(_ sender: UIButton) {
        showAlert(title: "Woops!", message: "You must complete the last goal before moving on to this goal.")
    }
    
    @IBAction func lockButtonTwoPressed(_ sender: UIButton) {
        showAlert(title: "Woops!", message: "You must complete the last goal before moving on to this goal.")
    }
    
    @IBAction func videoPickerButtonTouched(_ sender: UIButton) {
        self.videoPicker = VideoPicker(presentationController: self, delegate: self)
        self.videoPicker.present(from: sender)
        videoPickerButton.alpha = 0
    }
    
   
}

extension DetailTwoViewController: VideoPickerDelegate {

    func didSelect(url: URL?) {
        guard let url = url else {
            return
        }
        self.videoView.url = url
        self.videoView.player?.play()
    }
}

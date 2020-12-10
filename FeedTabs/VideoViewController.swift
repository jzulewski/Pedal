//
//  ViewController.swift
//  Feed
//
//  Created by John Zulewski on 11/14/20.
//

import UIKit
import Lottie
struct VideoModel {
    let caption: String
    let username: String
    let hashtags: String
    let videoFileName: String
    let videoFileFormat: String
}

class VideoViewController: UIViewController {
    
    var video: Video!
    
    var videos: Videos!

    var collectionView: UICollectionView?
    
    @IBOutlet weak var validatedLabel: UILabel!
    @IBOutlet weak var closerToGoalLabel: UILabel!
    
    private var data = [VideoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videos = Videos()
        // not sure if this is needed
//        if video == nil {
//            video = Video()
//        }
          
        
//        let captionsItems = ["Goal: Learn How to Plant Carrots", "Goal: Attempt to Make My Own Compost!", "Goal: Have Fun with Recycling", ]
//        let usernameItems = ["Farmer7k", "GreenThumbJourney", "DontBeTrashy", ]
//        let hashtagItems = ["#conservation #environment", "#conservation #FirstTime", "#recycling #GreenEnergy", ]
//        let fileItems = ["farming", "compost", "recycle"]
//        let formatItems = ["mov", "mov", "mov"]
//
//        for i in 0...2 {
//            let model = VideoModel(caption: captionsItems[i], username: usernameItems[i], hashtags: hashtagItems[i], videoFileName: fileItems[i], videoFileFormat: formatItems[i])
//            data.append(model)
//        }
        
        //Maybe use an IBAction for the UICollection so that the video isn't overlapping the tab bar in the Storyboard
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width-10, height: view.frame.size.height-10)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifer)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videos.loadData {
            // use a ! here?
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }


}

extension VideoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return data.count
        return videos.videoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // let model = data[indexPath.row]
        let model = videos.videoArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifer, for: indexPath) as! VideoCollectionViewCell
        //configure is function in videocollectionviewcell that uses puts the username, hashtags, etc in the labels that are created in videocollectionviewcell
        // it also starts playing the video
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    
}

extension VideoViewController: VideoCollectionViewCellDelegate {
    func didTapLikeButton(with model: Video) {
        print("Like button tapped")
    }
    
    func didTapProfileButton(with model: Video) {
        
        print("Profile button tapped")
        let animation = AnimationView(name: "lf30_editor_hdqu5pit")
        animation.frame = CGRect(x: view.frame.size.width/2 - 170, y: view.frame.size.height/2 - 200, width: 350, height: 250)
        animation.contentMode = .scaleAspectFit
        animation.animationSpeed = 2
        view.addSubview(animation)
        
        closerToGoalLabel.text = "\(model.username) is one step closer to their goal!"
        view.addSubview(closerToGoalLabel)
        view.addSubview(validatedLabel)
        validatedLabel.alpha = 0
        validatedLabel.font = UIFont(name: "Avenir-Light", size: 23)
        closerToGoalLabel.alpha = 0
        closerToGoalLabel.font = UIFont(name: "Avenir-Light", size: 20)
        UIView.animate(withDuration: 1, animations: {
                        self.validatedLabel.alpha = 1
                        self.closerToGoalLabel.alpha = 1
        })
        animation.play(fromFrame: 1, toFrame: 150, loopMode: .none, completion: { (success) in
            animation.pause()
            //animation.alpha = 0
        })
//        animation.play { (successs) in
//            animation.pause()
//            animation.alpha = 0
//        }
        
        
    }
    
    func didTapSbareButton(with model: Video) {
        print("Share button tapped")
    }
    
    func didTapCommentButton(with model: Video) {
        print("Comment button tapped")
    }
    
    
}


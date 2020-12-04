//
//  ViewController.swift
//  Feed
//
//  Created by John Zulewski on 11/14/20.
//

import UIKit

struct VideoModel {
    let caption: String
    let username: String
    let hashtags: String
    let videoFileName: String
    let videoFileFormat: String
}

class VideoViewController: UIViewController {

    private var collectionView: UICollectionView?
    
    private var data = [VideoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captionsItems = ["Goal: Learn How to Plant Carrots", "Goal: Attempt to Make My Own Compost!", "Goal: Have Fun with Recycling", ]
        let usernameItems = ["Farmer7k", "GreenThumbJourney", "DontBeTrashy", ]
        let hashtagItems = ["#conservation #environment", "#conservation #FirstTime", "#recycling #GreenEnergy", ]
        let fileItems = ["farming", "compost", "recycle"]
        let formatItems = ["mov", "mov", "mov"]
        
        for i in 0...2 {
            let model = VideoModel(caption: captionsItems[i], username: usernameItems[i], hashtags: hashtagItems[i], videoFileName: fileItems[i], videoFileFormat: formatItems[i])
            data.append(model)
        }
        
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }


}

extension VideoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifer, for: indexPath) as! VideoCollectionViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    
}

extension VideoViewController: VideoCollectionViewCellDelegate {
    func didTapLikeButton(with model: VideoModel) {
        print("Like button tapped")
    }
    
    func didTapProfileButton(with model: VideoModel) {
        print("Profile button tapped")
    }
    
    func didTapSbareButton(with model: VideoModel) {
        print("Share button tapped")
    }
    
    func didTapCommentButton(with model: VideoModel) {
        print("Comment button tapped")
    }
    
    
}


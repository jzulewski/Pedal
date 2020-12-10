//
//  DiscoverViewController.swift
//  FeedTabs
//
//  Created by Alvin Chen on 11/30/20.
//

import UIKit
import SwiftReorder

class DiscoverViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    
    
    var favorites = ["#FirstTime", "#Environment", "#GreenEnergy", "#Exercise", "#TellMeAStory", "#Cooking", "#TakingAChance", "#HomeImprovement", "#LetsBuild", "#Writing", "#BasketballFundamentals", "#ILearnedTo"]
//    private var collectionView: UICollectionView?
//
//    private var videos = Videos()
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reorder.delegate = self

            
//            let layout = UICollectionViewFlowLayout()
//            layout.scrollDirection = .vertical
//            layout.itemSize = CGSize(width: view.frame.size.width-10, height: view.frame.size.height-10)
//            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//            collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifer)
//            collectionView?.isPagingEnabled = true
//            collectionView?.dataSource = self
//            collectionView?.delegate = self
//
//            guard let collectionView = collectionView else {
//                return
//            }
//            view.addSubview(collectionView)
            
            
            
//            searchBar.placeholder = "Search"
//
//            searchBar.delegate = self
        }
    
    
    


 
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        collectionView?.frame = view.bounds
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        videos.loadData {
//            // use a ! here?
//            self.collectionView?.reloadData()
//        }
//    }
//
    
    
    
//
//    var things = ["hi", "bye"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//    }
//
//
//}
//
//extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return things.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = things[indexPath.row]
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
    
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let spacer = tableView.reorder.spacerCell(for: indexPath) {
                return spacer
            }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = favorites[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
}

extension DiscoverViewController: TableViewReorderDelegate {
    func tableView(_ tableView: UITableView, reorderRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update data model
        let itemToMove = favorites[sourceIndexPath.row]
        favorites.remove(at: sourceIndexPath.row)
        favorites.insert(itemToMove, at: destinationIndexPath.row)
    }
}

//extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 100
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        cell.configure(with: Video(caption: "test", username: "user", hashtags: "#test", videoFileName: "compost", videoFileFormat: "mov", postingUserID: "user", documentID: ""))
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        //let model = models[indexPath.row] or whatever function you use
//        //let vc = PostViewController(model: nil)
//    }
//
//}
//
//extension DiscoverViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//        guard let text = searchBar.text, !text.isEmpty else {
//            return
//        }
//
//        query(text)
//    }
//
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelSearch))
//    }
//
//    @objc private func didCancelSearch() {
//        searchBar.resignFirstResponder()
//    }
//
//    // performs the search
//    private func query(_ text: String) {
//
//    }
//}

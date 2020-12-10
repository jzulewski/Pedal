//
//  Videos.swift
//  FeedTabs
//
//  Created by John Zulewski on 12/9/20.
//

import Foundation
import Firebase

class Videos {
    var videoArray: [Video] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("videos").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("Error: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.videoArray = [] // clean out existing videoArray since new data will load
            for document in querySnapshot!.documents {
                let video = Video(dictionary: document.data())
                video.documentID = document.documentID
                self.videoArray.append(video)
            }
            completed()
        }
    }
    
    
}

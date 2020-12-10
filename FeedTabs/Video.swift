//
//  Video.swift
//  FeedTabs
//
//  Created by John Zulewski on 12/9/20.
//

import Foundation
import Firebase

class Video {
    var caption: String
    var username: String
    var hashtags: String
    var videoFileName: String
    var videoFileFormat: String
    var postingUserID: String
    var documentID: String
    
    // We need to create a dictionary to send data to Cloud Firestore
    var dictionary:  [String: Any]  {
        return ["caption":  caption, "username":  username, "hashtags":  hashtags, "videoFileName":  videoFileName, "videoFileFormat":  videoFileFormat,  "postingUserID":  postingUserID]
    }
    
    //Creating an Instance of Our Video Object
    init(caption: String, username: String, hashtags: String, videoFileName: String, videoFileFormat: String, postingUserID: String, documentID: String) {
        self.caption = caption
        self.username = username
        self.hashtags = hashtags
        self.videoFileName = videoFileName
        self.videoFileFormat = videoFileFormat
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    
    convenience init() {
        self.init(caption: "", username: "", hashtags: "", videoFileName: "", videoFileFormat: "", postingUserID: "", documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let caption = dictionary["caption"] as! String? ?? ""
        let username = dictionary["username"] as! String? ?? ""
        let hashtags = dictionary["hashtags"] as! String? ?? ""
        let videoFileName = dictionary["videoFileName"] as! String? ?? ""
        let videoFileFormat = dictionary["videoFileFormat"] as! String? ?? ""
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        self.init(caption: caption, username: username, hashtags: hashtags, videoFileName: videoFileName, videoFileFormat: videoFileFormat, postingUserID: postingUserID, documentID: "")
    }
    
    func saveData(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        // Grab the user ID
        guard let postingUserID = Auth.auth().currentUser?.uid else {
            print("ERROR: Could not save data because we don't have a valid postingUserID")
            return completion(false)
        }
        self.postingUserID = postingUserID
        // Create the dictionary representing the data we want to save
        let dataToSave: [String: Any] = self.dictionary
        //if we have a saved record, we'll have an ID, otherwise .addDocument will create one
        if self.documentID == "" {
            // Create new document
            var ref: DocumentReference? = nil
            ref = db.collection("videos").addDocument(data:  dataToSave) { (error) in
                guard error == nil else {
                    print("ERROR: adding document \(error!.localizedDescription)")
                    return completion(false)
                }
                // sets the document ID to the document that was just made in the collection
                self.documentID = ref!.documentID
                print("Added document: \(self.documentID)!")
                completion(true)
            }
            
        } else { // else update the existing documentID with setData
            let ref = db.collection("videos").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                guard error == nil else {
                    print("ERROR: updating document \(error!.localizedDescription)")
                    return completion(false)
                }
                print("Updated document: \(self.documentID)!")
                completion(true)
            }
        }
        
    }
}

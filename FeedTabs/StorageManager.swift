//
//  StorageManager.swift
//  FeedTabs
//
//  Created by John Zulewski on 12/9/20.
//

import Foundation
import FirebaseStorage
import AVFoundation

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
}

public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let postType: UserPostType
}

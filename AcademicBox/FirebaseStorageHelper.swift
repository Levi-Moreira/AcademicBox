//
//  FirebaseStorageHelper.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 28/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import Foundation
import FirebaseStorage

class FirebaseStorageHelper {

    private let user: AppUser
    private let kFirebaseStorageBucketUrl = "gs://academicbox-844fd.appspot.com/images"
    
    var rootReference: StorageReference {
        return Storage.storage().reference(forURL: kFirebaseStorageBucketUrl)
    }
    
    init(user: AppUser) {
        self.user = user
    }
    
    func createImageReference(withPath path: String) -> StorageReference {
        return self.rootReference.child("\(path)")
    }
    
    func userBucketReference() -> StorageReference {
        return self.rootReference.child("\(self.user.id)")
    }
    
    func upload(file: Data, completionHandler: @escaping (_ error: NSError?) -> Void) {
        
        let uploadTask = self.userBucketReference()
            .child("some-random-string.png")
            .putData(file, metadata: nil) { metadata, error in
            
            guard let metadata = metadata else {
                print("Some error occurred: \(error.debugDescription)")
                completionHandler(error as! NSError)
                return
            }
            
            let url = metadata.downloadURL()
            print(url ?? "No url")
            
        }
        
        
        // Observing state changes
        
        uploadTask.observe(.success, handler: { (snapshot) in
            
            print(snapshot)
            print("Upload completed successfully")
            completionHandler(nil)
            
        })
        
    }
    
}

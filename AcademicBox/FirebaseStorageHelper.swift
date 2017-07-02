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

    private let kFirebaseStorageBucketUrl = "gs://academicbox-844fd.appspot.com"
    private let kImagesBucket = "images"
    private let kMaterialsBucket = "materials"
    
    var rootReference: StorageReference {
        return Storage.storage().reference(forURL: kFirebaseStorageBucketUrl)
    }
    
    var imagesBucketReference: StorageReference {
        return self.rootReference.child(kImagesBucket)
    }
    
    var materialsBucketReference: StorageReference {
        return self.imagesBucketReference.child(kMaterialsBucket)
    }
    
    func upload(image: Data, completionHandler: @escaping (_ error: NSError?) -> Void) {
        
        
        
    }
    
}

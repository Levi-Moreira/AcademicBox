//
//  Material.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 09/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseStorage

class Material {
    
    private static let kFirebaseStorageBucketUrl = "gs://academicbox-844fd.appspot.com"
    private static let kImagesBucket = "images"
    private static let kMaterialsBucket = "materials"

    var path = ""
    var data: Data?
    var kind: MaterialKind
    
    var randomImageFileName: String {
        return "some_random_name.jpeg"
    }
    
    init(kind: MaterialKind) {
        self.kind = kind
    }
    
    var rootReference: StorageReference {
        return Storage.storage().reference(forURL: Material.kFirebaseStorageBucketUrl)
    }
    
    var imagesBucketReference: StorageReference {
        return self.rootReference.child(Material.kImagesBucket)
    }
    
    var materialsBucketReference: StorageReference {
        return self.imagesBucketReference.child(Material.kMaterialsBucket)
    }
    
    func upload(progressHandler: @escaping (_ progress: Double) -> Void, completionHandler: @escaping (_ error: Error?) -> Void) {
        
        guard let data = self.data else { return }
        
        let name = self.randomImageFileName
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let reference = self.materialsBucketReference
            .child(name)
        self.path = reference.fullPath
        
        let uploadTask = reference.putData(data, metadata: metadata)
        
        // Observing state changes
        uploadTask.observe(.success, handler: { (snapshot) in
            completionHandler(nil)
        })
        
        uploadTask.observe(.progress) { (snapshot) in
            progressHandler(snapshot.progress?.fractionCompleted ?? 0.0)
        }
        
        uploadTask.observe(.failure) { (snapshot) in
            completionHandler(snapshot.error)
        }
        
    }
    
    func download() {
    }
    
//    init(json: JSON) {
//        self.name = json["name"].stringValue
//    }
//    
//    func toJson() -> [String: Any] {
//        return [
//            "name": self.name
//        ]
//    }
    
}

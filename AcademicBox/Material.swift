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
    var image: UIImage?
    var kind: MaterialKind
    var baseName = ""
    var key = ""
    
    var randomImageFileName: String {
        var r = [UInt32]()
        (0..<3).forEach { r.append($0 + arc4random() / 1000) }
        return "\(self.baseName)_\(r[0])\(r[1])\(r[2])).jpeg"
    }
    
    init(kind: MaterialKind) {
        self.kind = kind
    }
    
    init(kind: MaterialKind, key: String) {
        self.kind = kind
        self.key = key
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
        
        guard let image = self.image,
            let data = UIImageJPEGRepresentation(image, 0.0) else { return }
        
        self.key = self.randomImageFileName
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let reference = self.materialsBucketReference
            .child(self.key)
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
    
    func download(completionHandler: @escaping (Error?) -> Void) {
        
        let reference = self.materialsBucketReference.child(self.key)
        
        reference.getData(maxSize: 1024*1024*5) { [weak self] (data, error) in
            
            guard let data = data else {
                // TODO Handle errors
                return
            }
            
            guard let image = UIImage(data: data) else {
                // TODO Handle errors
                return
            }
            
            self?.image = image
            
            completionHandler(nil)
            
        }
        
    }
    
}

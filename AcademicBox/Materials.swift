//
//  Materials.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 02/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Materials: NSObject {
    
    private let kMaterialsPath = "materials"
    
    var name = ""
    var images = [Material]()
    var uploadedImages = 0
    var uploadedImagesError = 0
    
    let discipline = Discipline(name: "")
    
    var reference: DatabaseReference {
        return Database.database().reference(withPath: "materials")
    }
    
    func add(image: Material) {
        self.images.append(image)
    }
    
    func upload(completionBlock: @escaping (_ error: Error?) -> Void) {
        
        self.reference.childByAutoId().setValue(self.toJson()) { [weak self] (error, reference) in
            
            if let _ = error {
                completionBlock(error)
                return
            }
            
            print("Materials \(reference.key) saved")
            if let images = self?.images {
                images.forEach { $0.baseName = reference.key }
            }
            
            completionBlock(nil)
            
        }
        
    }
    
    func uploadImages() {
        self.images.forEach {
            $0.upload(progressHandler: { (fraction) in
            }, completionHandler: { [weak self] (error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    if let c = self?.uploadedImagesError {
                        self?.uploadedImagesError = c + 1
                    }
                }
                guard let c = self?.uploadedImages else {
                    return
                }
                self?.uploadedImages = c - 1
                if(c - 1 <= 0) {
                    self?.didFinishUploadingImages()
                }
            })
        }
    }
    
    func uploadAudios() {
    }
    
    func uploadVideos() {
    }
    
    func didFinishUploadingImages() {
    }
    
    //    init(json: JSON) {
    //        self.name = json["name"].stringValue
    //    }
    //
    func toJson() -> [String: Any] {
        let discipline: [String: Any] = [self.discipline.name.snakerized: self.discipline.name]
        return [
            "name": self.name,
            "discipline": discipline
        ]
    }
    
}

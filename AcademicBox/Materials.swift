//
//  Materials.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 02/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftyJSON

class Materials: NSObject {
    
    private let kMaterialsPath = "materials"
    
    var name = ""
    var key = ""
    var images = [Material]()
    var uploadedImages = 0
    var uploadedImagesError = 0
    
    let discipline = Discipline(name: "")
    
    static var reference: DatabaseReference {
        return Database.database().reference(withPath: "materials")
    }
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        let imagesJson = json["images"].arrayValue
        for imageJson in imagesJson {
            self.images.append(Material(kind: .image, key: imageJson.stringValue))
        }
    }
    
    static func all(completionBlock: @escaping ([Materials]?) -> Void) {
        
        Materials.reference.observe(.value, with: { (snapshot) in
            
            if let value = snapshot.value {
                
                var materials = [Materials]()
                
                let json = JSON(value)
                for (i, j) in json.makeIterator() {
                    let material = Materials(json: j)
                    material.key = i
                    print(material)
                    materials.append(material)
                }
                
                completionBlock(materials)
                
            } else {
                completionBlock(nil)
            }
            
        })
        
    }
    
    func add(image: Material) {
        self.images.append(image)
    }
    
    func upload(completionBlock: @escaping (_ error: Error?) -> Void) {
        
        Materials.reference.childByAutoId().setValue(self.toJson()) { [weak self] (error, reference) in
            
            if let _ = error {
                completionBlock(error)
                return
            }
            
            print("Materials \(reference.key) saved")
            self?.key = reference.key
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
    
    func updateImagesReferences() {
        
        if self.key.isEmpty { return }
        
        var names = [String]()
        self.images.forEach { names.append($0.key) }
        let dict: [String: [String]] = ["images": names]
        
        Materials.reference.child(self.key).updateChildValues(dict) { (error, reference) in
            
            if let _ = error {
                return
            }
            
            print(reference)
            
        }
        
    }
    
    func uploadAudios() {
    }
    
    func uploadVideos() {
    }
    
    func didFinishUploadingImages() {
    }
    
    func toJson() -> [String: Any] {
        let discipline: [String: Any] = [self.discipline.name.snakerized: self.discipline.name]
        return [
            "name": self.name,
            "discipline": discipline
        ]
    }
    
}

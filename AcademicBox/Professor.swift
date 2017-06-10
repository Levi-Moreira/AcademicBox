//
//  Professor.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 10/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseDatabase

extension String {

    var snakerized: String  {
        let words = self.components(separatedBy: " ")
        let lowercasedWords = words.map { $0.lowercased() }
        return lowercasedWords.joined(separator: "_")
    }
    
}

class Professor {
    
    var name: String
    var bio: String
    
    static let kReferenceName = "professors"
    
    static var professors: [Professor] {
        return [
            Professor(name: "Francisco José", bio: "The guy is really dark"),
            Professor(name: "Ricardo Guedes", bio: "Turtle guy"),
            Professor(name: "Ernani", bio: "Best professor ever")
        ]
    }
    
    init(name: String, bio: String) {
        self.name = name
        self.bio = bio
    }
    
    func toJson() -> [String: Any] {
        let json: [String: Any] = [
            "name": self.name,
            "bio": self.bio
        ]
        return json
    }
    
    static func saveProfessors() {
        
        let reference = Database.database().reference(withPath: kReferenceName)
        
        for professor in Professor.professors {
            let name = professor.name.snakerized
            let childRef = reference.child(name)
            childRef.setValue(professor.toJson())
        }
        
    }
    
}

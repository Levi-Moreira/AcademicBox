//
//  Discipline.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 10/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftyJSON

class Discipline {
    
    var name: String
    var professor: Professor?
    
    static let kReferenceName = "disciplines"
    static let kReferenceUsersName = "users"
    
    var reference: DatabaseReference {
        return Database
            .database()
            .reference(withPath: Discipline.kReferenceName)
            .child(self.name.snakerized)
    }
    
    var usersReference: DatabaseReference {
        return self.reference.child(Discipline.kReferenceUsersName)
    }
    
    static var disciplines: [Discipline] {
        let professors = Professor.professors
        var disciplines = [Discipline]()
        disciplines.append(Discipline(name: "Linear Systems", professor: professors[0]))
        disciplines.append(Discipline(name: "Programming Logic 1", professor: professors[1]))
        disciplines.append(Discipline(name: "Data Structure", professor: professors[2]))
        disciplines.append(Discipline(name: "Information System Project", professor: professors[3]))
        return disciplines
    }
    
    init(name: String, professor: Professor) {
        self.name = name
        self.professor = professor
    }
    
    init(name: String) {
        self.name = name
    }
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.professor = Professor(name: json["professor"]["name"].stringValue, bio: "")
    }
    
    static func saveDisciplines() {
        let disciplines = Discipline.disciplines
        let reference = Database.database().reference(withPath: kReferenceName)
        for discipline in disciplines {
            reference.child(discipline.name.snakerized).setValue(discipline.toJson())
        }
    }
    
    func toJson() -> [String: Any] {
        let professor: [String: Any] = [
            "id": self.professor?.name.snakerized ?? "",
            "name": self.professor?.name ?? ""
        ]
        let json: [String: Any] = [
            "name": self.name,
            "professor": professor
        ]
        return json
    }
    
    func clone() -> Discipline {
        let d = Discipline(name: self.name)
        d.professor = Professor(name: self.professor?.name ?? "", bio: self.professor?.bio ?? "")
        return d
    }
    
}

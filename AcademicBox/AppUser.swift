//
//  User.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 11/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class AppUser: NSObject {

    var name: String = ""
    var email: String = ""
    var id: String = ""
    
    var disciplines = [Discipline]()
    
    static let kReferenceName = "users"
    static let kReferenceDisciplinesName = "disciplines"
    
    static var loggedUser: AppUser {
        return AppUser(user: Auth.auth().currentUser)
    }
    
    override init() {
        super.init()
    }
    
    init(id: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    init(user: User?) {
        self.id = user?.uid ?? ""
        self.name = user?.displayName ?? ""
        self.email = user?.email ?? ""
    }
    
    func toJson() -> [String: Any] {
        let json: [String: Any] = [
            "email": self.email
        ]
        return json
    }
    
    func saveUserToCloud() {
        let reference = Database.database().reference(withPath: AppUser.kReferenceName)
        reference.child(self.id).setValue(self.toJson())
    }
    
    func selfReference() -> DatabaseReference {
        return Database
            .database()
            .reference(withPath: AppUser.kReferenceName)
            .child(self.id)
    }
    
    func add(discipline: Discipline) {
        self.disciplines.append(discipline)
    }
    
    func saveDisciplines() {
        var disciplinesJson = [String: String]()
        let userJson: [String: Any] = ["\(self.id)": true]
        for discipline in disciplines {
            disciplinesJson.updateValue(discipline.name, forKey: discipline.name.snakerized)
            discipline.usersReference.updateChildValues(userJson)
        }
        let json: [String: Any] = ["\(AppUser.kReferenceDisciplinesName)": disciplinesJson]
        self.selfReference().updateChildValues(json)
    }
    
    func loadDisciplines(completionBlock: @escaping ([Discipline]) -> Void) {
        let reference = Database
            .database()
            .reference(withPath: AppUser.kReferenceName)
            .child(self.id)
            .child(AppUser.kReferenceDisciplinesName)
        reference.observe(.value, with: { (snapshot) in
            
            var disciplines = [Discipline]()
            if let values = snapshot.value as? [String: String] {
                values.forEach { disciplines.append(Discipline(name: $1)) }
                completionBlock(disciplines)
            }
            
        })
    }
    
}


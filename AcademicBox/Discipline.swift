//
//  Discipline.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 10/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import Foundation
import FirebaseDatabase

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
        disciplines.append(Discipline(name: "Sistemas Lineares", professor: professors[0]))
        disciplines.append(Discipline(name: "Lógica de Programação 1", professor: professors[1]))
        disciplines.append(Discipline(name: "Estrutura de Dados", professor: professors[2]))
        return disciplines
    }
    
    init(name: String, professor: Professor) {
        self.name = name
        self.professor = professor
    }
    
    init(name: String) {
        self.name = name
    }
    
    
    static func saveDisciplines() {
        let disciplines = Discipline.disciplines
        let reference = Database.database().reference(withPath: kReferenceName)
        for discipline in disciplines {
            reference.child(discipline.name.snakerized).setValue(discipline.toJson())
        }
    }
    
    func toJson() -> [String: Any] {
        let json: [String: Any] = [
            "name": self.name,
            "professor": self.professor?.name.snakerized ?? ""
        ]
        return json
    }
    
}

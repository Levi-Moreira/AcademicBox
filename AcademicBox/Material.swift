//
//  Material.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 09/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import Foundation
import SwiftyJSON


class Material {

    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(json: JSON) {
        self.name = json["name"].stringValue
    }
    
    func toJson() -> [String: Any] {
        return [
            "name": self.name
        ]
    }
    
}

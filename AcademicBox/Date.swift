//
//  Date.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 16/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import Foundation

extension Date {
    
    var string: String {
        return DateFormatter.defaultDateFormatter.string(from: self)
    }
    
    var humanString: String {
        return DateFormatter.humanDateFormatter.string(from: self)
    }
    
}

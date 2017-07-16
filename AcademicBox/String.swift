//
//  String.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 16/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import Foundation

extension String {
    
    var date: Date {
        return DateFormatter.defaultDateFormatter.date(from: self) ?? Date()
    }
    
}

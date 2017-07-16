//
//  DateFormatter.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 16/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import Foundation

extension DateFormatter {

    static var defaultDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter
    }
    
    static var humanDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }
    
}

//
//  Formatter.swift
//  outlook-api-tutorial
//
//  Created by Tomek Buslowski on 11.09.2017.
//  Copyright © 2017 Tomek Buslowski. All rights reserved.
//

import Foundation
import SwiftyJSON

class Formatter {
    class func dateToString(date: JSON) -> String {
        let graphDateString = date.stringValue
        if (graphDateString.isEmpty) {
            return ""
        }
        
        let toDateFormatter = DateFormatter()
        toDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateObj = toDateFormatter.date(from: graphDateString)
        if (dateObj == nil) {
            return ""
        }
        
        let toStringFormatter = DateFormatter()
        toStringFormatter.dateStyle = DateFormatter.Style.medium
        toStringFormatter.timeStyle = DateFormatter.Style.short
        toStringFormatter.timeZone = TimeZone.current
        
        return toStringFormatter.string(from: dateObj!)
    }
}

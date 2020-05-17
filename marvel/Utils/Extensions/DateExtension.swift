//
//  DateExtension.swift
//  marvel
//
//  Created by Sonia Giraldez on 15/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSSSS'Z'"
        return dateFormatter.string(from: self)
    }
}

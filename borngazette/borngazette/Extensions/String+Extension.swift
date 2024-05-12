//
//  String+Extension.swift
//  BornGazette
//
//  Created by Rafael Melo on 12/05/24.
//

import Foundation

extension String {
    var readableDate: String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let oldDate = olDateFormatter.date(from: self)

        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd MMM yyyy, h:mm a"

        return convertDateFormatter.string(from: oldDate!)
    }
}

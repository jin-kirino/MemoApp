//
//  Memo+CoreDataProperties.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/08/15.
//
//

import Foundation
import CoreData

extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?

}

extension Memo: Identifiable {
    public var stringDateAt: String { dateFormatter(date: date ?? Date())}

    func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

        return dateFormatter.string(from: date)
    }
}

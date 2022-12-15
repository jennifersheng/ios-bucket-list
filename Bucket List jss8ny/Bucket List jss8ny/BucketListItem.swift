//
//  BucketListItem.swift
//  Bucket List jss8ny
//

// Resources:
// https://bruno.ph/blog/articles/swift-tutorial-mytodo/

import UIKit

class BucketListItem : NSObject {
    var title: String
    var dueDate: Date
    var completed: Bool
    var completedDate: Date
    
    public init(title: String, dueDate: Date, completed: Bool, completedDate: Date) {
        self.title = title
        self.dueDate = dueDate
        self.completed = completed
        self.completedDate = completedDate
    }
}

// Reference:
// https://stackoverflow.com/questions/39934057/convert-date-to-integer-in-swift
// https://nshipster.com/datecomponents/
// prepopulate data on launch 
extension BucketListItem {
    public class func getPrepopData() -> [[BucketListItem]] {
        let calendar = Calendar.current
        let uncompletedList = [
            BucketListItem(title: "Take an FDOC picture", dueDate: calendar.date(from: DateComponents(calendar: calendar, year: 2022, month: 8, day: 23))!, completed: false, completedDate: Date(timeIntervalSince1970: TimeInterval(0))),
            BucketListItem(title: "Celebrate the holidays by going to Lighting of the Lawn", dueDate: calendar.date(from: DateComponents(calendar: calendar, year: 2022, month: 12, day: 8))!, completed: false, completedDate: Date(timeIntervalSince1970: TimeInterval(0))),
            BucketListItem(title: "Plan a getaway with friends for Spring Break", dueDate: calendar.date(from: DateComponents(calendar: calendar, year: 2023, month: 3, day: 23))!, completed: false, completedDate: Date(timeIntervalSince1970: TimeInterval(0))),
            BucketListItem(title: "Wear the Honors of Honor", dueDate: calendar.date(from: DateComponents(calendar: calendar, year: 2023, month: 5, day: 19))!, completed: false, completedDate: Date(timeIntervalSince1970: TimeInterval(0)))
        ]
        let completedList = [
            BucketListItem(title: "Get the #1 ticket at Bodos", dueDate: calendar.date(from: DateComponents(calendar: calendar, year: 2023, month: 5, day: 19))!, completed: true, completedDate: calendar.date(from: DateComponents(calendar: calendar, year: 2022, month: 10, day: 4))!),
            BucketListItem(title: "Attend Sunset Series at Carters Mountain", dueDate: calendar.date(from: DateComponents(calendar: calendar, year: 2022, month: 9, day: 29))!, completed: true, completedDate: calendar.date(from: DateComponents(calendar: calendar, year: 2022, month: 9, day: 15))!)
        ]

        return [uncompletedList, completedList]
    }
}

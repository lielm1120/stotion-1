//
//  Task.swift
//  stotion
//
//  Created by Liel Machluf on 1/29/23.
//


import SwiftUI

// MARK: Task Model
struct Task: Identifiable{
    var id: UUID = .init()
    var dateAdded: Date
    var taskName: String
    var taskDescription: String
    var taskCategory: Category
}

func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM"
    let dateString = dateFormatter.string(from: date)
    return dateString
    increaceCounter()
}



/// - Sample Tasks
var sampleTasks: [Task] = [
    .init(dateAdded: Date(timeIntervalSince1970: 1672829809), taskName: "Edit Video", taskDescription: "", taskCategory: .general),
    .init(dateAdded: Date(timeIntervalSince1970: 1672833409), taskName: " Geometry Effect(Issue)", taskDescription: "", taskCategory: .bug),
    .init(dateAdded: Date(timeIntervalSince1970: 1672833409), taskName: "Multi-ScrollView", taskDescription: "", taskCategory: .challenge),
    .init(dateAdded: Date(timeIntervalSince1970: 1672837009), taskName: "Loreal Ipsum", taskDescription: "", taskCategory: .idea),
    .init(dateAdded: Date(timeIntervalSince1970: 1672714609), taskName: "Complete UI", taskDescription: "", taskCategory: .challenge),
    .init(dateAdded: Date(timeIntervalSince1970: 1672851409), taskName: "Fix Shadow issue on Mockup's", taskDescription: "", taskCategory: .bug),
    .init(dateAdded: Date(timeIntervalSince1970: 1672901809), taskName: "Add Shadow Effect in Mockview App", taskDescription: "", taskCategory: .idea),
    .init(dateAdded: Date(timeIntervalSince1970: 1672901809), taskName: "Twitter/Instagram Post", taskDescription: "", taskCategory: .general),
    .init(dateAdded: Date(timeIntervalSince1970: 1672923409), taskName: "Lorem Ipsum", taskDescription: "", taskCategory: .modifiers),
]

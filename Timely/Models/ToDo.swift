//
//  ToDo.swift
//  Timely
//
//  Created by cole stevens on 9/25/22.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var timeGoal: Int = 0
    @objc dynamic var timetotal: Float = 0.00
}

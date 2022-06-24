//
//  Course.swift
//  AnimatedApp
//
//  Created by Meng To on 2022-04-14.
//

import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var caption: String
    var color: Color
    var image: Image
    var name : String
    var timeOfDay : Image
}

var courses = [
    Course(title: "Еда на завтрак!", subtitle: "Сколько углеводов в соке, хлебе и яйцах", caption: "20 sections - 3 hours", color: Color(hex: "7850F0"), image: Image("sunrise"), name: "breakfast", timeOfDay: Image("sunrise")),
    Course(title: "Еда на обед!", subtitle: "Сколько углеводов в супе, котлетах и макоронах", caption: "47 sections - 11 hours", color: Color(hex: "6792FF"), image: Image("Topic 2") , name: "lunch", timeOfDay: Image("daytime")),
    Course(title: "Еда на ужин!", subtitle: "Сколько углеводов в гарнире, мясе и алкоголе", caption: "21 sections - 4 hours", color: Color(hex: "005FE7"), image: Image("Topic 1"), name: "dinner", timeOfDay: Image("evening"))
]

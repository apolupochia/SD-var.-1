//
//  CourseSection.swift
//  AnimatedApp
//
//  Created by Meng To on 2022-04-14.
//

import SwiftUI

struct CourseSection: Identifiable {
    var id = UUID()
    var title: String
    var caption: String
    var color: Color
    var image: Image
}

var courseSections = [
    CourseSection(title: "Завтрак", caption: "Самый вадный прием пищи!", color: Color(hex: "9CC5FF"), image: Image("breakfastFoto46x46")),
    CourseSection(title: "Обед", caption: "Нужно зарядиться углеводами!", color: Color(hex: "6E6AE8"), image: Image("lunchFoto46x46")),
    CourseSection(title: "Ужин", caption: "Поел, выпил и в койку!", color: Color(hex: "005FE7"), image: Image("dinnerFoto46x46")),
   // CourseSection(title: "Button", caption: "Watch video - 9 mins", color: Color(hex: "BBA6FF"), image: Image("Topic 1"))
]

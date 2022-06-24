//
//  FoodInformation.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 17.06.2022.
//

import Foundation
import SwiftUI

struct FoodInformation : Identifiable{
    var id = UUID()
    var name : String
    var carbohydrates : Int
    var color : String
    var image : Image

}

var foods = [
    FoodInformation(name: "Картошка", carbohydrates: 100, color: "#D2691E", image: Image("dinner 3")),
    FoodInformation(name: "Гречка", carbohydrates: 100, color: "#1E90FF", image: Image("dinner 3")),
    FoodInformation(name: "Макароны", carbohydrates: 100, color: "#800080", image: Image("dinner 3")),
    FoodInformation(name: "Яблоко", carbohydrates: 100, color: "#00FF00", image: Image("dinner 3")),
    FoodInformation(name: "Груша", carbohydrates: 100, color: "#6A5ACD", image: Image("dinner 3")),
    FoodInformation(name: "Рис", carbohydrates: 100, color: "#FF4500", image: Image("dinner 3")),
    FoodInformation(name: "Пельмени", carbohydrates: 100, color: "#CD5C5C", image: Image("dinner 3")),
    FoodInformation(name: "Картошка", carbohydrates: 100, color: "#D2691E", image: Image("dinner 3")),
    FoodInformation(name: "Гречка", carbohydrates: 100, color: "#1E90FF", image: Image("dinner 3")),
    FoodInformation(name: "Макароны", carbohydrates: 100, color: "#800080", image: Image("dinner 3")),
    FoodInformation(name: "Яблоко", carbohydrates: 100, color: "#00FF00", image: Image("dinner 3")),
    FoodInformation(name: "Груша", carbohydrates: 100, color: "#6A5ACD", image: Image("dinner 3")),
    FoodInformation(name: "Рис", carbohydrates: 100, color: "#FF4500", image: Image("dinner 3")),
    FoodInformation(name: "Пельмени", carbohydrates: 100, color: "#CD5C5C", image: Image("dinner 3"))
]

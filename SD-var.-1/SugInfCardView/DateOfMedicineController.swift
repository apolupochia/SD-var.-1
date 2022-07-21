//
//  DaysSug.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 21.06.2022.
//

import SwiftUI
import CoreData

protocol DataManagerProtocolForSugAndTime{
    func saveTask(sugar: String, insulin: String)
    func fetchElements() -> [DateOfMedicine]
}

struct SugAndTime : DataManagerProtocolForSugAndTime{
    
    private var viewContext = PersistenceController.shared.container.viewContext

    static let shared = SugAndTime()
    
    
    func saveTask( sugar: String, insulin: String){
        
    let newItem = DateOfMedicine(context: viewContext)
                newItem.sugar = sugar
                newItem.date = Date()
                newItem.id = UUID()
                newItem.insulin = insulin
    
                do {
                    try viewContext.save()
                } catch {
                    print("error")
                }
    
    }
    
    
    func fetchElements() -> [DateOfMedicine]{
        
        var items : [DateOfMedicine] = []
        
        let fetchRequest: NSFetchRequest<DateOfMedicine> = DateOfMedicine.fetchRequest()
    
        
        let sort = NSSortDescriptor(keyPath: \DateOfMedicine.date, ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            
            items = try viewContext.fetch(fetchRequest)
            
        } catch let error {
            print(error)
        }
        
        
        return items
    }
    
}


struct SugarAndInsulinData : Identifiable {
    let id = UUID()
    var days : [SugarAndInsulin]
}

struct SugarAndInsulin : Identifiable, Hashable{ 
    let id = UUID()
    var date: Date
    var day : String
    var SugarAndInsulinUserInfo : [SugarAndInsulinInfo]
}

struct SugarAndInsulinInfo : Identifiable, Hashable{
    var id = UUID()
    
    var sugar: String
    var insulin: String
    var timeMinute : Int
    var timeHour : Int
}




func dayWeek(day: Int) -> String{
    switch day{
    case 1:
        return "Воскресенье"

    case 2:
        return "Понедельник"

    case 3:
        return "Вторник"

    case 4:
        return "Среда"

    case 5:
        return "Четверг"

    case 6:
        return "Пятница"

    case 7:
        return "Суббота"

    default:
        return "NOW"

    }

}



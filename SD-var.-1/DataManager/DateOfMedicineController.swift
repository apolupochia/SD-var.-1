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
    func addAllElement() -> SugarAndInsulinData
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
    
    
    func addAllElement() -> SugarAndInsulinData{
        
        let items = getItems()
        
        
        
        var sugInTime = SugarAndInsulinData(days: [])
        
        var day = -1
        var sugNow = SugarAndInsulin(date:Date() ,day: "", sugar: [], insulin: [],timeMinute: [],timeHour: [])
        for item in items{
            
            
            
            let date = item.date!
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            let dayNow = calendar.component(.weekday, from: date)
            
            if dayNow != day && day == -1{
                
                
                sugNow.date = item.date!
                sugNow.day = dayWeek(day: dayNow)
                sugNow.timeMinute.append(minutes)
                sugNow.timeHour.append(hour)
                sugNow.sugar.append(item.sugar ?? "")
                sugNow.insulin.append(item.insulin ?? "")

            }
            else if day == dayNow{
                sugNow.sugar.append(item.sugar ?? "")
                sugNow.timeMinute.append(minutes)
                sugNow.timeHour.append(hour)
                sugNow.insulin.append(item.insulin ?? "")
                

            }
            else if day != dayNow{
                sugInTime.days.append(sugNow)
                sugInTime.count += 1
                sugNow = SugarAndInsulin(date:Date() ,day: "", sugar: [], insulin: [],timeMinute: [],timeHour: [])
                sugNow.date = item.date!
                sugNow.day = dayWeek(day: dayNow)
                sugNow.sugar.append(item.sugar ?? "")
                sugNow.timeMinute.append(minutes)
                sugNow.timeHour.append(hour)
                sugNow.insulin.append(item.insulin ?? "")
                
            }
            day = dayNow
            
        }
        sugInTime.days.append(sugNow)
        
        return sugInTime
    }
    
    
    private func getItems() -> [DateOfMedicine]{
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


struct SugarAndInsulinData {
    var days : [SugarAndInsulin]
    var count = 0
}

struct SugarAndInsulin{
    var date: Date
    var day : String
    var sugar: [String]
    var insulin: [String]
    var timeMinute : [Int]
    var timeHour : [Int]
}

func dayWeek(day: Int) -> String{
    switch day{
    case 1:
        return "Воскресенье"
//           break
    case 2:
        return "Понедельник"
//          break
    case 3:
        return "Вторник"
//           break
    case 4:
        return "Среда"
//         break
    case 5:
        return "Четверг"
//           break
    case 6:
        return "Пятница"
//            break
    case 7:
        return "Суббота"
//         break
    default:
        return "NOW"
//         break
    }
//        return ""
}



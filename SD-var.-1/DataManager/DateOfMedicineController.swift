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
        var sugNow = SugarAndInsulin(date: Date(), day: "", SugarAndInsulinUserInfo: [])
        var sugNowInfo : [SugarAndInsulinInfo] = []
        var sugNowInfoNow = SugarAndInsulinInfo(sugar: "", insulin: "", timeMinute: 0, timeHour: 0)
        for item in items{
            
            
            
            let date = item.date!
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            let dayNow = calendar.component(.weekday, from: date)
            
            if dayNow != day && day == -1{
                
                
                sugNow.date = item.date!
                sugNow.day = dayWeek(day: dayNow)
                
                sugNowInfoNow.timeMinute = minutes
                sugNowInfoNow.timeHour = hour
                sugNowInfoNow.sugar = item.sugar ?? ""
                sugNowInfoNow.insulin = item.insulin ?? ""
                
                sugNowInfo.append(sugNowInfoNow)
                sugNowInfoNow = SugarAndInsulinInfo(sugar: "", insulin: "", timeMinute: 0, timeHour: 0)
                

            }
            else if day == dayNow{
                sugNowInfoNow.timeMinute = minutes
                sugNowInfoNow.timeHour = hour
                sugNowInfoNow.sugar = item.sugar ?? ""
                sugNowInfoNow.insulin = item.insulin ?? ""
                
                sugNowInfo.append(sugNowInfoNow)
                sugNowInfoNow = SugarAndInsulinInfo(sugar: "", insulin: "", timeMinute: 0, timeHour: 0)
                

            }
            else if day != dayNow{
                sugNow.SugarAndInsulinUserInfo = sugNowInfo
                sugInTime.days.append(sugNow)
                
                sugNowInfo = []
                sugNowInfoNow = SugarAndInsulinInfo(sugar: "", insulin: "", timeMinute: 0, timeHour: 0)
                sugNow.date = item.date!
                sugNow.day = dayWeek(day: dayNow)
                sugNowInfoNow.timeMinute = minutes
                sugNowInfoNow.timeHour = hour
                sugNowInfoNow.sugar = item.sugar ?? ""
                sugNowInfoNow.insulin = item.insulin ?? ""
                
                sugNowInfo.append(sugNowInfoNow)
                sugNowInfoNow = SugarAndInsulinInfo(sugar: "", insulin: "", timeMinute: 0, timeHour: 0)
                
            }
            day = dayNow
            
        }
        sugNow.SugarAndInsulinUserInfo = sugNowInfo
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



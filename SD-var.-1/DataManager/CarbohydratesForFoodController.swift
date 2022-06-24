//
//  DaysEating.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 21.06.2022.
//

import CoreData
import SwiftUI

protocol DataManagerProtocolForEatAndTime{
    func saveTask( amountOfCarbohydrates: String, thenEating: String)
    func addAllElement() -> ArbohydratesAndTimeData
}

struct EatAndTime : DataManagerProtocolForEatAndTime{
    
    private var viewContext = PersistenceController.shared.container.viewContext
    static let shared = EatAndTime()
    
    
    func saveTask( amountOfCarbohydrates: String, thenEating: String){
        let newItem = CarbohydratesForFood(context : viewContext)
        newItem.id = UUID()
        newItem.date = Date()
        newItem.amountOfCarbohydrates = amountOfCarbohydrates
        newItem.thenEating = thenEating
        
        do{
            try viewContext.save()
            
        } catch{
            
            print(error)
        }
        
    }
    
    
    func addAllElement() -> ArbohydratesAndTimeData{

        let items = getItems()
        
        
        var sugInTime = ArbohydratesAndTimeData(days: [])
        var day = -1
        var sugNow = ArbohydratesAndTime(date: Date(), day: "", timeMinute: [], timeHour: [], thenEating: [], amountOfCarbohydrates: [])
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
                sugNow.thenEating.append(item.thenEating!)
                sugNow.amountOfCarbohydrates.append(item.amountOfCarbohydrates!)

            }
            else if day == dayNow{
                sugNow.timeMinute.append(minutes)
                sugNow.timeHour.append(hour)
                sugNow.thenEating.append(item.thenEating!)
                sugNow.amountOfCarbohydrates.append(item.amountOfCarbohydrates!)
                

            }
            else if day != dayNow{
                sugInTime.days.append(sugNow)
                //sugInTime.id = UUID()
                sugNow = ArbohydratesAndTime(date: Date(), day: "", timeMinute: [], timeHour: [], thenEating: [], amountOfCarbohydrates: [])
                sugNow.date = item.date!
                sugNow.day = dayWeek(day: dayNow)
                sugNow.timeMinute.append(minutes)
                sugNow.timeHour.append(hour)
                sugNow.thenEating.append(item.thenEating!)
                sugNow.amountOfCarbohydrates.append(item.amountOfCarbohydrates!)
                
            }
            day = dayNow
            
        }
        sugInTime.days.append(sugNow)
        
        return sugInTime
    }
    
    
    
    private func getItems() -> [CarbohydratesForFood]{
        var items : [CarbohydratesForFood] = []
        
        let fetchRequest: NSFetchRequest<CarbohydratesForFood> = CarbohydratesForFood.fetchRequest()
        
        
        let sort = NSSortDescriptor(keyPath: \CarbohydratesForFood.date, ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        
        do {
            items = try viewContext.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
        return items
    }
}


struct ArbohydratesAndTimeData : Identifiable {
    var days : [ArbohydratesAndTime]
    let id = UUID()
}

struct ArbohydratesAndTime: Identifiable, Hashable{
    let id = UUID()
    var date: Date
    var day : String
    var timeMinute : [Int]
    var timeHour : [Int]
    var thenEating : [String]
    var amountOfCarbohydrates : [String]
    
}




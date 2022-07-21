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
    func fetchAllElements() -> ArbohydratesAndTimeData
    func deleteItems(offsets: IndexSet)
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
    
    
    func fetchAllElements() -> ArbohydratesAndTimeData{

        let items = getItems()
        
        
        var sugInTime = ArbohydratesAndTimeData(days: [])
        var day = -1
        var sugNow = ArbohydratesAndTime(date: Date(), day: "", informationAboutDay: [])
        var infoAboutDayNow = ArbohydratesAndTimePref(timeMinute: 0, timeHour: 0, thenEating: "", amountOfCarbohydrates: "")
        var infoAboutDayNowMass: [ArbohydratesAndTimePref] = []
        for item in items{
            
            
            
            let date = item.date!
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            let dayNow = calendar.component(.weekday, from: date)
            
            if dayNow != day && day == -1{
                
                
                sugNow.date = item.date!
                sugNow.day = dayWeek(day: dayNow)
                infoAboutDayNow.timeMinute = minutes
                infoAboutDayNow.timeHour = hour
                infoAboutDayNow.thenEating = item.thenEating!
                infoAboutDayNow.amountOfCarbohydrates = item.amountOfCarbohydrates!
                
                infoAboutDayNowMass.append(infoAboutDayNow)
                infoAboutDayNow = ArbohydratesAndTimePref(timeMinute: 0, timeHour: 0, thenEating: "", amountOfCarbohydrates: "")

            }
            else if day == dayNow{
                infoAboutDayNow.timeMinute = minutes
                infoAboutDayNow.timeHour = hour
                infoAboutDayNow.thenEating = item.thenEating!
                infoAboutDayNow.amountOfCarbohydrates = item.amountOfCarbohydrates!
                
                infoAboutDayNowMass.append(infoAboutDayNow)
                infoAboutDayNow = ArbohydratesAndTimePref(timeMinute: 0, timeHour: 0, thenEating: "", amountOfCarbohydrates: "")
                

            }
            else if day != dayNow{
                sugNow.informationAboutDay = infoAboutDayNowMass
                sugInTime.days.append(sugNow)
                
                sugNow = ArbohydratesAndTime(date: Date(), day: "", informationAboutDay: [])
                infoAboutDayNow = ArbohydratesAndTimePref(timeMinute: 0, timeHour: 0, thenEating: "", amountOfCarbohydrates: "")
                infoAboutDayNowMass = []
                
                sugNow.date = item.date!
                sugNow.day = dayWeek(day: dayNow)
                
                infoAboutDayNow.timeMinute = minutes
                infoAboutDayNow.timeHour = hour
                infoAboutDayNow.thenEating = item.thenEating!
                infoAboutDayNow.amountOfCarbohydrates = item.amountOfCarbohydrates!
                
                infoAboutDayNowMass.append(infoAboutDayNow)
                infoAboutDayNow = ArbohydratesAndTimePref(timeMinute: 0, timeHour: 0, thenEating: "", amountOfCarbohydrates: "")
                
                
            }
            day = dayNow
            
        }
        sugNow.informationAboutDay = infoAboutDayNowMass
        sugInTime.days.append(sugNow)
        
        return sugInTime
    }
    
    func deleteItems(offsets: IndexSet) {
        let itemsOld = getItems()
        withAnimation {
            offsets.map { itemsOld[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {

                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        
        }
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
    var informationAboutDay : [ArbohydratesAndTimePref]

    
}

struct ArbohydratesAndTimePref : Identifiable, Hashable{
    let id = UUID()
    var timeMinute : Int
    var timeHour : Int
    var thenEating : String
    var amountOfCarbohydrates : String
}





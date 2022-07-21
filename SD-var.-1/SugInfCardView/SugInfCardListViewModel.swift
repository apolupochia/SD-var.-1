//
//  SugInfCardListView.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 29.06.2022.
//

import Foundation


protocol CourseListViewModelProtocol {
    var rows: SugarAndInsulinData { get }
    func fetchRows()
}


class CourseListViewModel: CourseListViewModelProtocol, ObservableObject {
    @Published var rows: SugarAndInsulinData = SugarAndInsulinData(days: [])
    
    func fetchRows() {
        rows = addAllElements(SugAndTime.shared.fetchElements())
    }
}


func addAllElements(_ items : [DateOfMedicine] ) -> SugarAndInsulinData{
    
    
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




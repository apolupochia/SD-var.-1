//
//  HistoryInformationCardViewModel.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 01.07.2022.
//

import Foundation

protocol HistoryInformationViewProtocol {
    var rows : ArbohydratesAndTimeData { get }
    func fetchHistoryInformation()
    
}

class HistoryInformationView : HistoryInformationViewProtocol, ObservableObject{
    @Published var rows: ArbohydratesAndTimeData = ArbohydratesAndTimeData(days: [])
    
    func fetchHistoryInformation() {
        rows = EatAndTime.shared.fetchAllElements()
    }
    
    
}



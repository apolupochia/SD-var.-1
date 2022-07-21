//
//  HistoryInformationCard.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 18.06.2022.
//

import SwiftUI

struct HistoryInformationCard: View {
    var timeEatOfDay : String
    var timeHour : Int
    var tomeMinute : Int
    var Carbohydrates : String
    var body: some View {
        VStack(alignment: .center, spacing: .none){
            HStack{
                Text(timeEatOfDay)
                   // .font(.title)
                Spacer()
                VStack(alignment: .leading, spacing: 0){
                    Text("\(Carbohydrates)г углеводов")
                    Text("\(timeHour):\(tomeMinute)")
                        .frame( alignment: .trailing)
                        
                }
            }
            .frame(height: 64)
        }
        
        .background(.yellow)
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
       // .padding()
        
        
    }
        
}

struct HistoryInformationCard_Previews: PreviewProvider {
    static var previews: some View {
        HistoryInformationCard(timeEatOfDay: "Завтрак", timeHour: 11, tomeMinute: 22, Carbohydrates: "233")
    }
}

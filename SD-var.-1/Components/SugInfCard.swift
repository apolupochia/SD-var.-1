//
//  SugInfCard.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 18.06.2022.
//

import SwiftUI

struct SugInfCard: View {
    let timeHour: Int
    let timeMinute: Int
    let howSugur : String
    let howInsulin : String
    
    var body: some View {
        HStack{
            VStack{
                Text("Время  \(timeHour):\(timeMinute)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                Text("Сахар : \(howSugur)")
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                Text("Инсулин новоропит : \(howInsulin)мл")
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
            }
            

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight : 100)
        .background(.brown)
        .foregroundColor(.white)
        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
        
    }
}

struct SugInfCard_Previews: PreviewProvider {
    static var previews: some View {
        SugInfCard(timeHour: 1, timeMinute: 1, howSugur: "5", howInsulin: "12")
    }
}

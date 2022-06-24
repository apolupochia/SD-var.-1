//
//  View + InformationFood.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 17.06.2022.
//

import SwiftUI

struct View___InformationFood: View {
    var foodInf = foods
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
        VStack{
            Text("Food Information")
                .font(.title)
                .foregroundColor(.blue)
                
                ForEach(foodInf) { item in
                    FoodInformationCard(foodsInf: item)
                
            }
           
        }
        .padding()
        
        }
        .background(Color(hex: "#FFFFE0"))

    }
}

struct View___InformationFood_Previews: PreviewProvider {
    static var previews: some View {
        View___InformationFood()
    }
}

//
//  View+SugInfCard.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 18.06.2022.
//


import SwiftUI

struct View_SugInfCard: View {
    @Binding var showAnyView : Bool
    @State var newSug : String = ""
    @State var showModal = false
    
    @StateObject private var viewModel = CourseListViewModel()
    


    
    var body: some View {
      
        ZStack{
            if !showModal{
            mainContent
                .background(Color(hex: "#FFFFE0"))
            }
            
            if showModal{
                AddNewDimensionsView(showAnyView: $showAnyView, newSug: $newSug, showModal: $showModal)
                    .transition(
                        .move(edge: .trailing)
                    )
            }
        
        }

    }
    
    private var mainContent : some View{
        VStack{
            Button {
                showAnyView = false
                showModal = true
            } label: {
                Label("add", systemImage: "plus")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)

            if !showModal{
            ScrollView(.vertical, showsIndicators: false) {
        
                ForEach(Array(viewModel.rows.days), id: \.self) { day in
                    
                    Text("\(day.day)")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                    Text("\(day.date, formatter : formatter)")
                        
                    ForEach(day.SugarAndInsulinUserInfo){ dayInf in
                        SugInfCard(timeHour: dayInf.timeHour,
                                   timeMinute: dayInf.timeMinute,
                                   howSugur: dayInf.sugar,
                                   howInsulin: dayInf.insulin
                        )
                    }
                    

                }
            }
            .onAppear{
                viewModel.fetchRows()
            }
            .offset(y:-20)
            .padding()
            
            }
        }
    }
}



struct View_SugInfCard_Previews: PreviewProvider {
    static var previews: some View {
        View_SugInfCard(showAnyView: .constant(true))
    }
}


var formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy"
   // formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss z"
    return formatter
}()

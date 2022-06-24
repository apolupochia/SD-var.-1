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
    var tyt = true
    var dayCount = ""
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DateOfMedicine.date, ascending: false)],
        animation: .default)
    
     private var items: FetchedResults<DateOfMedicine>

    
    var body: some View {
      
        ZStack{
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
                   // var Sug = SugAndTime(items: items)
                    let days = SugAndTime.shared.addAllElement()
            
                    ForEach(0..<days.count + 1) { i in
                        Text("\(days.days[i].day)")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                        Text("\(days.days[i].date, formatter : formatter)")
                            
                        ForEach(0..<days.days[i].insulin.count){ unt in
                            SugInfCard(timeHour: days.days[i].timeHour[unt], timeMinute: days.days[i].timeMinute[unt], howSugur: days.days[i].sugar[unt],
                            howInsulin: days.days[i].insulin[unt])
                        }
                        

                    }
                }
                .offset(y:-20)
                .padding()
                
                }
            }
            .background(Color(hex: "#FFFFE0"))
            
            if showModal{
                AddNewDimensionsView(showAnyView: $showAnyView, newSug: $newSug, showModal: $showModal)
                    .transition(
                        .move(edge: .trailing)
                    )
            }
        
        }

    }
}

var formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy"
   // formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss z"
    return formatter
}()

struct View_SugInfCard_Previews: PreviewProvider {
    static var previews: some View {
        View_SugInfCard(showAnyView: .constant(true))
    }
}

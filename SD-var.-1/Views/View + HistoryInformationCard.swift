//
//  View + HistoryInformationCard.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 18.06.2022.
//

import SwiftUI

struct View___HistoryInformationCard: View {
    
    @State private var  showModal = false
    @Binding var showAnyView : Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CarbohydratesForFood.date, ascending: false)],
        animation: .default)
    
    private var itemsOld : FetchedResults<CarbohydratesForFood>
  
    var body: some View {
        
        ZStack {
            VStack {
                Button {
                    showModal = true
                    showAnyView.toggle()
                } label: {
                    Label("add", systemImage: "plus")
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.horizontal, 5)
                
                List{
                    let items = EatAndTime.shared.addAllElement()
                    Text("История приема пищи!")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                    ForEach(Array(items.days), id: \.self) { item in
                        VStack{
                        Text(item.day)
                                .listRowInsets(EdgeInsets())
                            .font(.title)
                            .foregroundColor(.green)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text("\(item.date, formatter : formatter)")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .listRowInsets(EdgeInsets())
                    
                        }
                            ForEach(0..<item.amountOfCarbohydrates.count){ i in
                                HistoryInformationCard(
                                    timeEatOfDay: item.thenEating[i],
                                    timeHour: (item.timeHour[i]),
                                    tomeMinute: (item.timeMinute[i]),
                                    Carbohydrates: (item.amountOfCarbohydrates[i])
                                )
                               
                        }

                            .onDelete(perform: deleteItems)
                           
                       
                    }
                }
                .foregroundColor(.black)
                .onAppear {
                    // Set the default to clear
                    UITableView.appearance().backgroundColor = .clear
                }
               
                .listStyle(InsetListStyle())
//                .listStyle(DefaultListStyle())
//                .listStyle(GroupedListStyle())
 //               .listStyle(SidebarListStyle())
//                .listStyle(BorderedListStyle())
//                .listStyle(CarouselListStyle())
//                .listStyle(EllipticalListStyle())
//                .listStyle(InsetGroupedListStyle())
                
                
               
                
                .background(.white)
            }
            
            .background(.white)
            if showModal{
                AddNewEatingView(showAnyView: $showAnyView, showModal: $showModal)
                    .background(Color.white)
                    .transition(
                        .move(edge: .trailing)
                    )
            }
            
        }

        
        
        .background(.white)
        
    }
    
    private func deleteItems(offsets: IndexSet) {
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
}

struct View___HistoryInformationCard_Previews: PreviewProvider {
    static var previews: some View {
        View___HistoryInformationCard(showAnyView: .constant(true))
    }
}


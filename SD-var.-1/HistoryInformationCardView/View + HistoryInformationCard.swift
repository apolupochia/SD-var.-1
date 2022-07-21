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
    
    @StateObject private var viewModel = HistoryInformationView()
    
    
    
    @State private var items = EatAndTime.shared.fetchAllElements()
  
    var body: some View {
        
        ZStack {
            if !showModal{
                mainContent
                    .background(.white)
            }
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
    
    
    private var mainContent : some View{
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
                
                Text("История приема пищи!")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
                ForEach(viewModel.rows.days) { item in
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
                    ForEach(item.informationAboutDay){ elem in
                            HistoryInformationCard(
                                timeEatOfDay: elem.thenEating,
                                timeHour: (elem.timeHour),
                                tomeMinute: (elem.timeMinute),
                                Carbohydrates: (elem.amountOfCarbohydrates)
                            )

                    }

                       .onDelete(perform: deleteItems)
                       
                   
                }
             
            }

            .foregroundColor(.black)
            .onAppear {
                viewModel.fetchHistoryInformation()
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
   
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            EatAndTime.shared.deleteItems(offsets: offsets)
        }
        viewModel.fetchHistoryInformation()
    }
}

struct View___HistoryInformationCard_Previews: PreviewProvider {
    static var previews: some View {
        View___HistoryInformationCard(showAnyView: .constant(true))
    }
}


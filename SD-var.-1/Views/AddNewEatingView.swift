//
//  SwiftUIView.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 21.06.2022.
//

import SwiftUI




enum Topping: String, CaseIterable, Identifiable {
    case перекус, завтрак, обед, ужин
    var id: Self { self }
}



struct AddNewEatingView: View {
    @Binding var showAnyView : Bool
    
   // @Environment (.\managedObjectContext) private var viewContext
    
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest( //entity: Eating.entity(),
//        sortDescriptors: [],
//        animation: .default
//    )
//    private var items : FetchedResults<Eating>
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    
    private var items: FetchedResults<CarbohydratesForFood>
    
    @State private var selectedTopping: Topping = .перекус
    @State private var carbohydrates = ""
    @Binding var showModal : Bool
    var body: some View {
        VStack {
            Spacer()
            Text("Введите принятое количество углеводов")
                .font(.title)
                .foregroundColor(.black)
            
            TextField("~50", text: $carbohydrates )
            
            
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 4)
                        .foregroundColor(.blue)
                )
                .padding()
                .textContentType(.oneTimeCode)
                .keyboardType(.numberPad)
                .foregroundColor(.black)
                .background(.white)
            
            
        Spacer()
            Picker("Topping", selection: $selectedTopping) {
                ForEach(Topping.allCases) { topping in
                    Text(topping.rawValue.capitalized)
                        .foregroundColor(.black)
                }
            }
            .frame(width: 300, height: 100)
            .foregroundColor(.black)
            
            
            // .pickerStyle(.inline)
            // .pickerStyle(.automatic)
            //  .pickerStyle(.menu)
             .pickerStyle(.wheel)
            // .pickerStyle(.segmented)
            // .pickerStyle(.)
            
            Spacer()
            Button {
                if carbohydrates != ""{
                    EatAndTime.shared.saveTask(amountOfCarbohydrates: carbohydrates, thenEating: selectedTopping.rawValue)
//                  //  elem.saveTask(viewContext: viewContext,
//                                  amountOfCarbohydrates: carbohydrates,
//                                  thenEating: selectedTopping.rawValue)

                }
                carbohydrates = ""
                showAnyView.toggle()
                showModal = false
                
                
                
            } label: {
                Text("Enter")
                    .foregroundColor(.white)
                    .font(.title)
            }
            .frame(width: 100, height: 50)
            .background(.blue)
            .cornerRadius(20)

        }
        .onTapGesture {
            self.endEditing()
        }
        .background(.white)
    }
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct AddNewEatingView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewEatingView(showAnyView: .constant(false), showModal: .constant(true))
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

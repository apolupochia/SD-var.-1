//
//  AddNewDimensionsView.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 20.06.2022.
//

import SwiftUI

struct AddNewDimensionsView: View {
    @Binding var showAnyView : Bool
    @Binding var newSug : String
    @State var insulin = ""
    @Binding var showModal : Bool
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    
    private var items: FetchedResults<DateOfMedicine>
    
    
    var body: some View {
        VStack{
            Spacer()
            Text("Ваш Сахар")
                .font(.largeTitle)
                .foregroundColor(.red)

            TextField("Сахар", text: $newSug )
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
            Spacer()

            Text("Введенное количество инсулина")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            TextField("Сахар", text: $insulin )
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
            Spacer()
            Button {
                showAnyView = true
                showModal = false
                addItem()
            } label: {
                Text("Enter")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .frame(width: 100 , height: 50)
            .background(.blue)
            .cornerRadius(20)
            
        }
        .onTapGesture {
            self.endEditing()
        }
       
        .background(.yellow)
     //   .ignoresSafeArea()
    }
    
    private func addItem(){
        if newSug != ""{
            SugAndTime.shared.saveTask(sugar: newSug, insulin: insulin)
        }
        newSug = ""
        
    }
    private func endEditing() {
            UIApplication.shared.endEditing()
        }
}

struct AddNewDimensionsView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewDimensionsView(showAnyView: .constant(false), newSug: .constant(""), showModal:.constant(false)
        )
    }
}

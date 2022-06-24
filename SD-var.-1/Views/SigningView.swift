//
//  SigningView.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 15.06.2022.
//

import SwiftUI
import RiveRuntime

struct SigningView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    )
    
    private var items: FetchedResults<InformationAboutUser>
    
    @State var name = ""
    @State var dateOfBirth = ""
    @State var city = ""
    @State var informationAboutPerson = ""
    @State var isLoading = false
    @Binding var showModal : Bool
    @Binding var showMain : Bool
    let confetti = RiveViewModel(fileName: "confetti", stateMachineName: "State Machine 1")
    
    let check = RiveViewModel(fileName: "check", stateMachineName: "State Machine 1")
    
    func logIn(){
        isLoading = true
        
        if name != "" {

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                try? check.triggerInput("Check")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
                try? confetti.triggerInput("Trigger explosion")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    //ContentView()
                    //showModal = false
                   // ContentView()
                   showMain = false
                    
                }
            
                
            }
            
            
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                try? check.triggerInput("Error")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
            }
        }
        
    }
    
    
    var body: some View {

        VStack(spacing: 24) {
            Text("Sing In")
                .customFont(.title)
            Text("Введите имя, дату рождения, город проживания и информацию о себе!")
                .customFont(.headline)
            

            VStack(alignment: .leading) {
                Text("Имя")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $name)
                    .customTextView(image: Image(systemName: "person"))

            }
            
            VStack(alignment: .leading) {
                Text("Дата рождения")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $dateOfBirth)
                //SecureField("", text: $dateOfBirth)
                    .customTextView(image:Image(systemName:"calendar"))

            }
            VStack(alignment: .leading) {
                Text("Город")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $city)
                    .customTextView(image: Image(systemName: "house.fill"))
            }
            VStack(alignment: .leading) {
                Text("Информация о вас")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $informationAboutPerson)
                    .customTextView(image: Image(systemName:"person.text.rectangle"))
                    
            }
            
            
            
            Button {
                logIn()
                save()
   
            } label : {
                Label("Sing In", systemImage: "arrow.right")
                    .customFont(.headline)
                    .padding(16)
                    .frame(maxWidth : .infinity)
                    .background(Color(hex: "F77D8E"))
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight ])
                    .cornerRadius(8, corners: [.topLeft])
                .shadow(color: Color(hex: "F77D8E").opacity(0.5), radius: 20, x: 0, y: 10)
            }
                
            
//            HStack {
//
//                Rectangle().frame( height: 1).opacity(0.1)
//
//                Text("OR")
//                    .customFont(.subheadline2)
//                .foregroundColor(.black.opacity(0.3))
//
//                Rectangle().frame( height: 1).opacity(0.1)
//            }
            
//            Divider()
//
//            Text("Sign up with Email, Apple, Google")
//                .customFont(.subheadline)
//                .foregroundColor(.secondary)
//            HStack{
//                Image("Logo Email")
//                Spacer()
//                Image("Logo Apple")
//                Spacer()
//                Image("Logo Google")
//            }
            
            
        }
        .padding(30)
        .background(.regularMaterial)
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 30)
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(.linearGradient(colors: [.white.opacity(0.8),.white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .padding()
        .overlay(
            ZStack{
                if isLoading{
                    check.view()
                        .frame(width: 100, height: 100)
                        .allowsHitTesting(false)
                }
                confetti.view()
                    .scaleEffect(3)
                    .allowsHitTesting(false)
            }
            
            
        )
            .onTapGesture {
                self.endEditing()
            }
        }
    
    private func save(){
        
        infAboutUser.shared.saveTask(city: city,
                                     dateOfBirth: dateOfBirth,
                                     infoUser: informationAboutPerson,
                                     name: name
                         )
        
        
//        let newItem = InformationAboutUser(context: viewContext)
//
//        newItem.name = name
//        newItem.infoUser = informationAboutPerson
//        newItem.dateOfBirth = dateOfBirth
//        newItem.city = city
//        newItem.registration = true
//
//        do{
//            try viewContext.save()
//        } catch{
//            print("error")
//        }
        
    }
    
    private func endEditing() {
            UIApplication.shared.endEditing()
        }
}

struct SigningView_Previews: PreviewProvider {
    static var previews: some View {
        SigningView(showModal: .constant(false), showMain: .constant(true))
    }
}

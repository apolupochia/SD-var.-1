//
//  OnBoardView.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 15.06.2022.
//

import SwiftUI
import RiveRuntime

struct OnBoardView: View {
    let button = RiveViewModel(fileName: "button")
    
    @State var showModal = false
    @Binding var showMain : Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    )
    
    private var items: FetchedResults<InformationAboutUser>
    
    var body: some View {
        
        ZStack{
            backgroundView()
            content(items: items)
                .offset(y: showModal ? -50 : 0 )
            
            Color("Shadow")
                .opacity(showModal ? 0.4 : 0)
                .ignoresSafeArea()
            
            if showModal{
                SigningView(showModal: $showModal, showMain: $showMain)
                    .transition(
                        .move(edge: .bottom)
                        .combined(with: .opacity)
                    )
                    .overlay(
                        Button {
                            withAnimation(.spring()){
                                showModal = false
                            }
                        } label:{ Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.black)
                            .background(.white)
                            .mask(Circle())
                            .shadow(color: Color("Shadow").opacity(0.3), radius: 6, x: 0, y: 3)
                        }
                            .frame(maxHeight : .infinity, alignment: .bottom)
                            
                    )
                    .zIndex(1)
                    
                        
            }
        
        }.previewInterfaceOrientation(.portrait)
    }
        
    
    
    
    
    
    
    
    
    func content(items: FetchedResults<InformationAboutUser>) -> some View{
        
        VStack(alignment: .leading, spacing: 16) {
            Text("Learn desing & code")
                .font(.custom("Poppins Bolt", size: 60, relativeTo: .largeTitle))
                .frame(width: 260,alignment: .leading)
            Text("Dont't skip desing.")
                .customFont(.body)
            
            Spacer()
            
            button.view()
                .frame(width: 236, height: 64)
                .overlay(
                    Label("Start the course", systemImage: "arrow.forward")
                        .offset(x: 4, y: 4)
                        .font(.headline)
             )
                .background(
                    Color.black
                        .cornerRadius(30)
                        .blur(radius: 10)
                        .opacity(0.3)
                        .offset( y: 10)
                        
                )
                .onTapGesture {
                   // let registration = infAboutUser(items: items)
                    let registrationBool = infAboutUser.shared.aboutRegistration()
                    
                   // try?
                    button.play(animationName: "active")
                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + 0.8) {
                            withAnimation(.spring()){
                                if !registrationBool == false{
                                    showMain = !registrationBool
                                }
                                else{
                                    showModal = true
                                }
                            }
                            
                        }
            }
        }
        .padding(40)
        .padding(.top, 40)
    }
    
}

struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardView(showMain: .constant(true))
    }
}

struct backgroundView: View {
    var body: some View {
        RiveViewModel(fileName: "shapes").view()
            .ignoresSafeArea()
            .blur(radius: 10)
            .background(
                Image("Spline")
                    .blur(radius: 50)
                    .offset(x: 200, y: 100)
            )
    }
}

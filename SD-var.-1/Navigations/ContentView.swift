//
//  ContentView.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 15.06.2022.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    @State var selectedTab : Tab = .chat
    @State var isOpen = false
    @State var show = false
    @State var showAnyView = true
    @State var showSafeAreaTop = true
    @State var showMoreInf = true
    let button = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoPlay: false)
    var body: some View {
        ZStack {
            Color("Background 2").ignoresSafeArea()
            SideMenu()
                .opacity(isOpen ? 1 : 0)
                .offset(x : isOpen ? 0 : 300)
                .rotation3DEffect(.degrees(isOpen ? 0 : 30), axis: (x: 0 , y: 1, z: 0))
            
            Group{
                
                switch selectedTab {
                case .chat:
                    HomeView()
                case .search:
                    View___InformationFood()
                    
                case .timer:
                    View___HistoryInformationCard(showAnyView: $showAnyView)
                        .background(.white)
                case .bell:
                    View_SugInfCard(showAnyView: $showAnyView)
                case .user:
                    ViewControllerRepresentation()
                        .ignoresSafeArea()
                    
                }
            }
            
            .safeAreaInset(edge: .bottom) {         // чтобы выдвигалось подальше снизу
                Color.clear.frame(height: 80)
            }
                .safeAreaInset(edge: .top) {
                    Color.clear.frame(height: 104)
                }
            
            .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0 , y: -1, z: 0))
            .mask(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
            )
            .offset(x: isOpen ? 265 : 0)
            .scaleEffect(isOpen ? 0.9 : 1)
            .ignoresSafeArea()
         
            
            
            if showAnyView{
                if showMoreInf{
//                Image(systemName: "person")
//                    .frame(width: 36, height: 36)
//                    .background(.white)
//                    .mask(Circle())
//                    .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing )
//                    .padding()
//                    .offset(y:4)
//                    .offset(x: isOpen ? 100 : 0)
//                    .onTapGesture {
//                        withAnimation(.spring()){
//                            show = true
//                        }
//                    }
                button.view()
                    .frame(width: 44, height: 44)
                    .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding()
                    .offset(x : isOpen ? 216 : 0)
                    .onTapGesture {
                       // try?
                        button.setInput("isOpen", value: isOpen)
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)){
                            isOpen.toggle()
                        }
                        
                    }
                
                    .onChange(of: isOpen) { newValue in
                        if newValue{
                            UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)

                        } else {
                            UIApplication.shared.setStatusBarStyle(.darkContent, animated: true)
                        }
                    }
                }
               
                
                TabBar(showMoreInf: $showMoreInf, selectedTab: $selectedTab)
                    .offset(y: isOpen ? 300 : 0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}

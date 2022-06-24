////
////  PersonInformation.swift
////  SD-var.-1
////
////  Created by Алёша Виноградов on 22.06.2022.
////
//
//import Foundation
//import SwiftUI
//
//struct labelName : UIViewRepresentable{
//    @Binding var name : String
//
//    
//    func makeUIView(context: Context) -> UILabel {
//        let label = UILabel()
//        return label
//    }
//    func updateUIView(_ uiView: UILabel, context: Context) {
//        uiView.text = name
//    }
//}
//
//extension labelName{
//    class Coordinator : NSObject{
//        @Binding var name : String
//        init(name : Binding<String>) {
//            self._name = name
//        }
//        
//        @objc func nameChanged(_ sender : UILabel){
//            name = sender.text!
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(name: $name)
//    }
//}
//
//
//struct labelName_PreeViews: PreviewProvider{
//    static var previews: some View{
//        labelName(name: .constant("123"))
//    }
//}

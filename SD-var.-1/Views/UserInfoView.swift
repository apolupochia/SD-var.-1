//
//  UserInfoView.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 18.06.2022.
//





//  пока не используется

import SwiftUI

struct UserInfoView: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .frame(alignment: .leading)
                Spacer()
                VStack(alignment: .leading){
                    Text("Алексей")
                        .font(.headline)
                    Text("Виноградов")
                        .font(.headline)
                    Text("30.03.2000")
                        .font(.headline)
                }
                
                Spacer()
            }
            Text("email")
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Город")
                .frame(maxWidth: .infinity, alignment: .leading)
               // .padding(.vertical, 16)
            Text("Город")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 16)
            Text("Город")
                .frame(maxWidth: .infinity, alignment: .leading)
              //  .padding(.vertical, 16)
            Spacer()
        }
        
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#FFFFE0"))
       
       
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}

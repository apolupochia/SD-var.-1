//
//  CustomTextField.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 15.06.2022.
//

import SwiftUI

struct CustomTextField: ViewModifier {
    
    var image: Image
    
    func body(content: Content) -> some View {
        content
            .padding(15)
            .padding(.leading, 36)
            .background(.white)
            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke()
                .fill(.black.opacity(0.1))
            )
            .overlay(
                image
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading,8)
        )
    }
}

extension View{
    func customTextView(image : Image = Image("Icon Email")) -> some View{
        modifier(CustomTextField(image: image))
    }
}

//
//  VCard.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 15.06.2022.
//

import SwiftUI

struct VCard: View {
    var course : Course
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(course.title)
                .customFont(.title)
                .frame(maxWidth: 170, alignment: .leading)
                .layoutPriority(1)
                .fixedSize(horizontal: false, vertical: true)
            Text(course.subtitle)
                .customFont(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()
            HStack {
                ForEach(Array([1,2,3].shuffled().enumerated()), id: \.offset) { index, number in
                    Image("\(course.name) \(number)")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .mask(Circle())
                        .offset(x: CGFloat(index * 20))
                }
            }
            
        }
        .foregroundColor(.white)
        .padding(30)
        .frame(width: 260, height: 280)
        .background(.linearGradient(colors: [course.color, course.color.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: course.color.opacity(0.3), radius: 8, x: 0, y: 12)
        .shadow(color: course.color.opacity(0.3), radius: 2, x: 0, y: 1)
        .overlay(
            
            course.timeOfDay
            //course.image
               
                .resizable()
                .frame(width: 55, height: 55)
                .mask(Circle())
                
                .frame( maxWidth: .infinity ,maxHeight: .infinity, alignment: .topTrailing)
            
                .padding(20)
        )
        
    }
}

struct VCard_Previews: PreviewProvider {
    static var previews: some View {
        VCard(course: courses[2])
    }
}

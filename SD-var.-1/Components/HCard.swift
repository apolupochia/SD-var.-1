//
//  HCard.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 15.06.2022.
//

import SwiftUI

struct HCard: View {
    var section : CourseSection
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8 ) {
                Text(section.title)
                    .customFont(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(section.caption)
                    .customFont(.body)
                    .fixedSize(horizontal: false, vertical: true)
                
            }
            Divider()
            section.image
                .frame(width: 60, height: 60)
                
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: 110)
        .background(section.color)
        .foregroundColor(.white)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        
        
    }
}

struct HCard_Previews: PreviewProvider {
    static var previews: some View {
        HCard(section: courseSections[1])
    }
}

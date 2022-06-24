
import SwiftUI

struct FoodInformationCard: View {
    var foodsInf : FoodInformation
    var body: some View {
        HStack{
            VStack{
                Text("\(foodsInf.name)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                Text("Углеводы на 100г : \(foodsInf.carbohydrates)")
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
            }
            Divider()
                
            foodsInf.image
                .resizable()
                .frame(width: 80 , height: 80)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight : 100)
        .background(Color(hex: "\(foodsInf.color)"))
        .foregroundColor(.white)
        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
        
    }
        
    
}

struct FoodInformationCard_Previews: PreviewProvider {
    static var previews: some View {
        FoodInformationCard(foodsInf: foods[0])
    }
}

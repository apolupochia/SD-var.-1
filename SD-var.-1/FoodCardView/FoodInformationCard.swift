
import SwiftUI

struct FoodInformationCard: View {
    var foodsInf : FoodInformation
    
    @ObservedObject var foodUrlImage = FoodUrlImage()
    
    var placeholder : Image
    
    init(placeholder : Image = Image(systemName: "photo")){
        self.foodsInf = foods[0]
        self.placeholder = placeholder
        foodUrlImage.fetchImage()
    }

    var body: some View {
        HStack{
            VStack{
                //Text("\(foodsInf.name)")
                Text("Название блюда")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
              //  Text("Углеводы на 100г : \(foodsInf.carbohydrates)")
                Text("Энергитическая ценность")
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
            }
            Divider()
                
            //foodsInf.image
            if let image = foodUrlImage.downloadImage{
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 80 , height: 80)
            } else {
                placeholder
                    .resizable()
                    .frame(width: 80 , height: 80)
            }
//            Image(uiImage: FoodUrlImage.shared.$downloadImage)

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
        FoodInformationCard()
      //  FoodInformationCard(foodsInf: foods[0])
    }
}

//
//  FoodUrlImages.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 19.07.2022.
//

import Foundation
import SwiftUI
import Combine

struct ImageTo :  Decodable{
    let image : String
}

class FoodUrlImage : ObservableObject {

    @Published var downloadImage : UIImage?

    let stringUrl = "https://foodish-api.herokuapp.com/api/"

    static let shared = FoodUrlImage()

     func fetchImage()  {

        guard let url = URL(string: stringUrl) else { return  }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else{
                print(error?.localizedDescription ?? "noDesc")
                return
            }
            guard let data = data else {
                return
            }

            guard let imageInf = try? JSONDecoder().decode(ImageTo.self, from: data) else {
                print("Error")
                return
            }
            self.imageCard(url: imageInf.image)
        }.resume()


    }
    private func imageCard(url : String)  {

      //  var image : Image = Image(systemName: "person")

        guard let url = URL(string: url) else {return }


        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }

            if let response = response {
                print(response)
            }

            if let data = data, let imageUI = UIImage(data: data) {
                // let image = Image(uiImage: imageUI)
                DispatchQueue.main.async {
                    self.downloadImage = imageUI
                }
            }

        }.resume()

    }


}

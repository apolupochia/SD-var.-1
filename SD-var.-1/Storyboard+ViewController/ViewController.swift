//
//  ViewController.swift
//  forSD
//
//  Created by Алёша Виноградов on 22.06.2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    private var viewContext = PersistenceController.shared.container.viewContext
    
    var item : [InformationAboutUser] = []

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var dateOfBirthView: UILabel!
    @IBOutlet weak var cityView: UILabel!
    @IBOutlet weak var aboutMeView: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        startSettings()
    }
    private func fetchData(){
        
        item = DataManagerForPerson.shared.fetchTasks()
        
    }
    
    private func startSettings(){
       // imageView.image = UIImage(systemName: "person")
        imageView.image = UIImage(named: "daytime")
        
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        textLabel.textColor = UIColor.black
        
        if item == []{
            nameView.text = ""
            dateOfBirthView.text = ""
            cityView.text =  ""
            aboutMeView.text =  ""
        } else {
            nameView.text = item[0].name
            dateOfBirthView.text = item[0].dateOfBirth
            cityView.text = item[0].city
            aboutMeView.text = item[0].infoUser
        }
        nameView.textColor = UIColor.black
        dateOfBirthView.textColor = UIColor.black
        cityView.textColor = UIColor.black
        aboutMeView.textColor = UIColor.black
        
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        DataManagerForPerson.shared.deleteTask()
    }
    
}

struct ViewControllerRepresentation: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    
        
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentation()
            .ignoresSafeArea()
    }
}

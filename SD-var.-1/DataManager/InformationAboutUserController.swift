//
//  SecretInformationAboutPerson.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 22.06.2022.
//

import SwiftUI
import CoreData

protocol DataManagerProtocolForInformationAboutUser{
    func saveTask(city: String, dateOfBirth: String, infoUser : String, name: String)
    mutating func addInform() -> secretInformation
    func aboutRegistration() -> Bool
}


struct infAboutUser : DataManagerProtocolForInformationAboutUser{
    
  
    private var viewContext = PersistenceController.shared.container.viewContext

    static let shared = infAboutUser()
    
    func saveTask( city: String, dateOfBirth: String, infoUser : String, name: String){

        let newItem = InformationAboutUser(context: viewContext)
            
        newItem.name = name
        newItem.infoUser = infoUser
        newItem.dateOfBirth = dateOfBirth
        newItem.city = city
        newItem.registration = true
    
        do{
            try viewContext.save()
        } catch{
            print("error")
        }
    }

    
    func addInform() -> secretInformation{
        
        
        
        var items : [InformationAboutUser] = []
        
        let fetchRequest: NSFetchRequest<InformationAboutUser> = InformationAboutUser.fetchRequest()
    
        
        do {
            
            items = try viewContext.fetch(fetchRequest)
            
        } catch let error {
            print(error)
        }
        
        
        
        
        var information = secretInformation(name: "", dateOfBirth: "", city: "", infoUser: "", registration: false)
        
        
        for item in items{
            information.city = item.city ?? ""
            information.name = item.name ?? ""
            information.infoUser = item.infoUser ?? ""
            information.dateOfBirth = item.dateOfBirth ?? ""
            information.registration = item.registration
       }
        return information
    }
    
     func aboutRegistration() -> Bool{
         
//         var items : [InformationAboutUser] = []
//
//         let fetchRequest: NSFetchRequest<InformationAboutUser> = InformationAboutUser.fetchRequest()
//
//
//         do {
//
//             items = try viewContext.fetch(fetchRequest)
//
//         } catch let error {
//             print(error)
//         }
         
         let items = getItems()
         
         var registration = false
         for item in items{
             registration = item.registration
         }

       return registration
    }
    
    
    
    private func getItems() -> [InformationAboutUser]{
        var items : [InformationAboutUser] = []
        
        let fetchRequest: NSFetchRequest<InformationAboutUser> = InformationAboutUser.fetchRequest()

        
        do {
            
            items = try viewContext.fetch(fetchRequest)
            
        } catch let error {
            print(error)
        }
        return items
    }
}









struct secretInformation{
    var name : String
    var dateOfBirth: String
    var city : String
    var infoUser : String
    var registration : Bool
}

struct registrationUser{
    var registration : Bool = false
}



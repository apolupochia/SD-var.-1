

import Foundation
import UIKit
import CoreData


protocol DataManagerProtocolForComplited{
    func saveTask(city: String, dateOfBirth: String, infoUser : String, name: String)
    func fetchTasks() -> [InformationAboutUser]
    func deleteTask()
}


struct DataManagerForPerson : DataManagerProtocolForComplited{


    private var context = PersistenceController.shared.container.viewContext
    
    static let shared = DataManagerForPerson()
    
    func saveTask(city: String, dateOfBirth: String, infoUser : String, name: String){

        guard let entityDescription = NSEntityDescription.entity(forEntityName: "InformationAboutUser", in: context) else {return}
        guard let newItem = NSManagedObject(entity: entityDescription, insertInto: context) as? InformationAboutUser else {return}

        newItem.city = city
        newItem.dateOfBirth = dateOfBirth
        newItem.infoUser = infoUser
        newItem.name = name

        if context.hasChanges{
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
        

    }
    
    func fetchTasks() -> [InformationAboutUser] {
        
        var item : [InformationAboutUser] = []
        do {
            let fetchRequest: NSFetchRequest<InformationAboutUser> = InformationAboutUser.fetchRequest()
            item = try context.fetch(fetchRequest)
            
        } catch let error {
            print(error)
        }
        return item
        
    }
    
    
    func deleteTask()  {

        let fetchRequest: NSFetchRequest<InformationAboutUser> = InformationAboutUser.fetchRequest()
        do {
            let newItem = try context.fetch(fetchRequest)

            context.delete(newItem[0] as NSManagedObject)
            try context.save()

        } catch let error {
            print(error)
        }

    }
       
}

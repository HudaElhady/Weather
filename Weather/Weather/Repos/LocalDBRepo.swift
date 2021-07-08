//
//  LocalDBRepo.swift
//  Weather
//
//  Created by huda elhady on 08/07/2021.
//

import UIKit
import CoreData

protocol LocalDBRepo {
    func saveCities(citiesList: [HomeCity])
    func getCities(completionHandler: @escaping (Result<[HomeCity],NetworkError>)->Void)
    func deleteAllCities()
}

class LocalDBRepoImpl: LocalDBRepo {
    
    func getCities(completionHandler: @escaping (Result<[HomeCity],NetworkError>)->Void) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "City")
          
          do {
            let data = try managedContext.fetch(fetchRequest)
            let cities:[HomeCity] = data.map{
                HomeCity(name: $0.value(forKey: "name") as! String, lat: $0.value(forKey: "lat") as! Double, long: $0.value(forKey: "long") as! Double)
            }
            completionHandler(.success(cities))
          } catch let error as NSError {
            completionHandler(.failure(.unknown))
            print("Could not fetch. \(error), \(error.userInfo)")
          }
    }
    
    func saveCities(citiesList: [HomeCity]) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        for city in citiesList {
            let newCity = NSEntityDescription.insertNewObject(forEntityName: "City", into: context)
            newCity.setValue(city.name, forKey: "name")
            newCity.setValue(city.lat, forKey: "lat")
            newCity.setValue(city.long, forKey: "long")
        }
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func deleteAllCities() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "City")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
            print("Error saving: \(error)")
        }
    }
    
}

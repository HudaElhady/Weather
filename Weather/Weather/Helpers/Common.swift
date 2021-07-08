//
//  Common.swift
//  Weather
//
//  Created by huda elhady on 08/07/2021.
//

import UIKit
import CoreData

class CommonClass {
    
    static var sharedInstance = CommonClass()
    private var citiesList = [HomeCity]()
    private let localDBRepo = LocalDBRepoImpl()
    
    func updateHomeCities(list: [HomeCity]) {
        citiesList = list
    }
        
    func saveData(){
            var backgroundTaskID = UIApplication.shared.beginBackgroundTask (withName: "CoreDataTask") {
                UIApplication.shared.endBackgroundTask(backgroundTaskID)
                backgroundTaskID = UIBackgroundTaskIdentifier.invalid
            }
            self.localDBRepo.saveCities(citiesList: self.citiesList)
            UIApplication.shared.endBackgroundTask(backgroundTaskID)
            backgroundTaskID = UIBackgroundTaskIdentifier.invalid
    }
}

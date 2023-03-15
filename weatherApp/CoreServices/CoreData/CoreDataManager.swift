//
//  CoreDataManager.swift
//  weatherApp
//
//  Created by Khaled Bohout on 14/03/2023.
//

import CoreData

final class CoreDataManager {

    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        return managedObjectModel
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        return persistentStoreCoordinator
    }()

    func getAllCities() throws -> [City]{
        let request = CityCoreDataEntity.fetchRequest()
        let cities = try managedObjectContext.fetch(request)
        return cities.map { city in
            let weather = city.weatherInfo as! Set<WeatherInfoCoreDataEntity>
            return City(weatherInfo: weather.map({ weatherCoreData in
                WeatherInfo(windSpeed: weatherCoreData.windSpeed, WeatherDescription: weatherCoreData.weatherDescription ?? "", temp: weatherCoreData.temp, humidity: weatherCoreData.humidity)
            }))
        }
    }

    func update(id: UUID, city: City) throws -> (){
        let cityCoreDataEntity = try getEntityById(id)
//        todoCoreDataEntity.is_completed = todo.isCompleted
//        todoCoreDataEntity.title = todo.title
        saveContext()
    }

    func create(todo: City) throws -> (){
        let todoCoreDataEntity = CityCoreDataEntity(context: managedObjectContext)
//        todoCoreDataEntity.is_completed = todo.isCompleted
//        todoCoreDataEntity.title = todo.title
//        todoCoreDataEntity.id = todo.id
        saveContext()
    }

    private func getEntityById(_ id: UUID)  throws  -> CityCoreDataEntity?{
        let request = CityCoreDataEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "id = %@", id.uuidString)
        let cityCoreDataEntity = try managedObjectContext.fetch(request)[0]
        return cityCoreDataEntity

    }

    private func saveContext(){
        if managedObjectContext.hasChanges {
            do{
                try managedObjectContext.save()
            }catch{
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }

}

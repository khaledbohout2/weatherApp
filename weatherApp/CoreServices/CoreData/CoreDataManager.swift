//
//  CoreDataManager.swift
//  weatherApp
//
//  Created by Khaled Bohout on 14/03/2023.
//

import CoreData
import Combine

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

    func getAllCities() throws -> AnyPublisher<[City], Error>{
        let request = CityCoreDataEntity.fetchRequest()
        let cities = try managedObjectContext.fetch(request)
        do {
            let citiesArr = cities.map { city in
                let weather = city.weatherInfo as! Set<WeatherInfoCoreDataEntity>
                return City(name: city.name ?? "", weatherInfo: weather.map({ weatherCoreData in
                    WeatherInfo(windSpeed: Int(weatherCoreData.windSpeed), WeatherDescription: weatherCoreData.weatherDescription ?? "", temp: Int(weatherCoreData.temp), humidity: Int(weatherCoreData.humidity), iconID: weatherCoreData.iconID ?? "", date: weatherCoreData.date ?? "")
                }))
            }
            return Just(citiesArr).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }

    func update(city: City) throws -> (){
        do {
            let cityCoreDataEntity = try getEntityByName(city.name)
            if cityCoreDataEntity != nil {
                for weather in city.weatherInfo {
                    let weatherCoreData = WeatherInfoCoreDataEntity(context: managedObjectContext)
                    weatherCoreData.date = weather.date
                    weatherCoreData.temp = Int16(weather.temp)
                    weatherCoreData.iconID = weather.iconID
                    weatherCoreData.humidity = Int16(weather.humidity)
                    weatherCoreData.weatherDescription = weather.WeatherDescription
                    weatherCoreData.windSpeed = Int16(weather.windSpeed)
                    cityCoreDataEntity?.addToWeatherInfo(weatherCoreData)
                    saveContext()
                }
            } else {
                try create(city: city)
            }
        }
    }

    func create(city: City) throws -> (){
        let cityCoreDataEntity = CityCoreDataEntity(context: managedObjectContext)
        cityCoreDataEntity.name = city.name
        var weatherInfoSet = Set<WeatherInfoCoreDataEntity>()
        for weather in city.weatherInfo {
            let weatherCoreData = WeatherInfoCoreDataEntity(context: managedObjectContext)
            weatherCoreData.date = weather.date
            weatherCoreData.temp = Int16(weather.temp)
            weatherCoreData.iconID = weather.iconID
            weatherCoreData.humidity = Int16(weather.humidity)
            weatherCoreData.weatherDescription = weather.WeatherDescription
            weatherCoreData.windSpeed = Int16(weather.windSpeed)
            weatherInfoSet.insert(weatherCoreData)
        }
        cityCoreDataEntity.weatherInfo = weatherInfoSet as NSSet
        saveContext()
    }

    private func getEntityByName(_ name: String) throws  -> CityCoreDataEntity?{
        let request = CityCoreDataEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "name = %@", name)
        let cityCoreDataEntity = try managedObjectContext.fetch(request)
        if cityCoreDataEntity.count > 0 {
            return cityCoreDataEntity[0]
        } else {
            return nil
        }
    }

    func getCityHistory(cityName: String) -> AnyPublisher<[WeatherInfo], Error> {
        do {
            let city = try getEntityByName(cityName)
            let weather = city?.weatherInfo as! Set<WeatherInfoCoreDataEntity>
            let weatherArr = weather.map { weather in
                WeatherInfo(windSpeed: Int(weather.windSpeed), WeatherDescription: weather.weatherDescription ?? "", temp: Int(weather.temp), humidity: Int(weather.temp), iconID: weather.iconID ?? "", date: weather.date ?? "")
            }
            print(weatherArr.count)
            return Just(weatherArr).setFailureType(to: Error.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: CityHistoryVCViewModelError.weathersFetch)
                .eraseToAnyPublisher()
        }
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

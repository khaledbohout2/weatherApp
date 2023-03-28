//
//  CityCoreDataEntity+CoreDataProperties.swift
//  
//
//  Created by Khaled Bohout on 15/03/2023.
//
//

import Foundation
import CoreData


extension CityCoreDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityCoreDataEntity> {
        return NSFetchRequest<CityCoreDataEntity>(entityName: "CityCoreDataEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var weatherInfo: Set<WeatherInfoCoreDataEntity>?

}

// MARK: Generated accessors for weatherInfo
extension CityCoreDataEntity {

    @objc(addWeatherInfoObject:)
    @NSManaged public func addToWeatherInfo(_ value: WeatherInfoCoreDataEntity)

    @objc(removeWeatherInfoObject:)
    @NSManaged public func removeFromWeatherInfo(_ value: WeatherInfoCoreDataEntity)

    @objc(addWeatherInfo:)
    @NSManaged public func addToWeatherInfo(_ values: Set<WeatherInfoCoreDataEntity>)

    @objc(removeWeatherInfo:)
    @NSManaged public func removeFromWeatherInfo(_ values: Set<WeatherInfoCoreDataEntity>)

}

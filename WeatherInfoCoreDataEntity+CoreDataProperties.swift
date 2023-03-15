//
//  WeatherInfoCoreDataEntity+CoreDataProperties.swift
//  
//
//  Created by Khaled Bohout on 15/03/2023.
//
//

import Foundation
import CoreData


extension WeatherInfoCoreDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherInfoCoreDataEntity> {
        return NSFetchRequest<WeatherInfoCoreDataEntity>(entityName: "WeatherInfoCoreDataEntity")
    }

    @NSManaged public var humidity: Double
    @NSManaged public var temp: Double
    @NSManaged public var weatherDescription: String?
    @NSManaged public var windSpeed: String?

}

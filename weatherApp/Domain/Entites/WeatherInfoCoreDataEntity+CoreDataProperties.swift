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

    @NSManaged public var date: String?
    @NSManaged public var humidity: Int16
    @NSManaged public var iconID: String?
    @NSManaged public var temp: Int16
    @NSManaged public var weatherDescription: String?
    @NSManaged public var windSpeed: Int16
    @NSManaged public var city: CityCoreDataEntity?

}

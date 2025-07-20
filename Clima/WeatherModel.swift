//
//  WeatherModel.swift
//  Clima
//
//  Created by Harshaan Yadav on 19/07/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    

    // Computed property to get a string like "Clear", "Rain", etc.
    var conditionName: String {
        switch conditionId {
        case 200 ..< 300:
            return "cloud.bolt.fill"
        case 300 ..< 400:
            return "cloud.drizzle.fill"
        case 500 ..< 600:
            return "cloud.heavyrain.fill"
        case 600 ..< 700:
            return "snowflake"
        case 700 ..< 800:
            return "environments"
        case 800:
            return "sun.min.fill"
        case 801 ..< 810:
            return "cloud.fill"
        default:
            return "camera.metering.unknown"
        }
    }

    // Optional: Rounded temperature string
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }

}

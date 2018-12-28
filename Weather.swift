//
//  Weather.swift
//  Atelier
//
//  Created by Fujia Ren on 6/7/18.
//  Copyright © 2018 Fujia Ren. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Weather {
    var name: String
    var temp: Float
    var pressure: Int
    var humidity: Int
    var temp_min: Float
    var temp_max: Float
    var windSpeed: Float
    var main: String
    var description: String
    var sunrise: Int
    var sunset: Int
    
    init (name: String, temp: Float, pressure: Int, humidity: Int, temp_min: Float, temp_max: Float, windSpeed: Float, main: String, description: String, sunrise: Int, sunset: Int){
        self.name = name
        self.temp = temp
        self.pressure = pressure
        self.humidity = humidity
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.windSpeed = windSpeed
        self.main = main
        self.description = description
        self.sunrise = sunrise
        self.sunset = sunset
    }
    init(from json: JSON) {
        self.name = json["name"].stringValue
        self.temp = json["main"]["temp"].floatValue
        self.pressure = json["main"]["pressure"].intValue
        self.humidity = json["main"]["humidity"].intValue
        self.temp_min = json["main"]["temp_min"].floatValue
        self.temp_max = json["main"]["temp_max"].floatValue
        self.windSpeed = json["wind"]["speed"].floatValue
        let weath = json["weather"].arrayValue
        let weathMain = weath[0]
        self.main = weathMain["main"].stringValue
        self.description = weathMain["description"].stringValue
        self.sunrise = json["sys"]["sunrise"].intValue
        self.sunset = json["sys"]["sunset"].intValue
        
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}

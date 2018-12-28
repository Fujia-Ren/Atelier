//
//  Network.swift
//  Atelier
//
//  Created by Fujia Ren on 6/6/18.
//  Copyright © 2018 Fujia Ren. All rights reserved.
//
/*import Foundation

import Alamofire
import SwiftyJSON

class Network {
    
    private let base = "http://api.openweathermap.org/data/2.5/weather"
    private let key = "d6b68e836281d3d9eea63a151d8e6244"

    func getConditions(city: String) {

        
        let requestURL = URL(string: "\(base)?q=\(city)&appID=\(key)")!
        Alamofire.request(requestURL).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let json):
                let json = JSON(json)
                print("Raw data:\n\(response.result)\n")
                //let substitute = ViewController()
                //substitute.temp = Weather(from: json).temp
                print(Weather(from: json).temp)
                Variables.VariableMana.shared_temp = Double(Weather(from: json).temp)
                print(Variables.shared_temp)
            case .failure(let error):
                print("[Network] Error:", error)

                
            }
            
        
    }
        
}
}*/

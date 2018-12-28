//
//  DetailNavController.swift
//  Atelier
//
//  Created by Fujia Ren on 6/8/18.
//  Copyright © 2018 Fujia Ren. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class DetailNavController: UIViewController {
    
    var disTemp: UILabel!
    var disDescription: UILabel!
    var disPressure: UILabel!
    var disHumidity: UILabel!
    var disMinTemp: UILabel!
    var disMaxTemp: UILabel!
    var disWindSpeed: UILabel!
    var disSunrise: UILabel!
    var disSunset: UILabel!
    
    var backButton: UIButton!
    
    var backGes: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let base = "http://api.openweathermap.org/data/2.5/weather"
        let key = "d6b68e836281d3d9eea63a151d8e6244"
        let city = "Secaucus"
        let requestURL = URL(string: "\(base)?q=\(city)&appID=\(key)")!
        Alamofire.request(requestURL).validate().responseJSON { (response) in
            switch response.result {
            case .success(let json):
                let json = JSON(json)
                print(Weather(from: json).main)
                print("Raw data:\n\(response.result)\n")
                print(Weather(from: json).temp)
                
                self.disTemp.text = ViewController().KelvinToFahrenheit(Kelvin: Weather(from: json).temp)
                self.disDescription.text = Weather(from: json).description
                self.disPressure.text = "Pressure: " + String(Weather(from: json).pressure) + " atm"
                self.disHumidity.text = "Humidity: " + String(Weather(from: json).humidity) + "%"
                self.disMinTemp.text = "Lowest Temp:" + ViewController().KelvinToFahrenheit(Kelvin: Weather(from: json).temp_min)
                self.disMaxTemp.text = "Highest Temp:" + ViewController().KelvinToFahrenheit(Kelvin: Weather(from: json).temp_max)
                self.disWindSpeed.text = "Wind Speed: " + String(Weather(from: json).windSpeed) + " m/s"
                
              
                
            case .failure(let error):
                print("[Network] Error:", error)
            }
        }

        
        let circ = UIView(frame: CGRect(x: 62.5, y: 40.0, width: 250.0, height: 250.0))
        circ.layer.cornerRadius = 125
        circ.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        
        let line = UIView(frame: CGRect(x: 70.0, y: 350.0, width: 1, height: 200))
        line.backgroundColor = .white
        
        let backgroundI = UIImageView(frame: UIScreen.main.bounds)
        backgroundI.image = UIImage(named: "dark")
        backgroundI.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundI, at: 0)
        self.navigationController?.isNavigationBarHidden = true
        
        disTemp = UILabel()
        disTemp.textColor = .white
        disTemp.translatesAutoresizingMaskIntoConstraints = false
        disTemp.font = UIFont(name: "Avenir-Light", size: 70)
        
        disDescription = UILabel()
        disDescription.textColor = .white
        disDescription.translatesAutoresizingMaskIntoConstraints = false
        disDescription.font = UIFont(name: "Avenir-Light", size: 25)
        
        disPressure = UILabel()
        disPressure.textColor = .white
        disPressure.translatesAutoresizingMaskIntoConstraints = false
        disPressure.font = UIFont(name: "Avenir-Light", size: 20)
        
        disHumidity = UILabel()
        disHumidity.textColor = .white
        disHumidity.translatesAutoresizingMaskIntoConstraints = false
        disHumidity.font = UIFont(name: "Avenir-Light", size: 20)
        
        disMinTemp = UILabel()
        disMinTemp.textColor = .white
        disMinTemp.translatesAutoresizingMaskIntoConstraints = false
        disMinTemp.font = UIFont(name: "Avenir-Light", size: 20)
        
        disMaxTemp = UILabel()
        disMaxTemp.textColor = .white
        disMaxTemp.translatesAutoresizingMaskIntoConstraints = false
        disMaxTemp.font = UIFont(name: "Avenir-Light", size: 20)
        
        disWindSpeed = UILabel()
        disWindSpeed.textColor = .white
        disWindSpeed.translatesAutoresizingMaskIntoConstraints = false
        disWindSpeed.font = UIFont(name: "Avenir-Light", size: 20)
        
        backButton = UIButton(type: .roundedRect)
        backButton.setTitle("             <        ", for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitleColor( .white, for: .normal)
        backButton.layer.cornerRadius = 50
        backButton.backgroundColor = UIColor(red: 0.941, green: 0.20, blue: 0.20, alpha: 0.0)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.showsTouchWhenHighlighted = true
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.white.cgColor
        backButton.reversesTitleShadowWhenHighlighted = true
        backButton.titleLabel?.font = UIFont(name: "Avenir-Light", size: 18)
        
        view.addSubview(circ)
        view.addSubview(disTemp)
        view.addSubview(disDescription)
        view.addSubview(disPressure)
        view.addSubview(disHumidity)
        view.addSubview(disMinTemp)
        view.addSubview(disMaxTemp)
        view.addSubview(disWindSpeed)
        view.addSubview(line)
        view.addSubview(backButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            disTemp.topAnchor.constraint(equalTo: view.topAnchor, constant: 102),
            disTemp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
        NSLayoutConstraint.activate([
            disDescription.topAnchor.constraint(equalTo: disTemp.bottomAnchor, constant: -12),
            disDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
        NSLayoutConstraint.activate([
            disPressure.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -42),
            disPressure.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            ])
        NSLayoutConstraint.activate([
            disHumidity.topAnchor.constraint(equalTo: disPressure.bottomAnchor, constant: 9),
            disHumidity.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            ])
        NSLayoutConstraint.activate([
            disMinTemp.topAnchor.constraint(equalTo: disHumidity.bottomAnchor, constant: 9),
            disMinTemp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            ])
        NSLayoutConstraint.activate([
            disMaxTemp.topAnchor.constraint(equalTo: disMinTemp.bottomAnchor, constant: 9),
            disMaxTemp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            ])
        NSLayoutConstraint.activate([
            disWindSpeed.topAnchor.constraint(equalTo: disMaxTemp.bottomAnchor, constant: 9),
            disWindSpeed.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            ])
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: disMinTemp.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -45)
            ])
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func backButtonPressed(sender: UIButton) {
        if self != navigationController?.viewControllers.first {
            navigationController?.popViewController(animated: true)
        } else {            
            dismiss(animated: true)
        }
    }
}

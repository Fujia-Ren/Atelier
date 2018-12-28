//
//  ViewController.swift
//  Atelier
//
//  Created by Fujia Ren on 6/5/18.
//  Copyright © 2018 Fujia Ren. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {//
    //  ViewController.swift
    //  Atelier
    //
    //  Created by Fujia Ren on 6/5/18.
    //  Copyright © 2018 Fujia Ren. All rights reserved.
    //
    
    import Foundation
    import UIKit
    import Alamofire
    import SwiftyJSON
    
    class ViewController: UIViewController {
        
        var dStamp: UILabel!
        var tStamp: UILabel!
        var mTitle: UILabel!
        var weatherStamp: UILabel!
        var conditions: UILabel!
        var weatherLink: UIButton!
        var scheduleLink: UIButton!
        var notesLink: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let base = "http://api.openweathermap.org/data/2.5/weather"
            let key = "d6b68e836281d3d9eea63a151d8e6244"
            let city = "Ithaca"
            let requestURL = URL(string: "\(base)?q=\(city)&appID=\(key)")!
            Alamofire.request(requestURL).validate().responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    let json = JSON(json)
                    
                    let eTemp = self.KelvinToFahrenheit(Kelvin: Weather(from: json).temp)
                    self.weatherStamp.text = eTemp
                    
                    let eMain = Weather(from: json).main
                    self.conditions.text = eMain
                    
                case .failure(let error):
                    print("[Network] Error:", error)
                }
            }
            
            let date = DateFormatter()
            date.timeStyle = .none
            date.dateStyle = .medium
            
            let time = DateFormatter()
            time.timeStyle = .short
            time.dateStyle = .none
            
            let dString = date.string(from: Date() as Date)
            let tString = time.string(from: Date() as Date)
            
            dStamp = UILabel()
            dStamp.text = String(dString)
            dStamp.textColor = .white
            dStamp.translatesAutoresizingMaskIntoConstraints = false
            dStamp.font = UIFont(name: "Avenir-Light", size: 25)
            
            tStamp = UILabel()
            tStamp.text = String(tString)
            tStamp.textColor = .white
            tStamp.translatesAutoresizingMaskIntoConstraints = false
            tStamp.font = UIFont(name: "Avenir-Light", size: 20)
            
            mTitle = UILabel()
            mTitle.text = "Atelier"
            mTitle.textColor = .white
            mTitle.translatesAutoresizingMaskIntoConstraints = false
            mTitle.font = UIFont(name: "Zapfino", size: 60)
            
            weatherStamp = UILabel()
            //weatherStamp.text = "\(Variables.VariableMana.shared_temp)"
            weatherStamp.textColor = .white
            weatherStamp.translatesAutoresizingMaskIntoConstraints = false
            weatherStamp.font = UIFont(name: "Avenir-Light", size: 60)
            
            conditions = UILabel()
            //conditions.text = main
            conditions.textColor = .white
            conditions.translatesAutoresizingMaskIntoConstraints = false
            conditions.font = UIFont(name: "Avenir-Light", size: 25)
            
            weatherLink = UIButton(type: .roundedRect)
            weatherLink.setTitle("          Weather Details     ", for: .normal)
            weatherLink.translatesAutoresizingMaskIntoConstraints = false
            weatherLink.setTitleColor( .white, for: .normal)
            weatherLink.layer.cornerRadius = 50
            weatherLink.backgroundColor = UIColor(red: 0.941, green: 0.20, blue: 0.20, alpha: 0.4)
            weatherLink.addTarget(self, action: #selector(detailsLinkPressed), for: .touchUpInside)
            weatherLink.showsTouchWhenHighlighted = true
            weatherLink.layer.borderWidth = 1
            weatherLink.layer.borderColor = UIColor.white.cgColor
            weatherLink.reversesTitleShadowWhenHighlighted = true
            weatherLink.titleLabel?.font = UIFont(name: "Avenir-Light", size: 22)
            
            scheduleLink = UIButton(type: .roundedRect)
            scheduleLink.setTitle("          To-do list                   ", for: .normal)
            scheduleLink.translatesAutoresizingMaskIntoConstraints = false
            scheduleLink.setTitleColor( .white, for: .normal)
            scheduleLink.layer.cornerRadius = 50
            scheduleLink.backgroundColor = UIColor(red: 0.922, green: 0.584, blue: 0.196, alpha: 0.4)
            scheduleLink.addTarget(self, action: #selector(todoLinkPressed), for: .touchUpInside)
            scheduleLink.showsTouchWhenHighlighted = true
            scheduleLink.layer.borderColor = UIColor.white.cgColor
            scheduleLink.layer.borderWidth = 1
            scheduleLink.reversesTitleShadowWhenHighlighted = true
            scheduleLink.titleLabel?.font = UIFont(name: "Avenir-Light", size: 22)
            
            let circ = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
            circ.center = self.view.center
            circ.layer.cornerRadius = 100
            circ.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
            
            view.addSubview(mTitle)
            view.addSubview(tStamp)
            view.addSubview(dStamp)
            view.addSubview(weatherStamp)
            view.addSubview(conditions)
            view.addSubview(circ)
            view.addSubview(weatherLink)
            view.addSubview(scheduleLink)
            
            let mark = tString.index(tString.endIndex, offsetBy: -7)
            let hour = tString[...mark]
            let nHour = Int(hour)
            
            let Mmark = tString.index(tString.endIndex, offsetBy: -2)
            let mm = tString[Mmark...]
            
            if nHour! >= 7 && mm == "PM" || nHour! < 6 && mm == "AM" {
                
                let bImage = UIImageView(frame: UIScreen.main.bounds)
                bImage.image = UIImage(named: "Ima")
                UIView.animate(withDuration: 3, delay: 0.25, options: [.autoreverse, .repeat], animations: {
                    bImage.frame.origin.x -= 20
                })
                bImage.contentMode = UIViewContentMode.scaleAspectFill
                self.view.insertSubview(bImage, at: 0)
                self.navigationController?.isNavigationBarHidden = true
            }
            else if nHour! == 6 {
                let bImage = UIImageView(frame: UIScreen.main.bounds)
                bImage.image = UIImage(named: "sun")
                bImage.contentMode = UIViewContentMode.scaleAspectFill
                self.view.insertSubview(bImage, at: 0)
                self.navigationController?.isNavigationBarHidden = true
            }
            else {
                let bImage = UIImageView(frame: UIScreen.main.bounds)
                bImage.image = UIImage(named: "lily")
                UIView.animate(withDuration: 3, delay: 0.25, options: [.autoreverse, .repeat], animations: {
                    bImage.frame.origin.x -= 20
                })
                bImage.contentMode = UIViewContentMode.scaleAspectFill
                self.view.insertSubview(bImage, at: 0)
                self.navigationController?.isNavigationBarHidden = true
            }
            
            
            setupConstraints()
            
        }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate([
                mTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
                mTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                ])
            NSLayoutConstraint.activate([
                tStamp.topAnchor.constraint(equalTo: mTitle.bottomAnchor, constant: -65),
                tStamp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                ])
            NSLayoutConstraint.activate([
                dStamp.topAnchor.constraint(equalTo: tStamp.bottomAnchor, constant: 10),
                dStamp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                ])
            NSLayoutConstraint.activate([
                weatherStamp.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                weatherStamp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                ])
            NSLayoutConstraint.activate([
                conditions.topAnchor.constraint(equalTo: weatherStamp.bottomAnchor, constant: -7),
                conditions.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                ])
            NSLayoutConstraint.activate([
                weatherLink.topAnchor.constraint(equalTo: conditions.bottomAnchor, constant: 65),
                weatherLink.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -45),
                ])
            NSLayoutConstraint.activate([
                scheduleLink.topAnchor.constraint(equalTo: weatherLink.bottomAnchor, constant: -1),
                scheduleLink.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -45)
                ])
        }
        
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func KelvinToCelsius (Kelvin: Float) -> String {
            let final = Kelvin - 273.15
            let Final = " " + String(final) + "°"
            return Final
        }
        
        func KelvinToFahrenheit (Kelvin: Float) -> String {
            let final = Kelvin * 9/5 - 459.67
            if final - Float(0.5) >= Float(Int(final)) {
                let fina = Int(final) + 1
                let Final = " " + String(fina) + "°"
                return Final
            } else {
                let fina = Int(final)
                let Final = " " + String(fina) + "°"
                return Final
            }
            
        }
        @objc func detailsLinkPressed(sender: UIButton) {
            let modVC = DetailNavController()
            navigationController?.pushViewController(modVC, animated: true)
        }
        
        @objc func todoLinkPressed(sender: UIButton) {
            let newvc = TodoViewController()
            navigationController?.pushViewController(newvc, animated: true)
        }
    }
    

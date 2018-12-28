//
//  TodoViewController.swift
//  Atelier
//
//  Created by Fujia Ren on 8/22/18.
//  Copyright © 2018 Fujia Ren. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class TodoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var todo: UILabel!
    var aList: UITextField!
    var times: [UILabel]!
    var aTimes: Array<String> = Array()
    var collectionView: UICollectionView!
    let reuseCell = "resuseCollectionViewCell"
    let insetConstant: CGFloat = -10.0
    let reuseHeader = "reuseHeaderView"
    var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To-Do List"
        let bImage = UIImageView(frame: UIScreen.main.bounds)
        bImage.image = UIImage(named: "butterfly")
        bImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(bImage, at: 0)
        self.navigationController?.isNavigationBarHidden = true

        todo = UILabel()
        todo.text = "Todo List"
        todo.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        todo.translatesAutoresizingMaskIntoConstraints = false
        todo.font = UIFont(name: "Avenir-Light", size: 50)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TodoCollectionViewCell.self, forCellWithReuseIdentifier: reuseCell)
        
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeader)
        
        backButton = UIButton(type: .roundedRect)
        backButton.setTitle("         >                 ", for: .normal)
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
        

        
        //view.addSubview(circ)
        view.addSubview(collectionView)
        view.addSubview(backButton)
        
        setupConstraints()
}
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50),
            backButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 98)
            ])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCell, for: indexPath) as! TodoCollectionViewCell
        var hour = 0
        var counter = 1
        while counter < 25{
            if counter > 11 && counter != 12 && counter != 24 {
                hour = counter - 12
                counter += 1
                aTimes.append(String(hour) + ":00" + " PM")
            }
            else if counter == 12 {
                aTimes.append(String(counter) + ":00" + " PM")
                counter += 1
            }
                
            else if counter == 24 {
                hour = 12
                aTimes.append(String(hour) + ":00" + " AM")
                counter += 1
            }
            else{
                hour = counter
                counter += 1
                aTimes.append(String(hour) + ":00" + " AM")
            }
        }
       
        cell.timeLabel.text = aTimes[indexPath.item]
        if indexPath.item < 8 {
            cell.backgroundColor = UIColor(hue: 0.6944, saturation: CGFloat(1-(Double(indexPath.item)) * 0.07), brightness: 1, alpha: 0.4)
        }
        else if indexPath.item > 15 {
            cell.backgroundColor = UIColor(hue: 0.6944, saturation: CGFloat(1-(Double(indexPath.item-14)) * 0.07), brightness: 1, alpha: 0.4)
        }
        else {
        cell.backgroundColor = UIColor(hue: 0.6944, saturation: CGFloat((Double(indexPath.item)) * 0.07), brightness: 1, alpha: 0.4)
        }
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 90)
}
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeader, for: indexPath) as! HeaderCollectionReusableView
        if kind == UICollectionElementKindSectionHeader {
            view.titleLabel.text = "      Schedule"
        }
        view.setNeedsUpdateConstraints()
        return view
    }
    @objc func backButtonPressed(sender: UIButton) {
            navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 150, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //UIEdgeInset object is a way to telling to view how to add "padding" to its view.
        //It tells the rectangle how to shrink/expand the area represented by the rectangle.
        return UIEdgeInsetsMake(insetConstant, 0, 0, insetConstant)
    }
}

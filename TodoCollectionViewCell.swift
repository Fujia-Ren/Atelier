//
//  TodoCollectionViewCell.swift
//  Atelier
//
//  Created by Fujia Ren on 9/2/18.
//  Copyright © 2018 Fujia Ren. All rights reserved.
//

import Foundation
import UIKit

class TodoCollectionViewCell: UICollectionViewCell {
    
    var timeLabel: UILabel!
    var taskTitle: UILabel!
    var task: UITextField!
    var taskType: UILabel!
    var check: UIButton!
    var back: UIButton!
    var details: UITextField!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        timeLabel = UILabel()
        timeLabel.font = UIFont(name: "Avenir-Light", size: 20)
        timeLabel.textColor = .white
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        check = UIButton()
        check.titleLabel?.font = UIFont(name: "Avenir-Light", size: 22)
        check.setTitle("✓", for: .normal)
        check.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        check.translatesAutoresizingMaskIntoConstraints = false
        check.addTarget(self, action: #selector(checkPressed), for: .touchUpInside)
        check.translatesAutoresizingMaskIntoConstraints = false
        
        task = UITextField()
        task.textColor = .white
        task.font = UIFont(name: "Avenir-Light", size: 22)
        task.returnKeyType = .done
        task.placeholder = ">"
        task.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        task.translatesAutoresizingMaskIntoConstraints = false
        
        
        details = UITextField()
        details.textColor = .white
        details.font = UIFont(name: "Avenir-Light", size: 14)
        details.returnKeyType = .done
        details.placeholder = "With Who? Where?"
        details.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        details.translatesAutoresizingMaskIntoConstraints = false
        
        
        let circ = UIView(frame: CGRect(x: -20.0, y: 9.00, width: 75.0, height: 75.0))
        circ.layer.cornerRadius = 36.5
        circ.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(circ)
        contentView.addSubview(check)
        contentView.addSubview(task)
        contentView.addSubview(details)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ])
        NSLayoutConstraint.activate([
            check.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            check.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            ])
        NSLayoutConstraint.activate([
            task.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            task.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 15),
        ])
        NSLayoutConstraint.activate([
            details.topAnchor.constraint(equalTo: task.bottomAnchor),
            details.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 15),
            ])
        
        super.updateConstraints()
    }
    
    @objc func checkPressed(sender: UIButton) {
        task.text = "<"
        details.text = ">"
    }
    
}

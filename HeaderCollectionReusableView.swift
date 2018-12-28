//
//  HeaderCollectionReusableView.swift
//  Atelier
//
//  Created by Fujia Ren on 9/3/18.
//  Copyright © 2018 Fujia Ren. All rights reserved.
//

import Foundation
import UIKit

//Subclassing a header view
class HeaderCollectionReusableView: UICollectionReusableView {
    
    var titleLabel: UILabel!
    var backButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel()
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Avenir-Light", size: 50)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        

        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20)
            ])
        

        super.updateConstraints()
    }

    
}

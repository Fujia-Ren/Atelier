//
//  Variables.swift
//  Atelier
//
//  Created by Fujia Ren on 6/8/18.
//  Copyright © 2018 Fujia Ren. All rights reserved.
//

import Foundation

class Variables {
    public var shared_temp: Double = 0.000
    
    class var VariableMana: Variables {
        struct Static {
            static let instance = Variables()
        }
        return Static.instance
    }
}

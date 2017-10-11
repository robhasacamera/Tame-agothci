//
//  Lion.swift
//  Tame-agothci
//
//  Created by Robert J Cole on 9/26/17.
//  Copyright © 2017 Robert Cole. All rights reserved.
//

import Foundation

public struct Lion {
    var hunger: Int
    var happiness: Int
    var level: Int
    public init (hunger: Int, happiness: Int){
        level = 1
        self.hunger = hunger
        self.happiness = happiness
    }
}

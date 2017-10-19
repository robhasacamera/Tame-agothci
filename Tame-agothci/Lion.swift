//
//  Lion.swift
//  Tame-agothci
//
//  Created by Robert J Cole on 9/26/17.
//  Copyright © 2017 Robert Cole. All rights reserved.
//

import Foundation

public class Lion {
    var hunger: Int {
        didSet {
            if hunger > 100 {
                hunger = 100
            } else if hunger < 0 {
                hunger = 0
            }
        }
    }
    var happiness: Int {
        didSet {
            if happiness < 0 {
                happiness = 0
            } else if happiness > 100 {
                happiness = 100
            }
        }
    }
    var level: Int
    public init (hunger: Int, happiness: Int){
        level = 1
        self.hunger = hunger
        self.happiness = happiness
    }
}

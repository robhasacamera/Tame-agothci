//
//  LionDataSource.swift
//  Tame-agotchi
//
//  Created by Dan Wilson on 12/20/17.
//  Copyright © 2017 Robert Cole. All rights reserved.
//

import Foundation

class LionDataSource {

    let defaults = UserDefaults.standard
    
    var lion: Lion
    
    var hunger: Int {
        get {
            return lion.hunger
        }
        set {
            lion.hunger = newValue
            defaults.set(lion.hunger, forKey: "savedLionHunger")
        }
    }
    
    var happiness: Int {
        get {
            return lion.happiness
        }
        set {
            lion.happiness = newValue
            defaults.set(lion.happiness, forKey: "savedLionHappiness")
        }
    }
    
    var level: Int {
        get {
            return lion.level
        }
        set {
            lion.level = newValue
            defaults.set(lion.level, forKey: "savedLionLevel")
        }
    }

    public init() {
        
        var happiness = 10
        var hunger = 30
        var level = 1
        
        if let lionHappiness = defaults.object(forKey: "savedLionHappiness") as? Int {
            happiness = lionHappiness
        }
        if let lionHunger = defaults.object(forKey: "savedLionHunger") as? Int {
            hunger = lionHunger
        }
        if let lionLevel = defaults.object(forKey: "savedLionLevel") as? Int {
            level = lionLevel
        }
        
        lion = Lion(hunger: hunger, happiness: happiness)
        lion.level = level
    }

}

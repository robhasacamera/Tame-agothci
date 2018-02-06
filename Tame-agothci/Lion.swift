//
//  Lion.swift
//  Tame-agotchi
//
//  Created by Robert J Cole on 9/26/17.
//  Copyright © 2017 Robert Cole. All rights reserved.
//

import Foundation

public class Lion {
    static let lionDidUpdateNotification = Notification.Name("lionDidUpdateNotification")
    
    let notificationCenter = NotificationCenter.default
    
    var hunger: Int {
        didSet {
            if hunger > 100 {
                hunger = 100
            } else if hunger < 0 {
                hunger = 0
            }
            
            notificationCenter.post(name: Lion.lionDidUpdateNotification, object: self)
        }
    }
    
    var happiness: Int {
        didSet {
            if happiness < 0 {
                happiness = 0
            } else if happiness > 100 {
                happiness = 100
            }
            notificationCenter.post(name: Lion.lionDidUpdateNotification, object: self)
        }
    }
    
    var level: Int {
        didSet {
            notificationCenter.post(name: Lion.lionDidUpdateNotification, object: self)
        }
    }
    
    public init (hunger: Int, happiness: Int){
        level = 1
        self.hunger = hunger
        self.happiness = happiness
    }
}

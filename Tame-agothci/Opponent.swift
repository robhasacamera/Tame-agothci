//
//  Opponent.swift
//  Tame-agotchi
//
//  Created by Robert J Cole on 10/11/17.
//  Copyright © 2017 Robert Cole. All rights reserved.
//

import Foundation

struct Opponent {
    var correctGuessPercentage: Double
    var trainerName: String
    var lionName: String
    var imageName: String
    
    public func hoopGuess() -> Bool {
        let precision = 1000
        
        let randomNumber = Int(arc4random_uniform(UInt32(precision)) + 1) // 1, 2, 3...1000
        
        let guessUpperBounds = Int(correctGuessPercentage * Double(precision)) // .60 * 1000 = 600
        
        if randomNumber <= guessUpperBounds {
            return true
        }
        
        return false
    }
}

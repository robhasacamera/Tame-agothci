//
//  Opponent.swift
//  Tame-agothci
//
//  Created by Robert J Cole on 10/11/17.
//  Copyright © 2017 Robert Cole. All rights reserved.
//

import Foundation

struct Opponent {
    var correctGuessPercentage: Double
    var trainerName: String
    var lionName: String
    
    public func hoopGuess() -> Bool {
        let numberOfHoops = 4
        
        let randomNumber = Int(arc4random_uniform(UInt32(numberOfHoops)) + 1) // 1, 2, 3, or 4
        
        let guessUpperBounds = Int(correctGuessPercentage * Double(numberOfHoops)) // 1, 2, 3
        
        if randomNumber >= guessUpperBounds {
            return true
        }
        
        return false
    }
}

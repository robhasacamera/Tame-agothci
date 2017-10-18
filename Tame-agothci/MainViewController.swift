//
//  ViewController.swift
//  Tame-agothci
//
//  Created by Robert J Cole on 9/26/17.
//  Copyright © 2017 Robert Cole. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var lastUpdateTime = Date()
    
    var timer: Timer?
    
    var lastTimeFed:    Date?
    var lastTimePet:    Date?
    var lastTimeCombed: Date?
    var lastTimePlayed: Date?
    var lastTimeHungry: Date?
    var appLaunchTime:  Date?
    var lastTimeUnhappy:  Date? //Cure? Morrissey? Joy Division?
    
    let feedInterval = 10.0
    let petInterval  = 10.0
    let combInterval = 20.0
    let playInterval = 45.0
    let initialHungerInterval = 60.0
    let reoccuringHungerInterval = 15.0
    let initialHappinessInterval = 90.0
    let recurringHappinessInterval = 15.0
    
    var lion = Lion(hunger: 30, happiness: 10)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        appLaunchTime = Date()
        
        updateProgressViews()
        
        print("\(appLaunchTime!): App Launched")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // todo START TIMER
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var feedButton: UIButton!
    
    @IBAction func feedButtonPressed(_ sender: Any) {
        feedButton.isEnabled = false
        lion.hunger -= 10
        lastTimeFed = Date()
        lastTimeHungry = nil
        print("\(Date()): Feed was pressed")
    }
    
    @IBOutlet weak var petButton: UIButton!
    
    @IBAction func petButtonPressed(_ sender: Any) {
        petButton.isEnabled = false
        lion.happiness += 5
        lastTimePet = Date()
        lastTimeUnhappy = nil
        print("\(Date()): Pet was pressed")
    }
    
    @IBOutlet weak var hungerProgressView: UIProgressView!
    @IBOutlet weak var happinessProgressView: UIProgressView!
    
    @IBOutlet weak var combButton: UIButton!
    
    @IBAction func combButtonPressed(_ sender: Any) {
        print("Comb was pressed")
        combButton.isEnabled = false
        lion.happiness += 10
        lastTimeCombed = Date()
        lastTimeUnhappy = nil
        print("\(Date()): Comb was pressed")
    }
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBAction func playButtonPressed(_ sender: Any) {
        print("Play was pressed")
        playButton.isEnabled = false
        lion.happiness += 15
        lastTimePlayed = Date()
        lastTimeUnhappy = nil
        print("\(Date()): Play was pressed")
    }
    
    @IBOutlet weak var hungerLabel: UILabel!
    @IBOutlet weak var happinessLabel: UILabel!
    
    
    @IBOutlet weak var trainButton: UIButton!
    
    @IBAction func trainButtonPressed(_ sender: Any) {
        print("Train was pressed")
        // FIX MEEEEEE
        //trainButton.isEnabled = false
        
    }
    @objc func update() {
        updateHunger()
        updateHappiness()
        updateFeedButton()
        updatePetButton()
        updateCombButton()
        updatePlayButton()
        updateTrainButton()
        updateProgressViews()
        
        lastUpdateTime = Date()
    }
    
    func updateHunger() {
        if let lastTimeHungry = lastTimeHungry {
            let timeSinceLastTimeHungry = -1 * lastTimeHungry.timeIntervalSinceNow
            if timeSinceLastTimeHungry >= reoccuringHungerInterval {
                lion.hunger += 5
                self.lastTimeHungry = Date()
                print("\(self.lastTimeHungry!): Updated hunger to \(lion.hunger)")
            }
        } else {
            if let lastTimeFed = lastTimeFed {
                let timeSinceLastFed = -1 * lastTimeFed.timeIntervalSinceNow
                if timeSinceLastFed >= initialHungerInterval {
                    lion.hunger += 5
                    lastTimeHungry = Date()
                    print("\(lastTimeHungry!): Updated hunger to \(lion.hunger)")
                }
            } else if let appLaunchTime = appLaunchTime {
                let timeSinceAppLaunch = -1 * appLaunchTime.timeIntervalSinceNow
                if timeSinceAppLaunch >= initialHungerInterval {
                    lion.hunger += 5
                    lastTimeHungry = Date()
                    print("\(lastTimeHungry!): Updated hunger to \(lion.hunger)")
                }
            }
        }
        
        if lion.hunger > 100 {
            lion.hunger = 100
        }
    }
    

    
    func updateHappiness() {
        
        if let lastTimeUnhappy = lastTimeUnhappy {
            let timeSinceLastTimeUnhappy = -1 * lastTimeUnhappy.timeIntervalSinceNow
            if timeSinceLastTimeUnhappy >= recurringHappinessInterval {
                lion.happiness -= 10
                self.lastTimeUnhappy = Date()
                print("\(self.lastTimeUnhappy!): Updated happiness to \(lion.happiness)")
            }
        } else {
            if let lastTimePet = lastTimePet {
                let timeSinceLastPet = -1 * lastTimePet.timeIntervalSinceNow
                if timeSinceLastPet >= initialHappinessInterval {
                    lion.happiness -= 10
                    lastTimeUnhappy = Date()
                    print("\(self.lastTimeUnhappy!): Updated happiness to \(lion.happiness)")
                }
            } else if let lastTimeCombed = lastTimeCombed {
                let timeSinceLastCombed = -1 * lastTimeCombed.timeIntervalSinceNow
                if timeSinceLastCombed >= initialHappinessInterval {
                    lion.happiness -= 10
                    lastTimeUnhappy = Date()
                    print("\(self.lastTimeUnhappy!): Updated happiness to \(lion.happiness)")
                }
                
            } else if let lastTimePlayed = lastTimePlayed {
                let timeSinceLastPlayed = -1 * lastTimePlayed.timeIntervalSinceNow
                if timeSinceLastPlayed >= initialHappinessInterval {
                    lion.happiness -= 10
                    lastTimeUnhappy = Date()
                    print("\(self.lastTimeUnhappy!): Updated happiness to \(lion.happiness)")
                }
                
            } else if let appLaunchTime = appLaunchTime {
                let timeSinceAppLaunch = -1 * appLaunchTime.timeIntervalSinceNow
                if timeSinceAppLaunch >= initialHappinessInterval {
                    lion.happiness -= 10
                    lastTimeUnhappy = Date()
                    print("\(self.lastTimeUnhappy!): Updated happiness to \(lion.happiness)")
                }
            }
        }
        
        if lion.happiness < 0 {
            lion.happiness = 0
        }
    }
    
    
    func updateProgressViews() {
        happinessProgressView.progress = Float(lion.happiness) / Float(100)
        happinessLabel.text = "Happiness: \(lion.happiness)"
        hungerProgressView.progress = Float(lion.hunger) / Float(100)
        hungerLabel.text = "Hunger: \(lion.hunger)"
    }
    
    func updateFeedButton() {
        if let lastTimeFed = lastTimeFed {
            let timeSinceLastFed = -1 * lastTimeFed.timeIntervalSinceNow
            if timeSinceLastFed >= feedInterval {
                feedButton.isEnabled = true
            }
        }
    }
    
    func updatePetButton() {
        if let lastTimePet = lastTimePet {
            let timeSinceLastPet = -1 * lastTimePet.timeIntervalSinceNow
            if timeSinceLastPet >= petInterval {
                petButton.isEnabled = true
            }
        }
    }
    
    func updateCombButton() {
        if let lastTimeCombed  = lastTimeCombed {
            let timeSinceLastCombed = -1 * lastTimeCombed.timeIntervalSinceNow
            if timeSinceLastCombed >= combInterval {
                combButton.isEnabled = true
            }
        }
    }
    
    func updatePlayButton() {
        if let lastTimePlayed = lastTimePlayed {
            let timeSinceLastPlayed = -1 * lastTimePlayed.timeIntervalSinceNow
            if timeSinceLastPlayed >= playInterval {
                playButton.isEnabled = true
            }
        }
    }
    
    func updateTrainButton() {
        if lion.hunger <= 20 && lion.happiness >= 80 {
            trainButton.isEnabled = true
        } else {
            // FIX MEE
            //trainButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Need to pass the lion data to the GameViewController
        if let gameController = segue.destination as? GameViewController {
            gameController.lion = lion
        }
    }
}


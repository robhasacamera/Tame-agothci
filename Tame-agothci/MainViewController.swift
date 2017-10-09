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
    var appLaunchTime: Date?
    
    let feedInterval = 10.0
    let petInterval  = 10.0
    let combInterval = 20.0
    let playInterval = 45.0
    
    var lion = Lion(hunger: 30, happiness: 10)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        appLaunchTime = Date()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var feedButton: UIButton!
    
    @IBAction func feedButtonPressed(_ sender: Any) {
        print("Feed was pressed")
        feedButton.isEnabled = false
        lion.hunger -= 10
        lastTimeFed = Date()
        lastTimeHungry = nil
    }
    
    @IBOutlet weak var petButton: UIButton!
    
    @IBAction func petButtonPressed(_ sender: Any) {
        print("Pet was pressed")
        petButton.isEnabled = false
        lion.happiness += 5
        lastTimePet = Date()
    }
    @IBOutlet weak var hungerProgressView: UIProgressView!
    @IBOutlet weak var happinessProgressView: UIProgressView!
    
    @IBOutlet weak var combButton: UIButton!
    
    @IBAction func combButtonPressed(_ sender: Any) {
        print("Comb was pressed")
        combButton.isEnabled = false
        lion.happiness += 10
        lastTimeCombed = Date()
    }
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBAction func playButtonPressed(_ sender: Any) {
        print("Play was pressed")
        playButton.isEnabled = false
        lion.happiness += 15
        lastTimePlayed = Date()
    }
    
    @IBOutlet weak var hungerLabel: UILabel!
    @IBOutlet weak var trainButton: UIButton!
    
    @IBAction func trainButtonPressed(_ sender: Any) {
        print("Train was pressed")
    }
    @objc func update() {
        updateHunger()
        updateFeedButton()
        updatePetButton()
        updateCombButton()
        updatePlayButton()
        updateProgressViews()
        let timeSinceLastUpdate = -1 * lastUpdateTime.timeIntervalSinceNow
        
        print("Last update was \(timeSinceLastUpdate) seconds ago.")
        
        lastUpdateTime = Date()
    }
    
    func updateHunger() {
        if let lastTimeHungry = lastTimeHungry {
            let timeSinceLastTimeHungry = -1 * lastTimeHungry.timeIntervalSinceNow
            if timeSinceLastTimeHungry >= 15.0 {
                lion.hunger += 5
                self.lastTimeHungry = Date()
            }
        } else {
            if let lastTimeFed = lastTimeFed {
                let timeSinceLastFed = -1 * lastTimeFed.timeIntervalSinceNow
                if timeSinceLastFed >= 60.0 {
                    lion.hunger += 5
                    lastTimeHungry = Date()
                }
            } else if let appLaunchTime = appLaunchTime {
                    let timeSinceAppLaunch = -1 * appLaunchTime.timeIntervalSinceNow
                    if timeSinceAppLaunch >= 60.0 {
                        lion.hunger += 5
                        lastTimeHungry = Date()
                    }
            }
        }
        
    }
    
    func updateProgressViews() {
        happinessProgressView.progress = Float(lion.happiness) / Float(100)
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
}


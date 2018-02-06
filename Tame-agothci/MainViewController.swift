//
//  ViewController.swift
//  Tame-agothci
//
//  Created by Robert J Cole on 9/26/17.
//  Copyright © 2017 Robert Cole. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    //Defined Variables
    var lion = Lion(hunger: 30, happiness: 10)
    
    var timer: Timer?
    var lastUpdateTime = Date()
    var appLaunchTime:  Date?
    
    var lastTimeFed:    Date?
    var lastTimePet:    Date?
    var lastTimeCombed: Date?
    var lastTimePlayed: Date?
    var lastTimeHungry: Date?
    var lastTimeUnhappy:  Date? //Cure? Morrissey? Joy Division?
    
    var feedInterval = 10.0
    var petInterval  = 10.0
    var combInterval = 20.0
    var playInterval = 45.0
    var initialHungerInterval = 60.0
    var reoccuringHungerInterval = 15.0
    var initialHappinessInterval = 90.0
    var recurringHappinessInterval = 15.0
    let notificationCenter = NotificationCenter.default
    
    //Views, Labels, and Buttons
    @IBOutlet weak var hungerProgressView: UIProgressView!
    @IBOutlet weak var happinessProgressView: UIProgressView!
    @IBOutlet weak var hungerLabel: UILabel!
    @IBOutlet weak var happinessLabel: UILabel!
    
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var petButton: UIButton!
    @IBOutlet weak var combButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var trainButton: UIButton!
    @IBOutlet weak var performButton: UIButton!
    @IBOutlet weak var lionImage: UIImageView!
    
    let defaults = UserDefaults.standard
    
    func saveLionHappiness() {
        defaults.set(lion.happiness, forKey: "savedLionHappiness")
    }
    
    func getLionHappiness() {
        if let lionHappiness = defaults.object(forKey: "savedLionHappiness") as? Int {
            lion.happiness = lionHappiness
        }
    }
    
    func saveLionHunger() {
        defaults.set(lion.hunger, forKey: "savedLionHunger")
    }
    
    func getLionHunger() {
        if let lionHunger = defaults.object(forKey: "savedLionHunger") as? Int {
            lion.hunger = lionHunger
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToNotification()
        getLionHunger()
        getLionHappiness()
        setupForDebug()
        subscribeToNotification()
    }
    
    func subscribeToNotification() {
        notificationCenter.addObserver(self, selector: #selector(lionDidUpdate), name: Lion.lionDidUpdateNotification, object: nil)
    }
    
    @objc func lionDidUpdate() {
        print("lion hunger = \(lion.hunger), happiness = \(lion.happiness)")
    }
    
    func subscribeToNotification() {
        notificationCenter.addObserver(self, selector: #selector(lionDidUpdate), name: Lion.lionDidUpdateNotification, object: nil)
    }
    
    @objc func lionDidUpdate() {
     print("lion hunger = \(lion.hunger), happpiness = \(lion.happiness)")
        updateProgressViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        appLaunchTime = Date()
        print("\(appLaunchTime!): App Launched")
        feedButton.isEnabled = true
        playButton.isEnabled = true
        combButton.isEnabled = true
        petButton.isEnabled = true
        
        if lion.level == 4 {
            trainButton.isHidden = true
            performButton.isHidden = false
        } else {
            trainButton.isHidden = false
            performButton.isHidden = true
        }
        
        lionImage.image = #imageLiteral(resourceName: "Lion-Main")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func update() {
        updateHunger()
        updateHappiness()
        updateFeedButton()
        updatePetButton()
        updateCombButton()
        updatePlayButton()
        updateTrainButton()
        
        lastUpdateTime = Date()
    }
    
    // Button Actions
    @IBAction func feedButtonPressed(_ sender: Any) {
        feedButton.isEnabled = false
        lion.hunger -= 10
        saveLionHunger()
        lastTimeFed = Date()
        lastTimeHungry = nil
        lionImage.image = #imageLiteral(resourceName: "Lion-feed")
        print("\(Date()): Feed was pressed")
    }
    
    @IBAction func petButtonPressed(_ sender: Any) {
        petButton.isEnabled = false
        lion.happiness += 5
        saveLionHappiness()
        lastTimePet = Date()
        lastTimeUnhappy = nil
        lionImage.image = #imageLiteral(resourceName: "Lion-pet")
        print("\(Date()): Pet was pressed")
    }
    
    @IBAction func combButtonPressed(_ sender: Any) {
        print("Comb was pressed")
        combButton.isEnabled = false
        lion.happiness += 10
        saveLionHappiness()
        lastTimeCombed = Date()
        lastTimeUnhappy = nil
        lionImage.image = #imageLiteral(resourceName: "Lion-comb")
        print("\(Date()): Comb was pressed")
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        print("Play was pressed")
        playButton.isEnabled = false
        lion.happiness += 15
        saveLionHappiness()
        lastTimePlayed = Date()
        lastTimeUnhappy = nil
        lionImage.image = #imageLiteral(resourceName: "Lion-play")
        print("\(Date()): Play was pressed")
    }
    
    @IBAction func trainButtonPressed(_ sender: Any) {
        print("Train was pressed")
        trainButton.isEnabled = false
    }
    
    //Update Buttons
    func updateHunger() {
        if let lastTimeHungry = lastTimeHungry {
            let timeSinceLastTimeHungry = -1 * lastTimeHungry.timeIntervalSinceNow
            if timeSinceLastTimeHungry >= reoccuringHungerInterval {
                lion.hunger += 5
                saveLionHunger()
                self.lastTimeHungry = Date()
                print("\(self.lastTimeHungry!): Updated hunger to \(lion.hunger)")
            }
        } else {
            if let lastTimeFed = lastTimeFed {
                let timeSinceLastFed = -1 * lastTimeFed.timeIntervalSinceNow
                if timeSinceLastFed >= initialHungerInterval {
                    lion.hunger += 5
                    saveLionHunger()
                    lastTimeHungry = Date()
                    print("\(lastTimeHungry!): Updated hunger to \(lion.hunger)")
                }
            } else if let appLaunchTime = appLaunchTime {
                let timeSinceAppLaunch = -1 * appLaunchTime.timeIntervalSinceNow
                if timeSinceAppLaunch >= initialHungerInterval {
                    lion.hunger += 5
                    saveLionHunger()
                    lastTimeHungry = Date()
                    print("\(lastTimeHungry!): Updated hunger to \(lion.hunger)")
                }
            }
        }
    }
    
    func updateHappiness() {
        
        if let lastTimeUnhappy = lastTimeUnhappy {
            let timeSinceLastTimeUnhappy = -1 * lastTimeUnhappy.timeIntervalSinceNow
            if timeSinceLastTimeUnhappy >= recurringHappinessInterval {
                lion.happiness -= 10
                saveLionHappiness()
                self.lastTimeUnhappy = Date()
                print("\(self.lastTimeUnhappy!): Updated happiness to \(lion.happiness)")
            }
        } else {
            if let lastTimePet = lastTimePet {
                let timeSinceLastPet = -1 * lastTimePet.timeIntervalSinceNow
                if timeSinceLastPet >= initialHappinessInterval {
                    lion.happiness -= 10
                    saveLionHappiness()
                    lastTimeUnhappy = Date()
                    print("\(self.lastTimeUnhappy!): Updated happiness to \(lion.happiness)")
                }
            } else if let lastTimeCombed = lastTimeCombed {
                let timeSinceLastCombed = -1 * lastTimeCombed.timeIntervalSinceNow
                if timeSinceLastCombed >= initialHappinessInterval {
                    lion.happiness -= 10
                    saveLionHappiness()
                    lastTimeUnhappy = Date()
                    print("\(self.lastTimeUnhappy!): Updated happiness to \(lion.happiness)")
                }
                
            } else if let lastTimePlayed = lastTimePlayed {
                let timeSinceLastPlayed = -1 * lastTimePlayed.timeIntervalSinceNow
                if timeSinceLastPlayed >= initialHappinessInterval {
                    lion.happiness -= 10
                    saveLionHappiness()
                    lastTimeUnhappy = Date()
                    print("\(self.lastTimeUnhappy!): Updated happiness to \(lion.happiness)")
                }
                
            } else if let appLaunchTime = appLaunchTime {
                let timeSinceAppLaunch = -1 * appLaunchTime.timeIntervalSinceNow
                if timeSinceAppLaunch >= initialHappinessInterval {
                    lion.happiness -= 10
                    saveLionHappiness()
                    lastTimeUnhappy = Date()
                    print("\(self.lastTimeUnhappy!): Updated happiness to \(lion.happiness)")
                }
            }
        }
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
            trainButton.isEnabled = false
        }
    }
    
    //Update Progress Views
    func updateProgressViews() {
        happinessProgressView.progress = Float(lion.happiness) / Float(100)
        happinessLabel.text = "Happiness: \(lion.happiness)"
        hungerProgressView.progress = Float(lion.hunger) / Float(100)
        hungerLabel.text = "Hunger: \(lion.hunger)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameController = segue.destination as? TrainingViewController {
            gameController.lion = lion
        }
        timer?.invalidate()
        timer = nil
        lastTimeFed = nil
        lastTimePet = nil
        lastTimeCombed = nil
        lastTimePlayed = nil
        lastTimeHungry = nil
        appLaunchTime = nil
        lastTimeUnhappy = nil
    }
    
    func setupForDebug() {
        let cheatPercentage = 0.1
        feedInterval = 10.0 * cheatPercentage
        petInterval  = 10.0 * cheatPercentage
        combInterval = 20.0 * cheatPercentage
        playInterval = 45.0 * cheatPercentage
        initialHungerInterval = 60.0 * cheatPercentage
        reoccuringHungerInterval = 15.0 * cheatPercentage
        initialHappinessInterval = 90.0 * cheatPercentage
        recurringHappinessInterval = 15.0 * cheatPercentage
     //   lion.level = 4
    }
}


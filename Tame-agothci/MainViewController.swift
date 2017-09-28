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
    
    var lastTimeFed: Date?
    
    let feedInterval = 10.0
    
    var lion = Lion(hunger: 70, happiness: 10)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var feedButton: UIButton!
    
    @IBAction func feedButtonPressed(_ sender: Any) {
        print("Feed was pressed")
        feedButton.isEnabled = false
        lion.hunger = lion.hunger - 10
        lastTimeFed = Date()
    }
    
    @IBOutlet weak var petButton: UIButton!
    
    @IBAction func petButtonPressed(_ sender: Any) {
        print("Pet was pressed")
    }
    
    @IBOutlet weak var combButton: UIButton!
    
    @IBAction func combButtonPressed(_ sender: Any) {
        print("Comb was pressed")
    }
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBAction func playButtonPressed(_ sender: Any) {
        print("Play was pressed")
    }
    
    @IBOutlet weak var trainButton: UIButton!
    
    @IBAction func trainButtonPressed(_ sender: Any) {
        print("Train was pressed")
    }
    @objc func update() {
        updateFeedButton()
        let timeSinceLastUpdate = -1 * lastUpdateTime.timeIntervalSinceNow
        
        print("Last update was \(timeSinceLastUpdate) seconds ago.")
        
        lastUpdateTime = Date()
    }
    
    func updateFeedButton() {
        if let lastTimeFed = lastTimeFed {
            let timeSinceLastFed = -1 * lastTimeFed.timeIntervalSinceNow
            if timeSinceLastFed >= feedInterval {
                feedButton.isEnabled = true
            }
        }
    }
}


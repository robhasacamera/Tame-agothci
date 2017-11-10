//
//  PerformViewController.swift
//  Tame-agothci
//
//  Created by Robert J Cole on 10/31/17.
//  Copyright © 2017 Robert Cole. All rights reserved.
//

import UIKit

class PerformViewController: UIViewController {

    var simonSaysActionSequence = [
        SimonSaysAction.balancingBall,
        SimonSaysAction.tightrope,
        SimonSaysAction.hoopJump,
        SimonSaysAction.platform
    ]
    var timer: Timer?
    
    @IBOutlet weak var hoopJumpButton: UIButton!
    @IBOutlet weak var platformButton: UIButton!
    @IBOutlet weak var tightropeButton: UIButton!
    @IBOutlet weak var balancingBallButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func hoopJumpButtonPressed(_ sender: Any) {
    }
    
    @IBAction func platformButtonPressed(_ sender: Any) {
    }
    
    @IBAction func tightropeButtonPressed(_ sender: Any) {
    }
    
    @IBAction func balancingBallButtonPressed(_ sender: Any) {
    }
    
    func playSequence() {
        // copy array
        let currentPlaySequence = simonSaysActionSequence
        
        // call recursive method with full array
        animateForAction(currentPlaySequence)
    }
    
    func randomLightSequence() {
        let performArea = Int(arc4random(UInt32(simonSaysActionSequence.count)))
        
        switch performArea {
        case 0:
            SimonSaysAction.balancingBall = true
        case 1:
            SimonSaysAction.hoopJump = true
        case 2:
            SimonSaysAction.platform = true
        case 3:
            SimonSaysAction.tightrope = true
            
        }
    }
    
    func animateForAction(_ actions: [SimonSaysAction]) {
        // pop the first action off the array
        var currentActions = actions
        let currentAction = currentActions.removeFirst()
        
        // use a switch to blink the button
        switch currentAction {
        case .balancingBall:
            balancingBallButton.alpha = 0.5
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(blink), userInfo: nil, repeats: false)
        case .hoopJump:
            hoopJumpButton.alpha = 0.5
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(blink), userInfo: nil, repeats: false)
        case .platform:
            platformButton.alpha = 0.5
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(blink), userInfo: nil, repeats: false)
        case .tightrope:
            tightropeButton.alpha = 0.5
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(blink), userInfo: nil, repeats: false)
        }
        
        // call this again with remaining array
        if currentActions.count > 0 {
            animateForAction(currentActions)
        } else {
            //do something later
        }
        
        
    }
    
    @objc func blink() {
        balancingBallButton.alpha = 1.0
        hoopJumpButton.alpha = 1.0
        platformButton.alpha = 1.0
        tightropeButton.alpha = 1.0
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        playSequence()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

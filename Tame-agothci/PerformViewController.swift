//
//  PerformViewController.swift
//  Tame-agothci
//
//  Created by Robert J Cole on 10/31/17.
//  Copyright © 2017 Robert Cole. All rights reserved.
//

import UIKit

class PerformViewController: UIViewController {
    
    var simonSaysActionSequence: [SimonSaysAction] = []
    var timer: Timer?
    var currentButtonPressed: SimonSaysAction?
    
    @IBOutlet weak var hoopJumpButton: UIButton!
    @IBOutlet weak var platformButton: UIButton!
    @IBOutlet weak var tightropeButton: UIButton!
    @IBOutlet weak var balancingBallButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func hoopJumpButtonPressed(_ sender: Any) {
        comparePressedActionToSequence(simonSaysActionSequence: simonSaysActionSequence, currentButtonPressed: SimonSaysAction.hoopJump)
    }
    
    @IBAction func platformButtonPressed(_ sender: Any) {
        comparePressedActionToSequence(simonSaysActionSequence: simonSaysActionSequence, currentButtonPressed: SimonSaysAction.platform)
    }
    
    @IBAction func tightropeButtonPressed(_ sender: Any) {
        comparePressedActionToSequence(simonSaysActionSequence: simonSaysActionSequence, currentButtonPressed: SimonSaysAction.tightrope)
    }
    
    @IBAction func balancingBallButtonPressed(_ sender: Any) {
        comparePressedActionToSequence(simonSaysActionSequence: simonSaysActionSequence, currentButtonPressed: SimonSaysAction.balancingBall)
    }
    
    func playSequence() {
        // copy array
        let currentPlaySequence = simonSaysActionSequence
        
        // call recursive method with full array
        animateForAction(currentPlaySequence)
    }
    
    func randomAction() -> SimonSaysAction {
        let performArea = Int(arc4random_uniform(UInt32(4)))
        var action: SimonSaysAction?
        
        switch performArea {
        case 0:
            action = SimonSaysAction.balancingBall
        case 1:
            action = SimonSaysAction.hoopJump
        case 2:
            action = SimonSaysAction.platform
        case 3:
            action = SimonSaysAction.tightrope
        default: print("Something seriously went wrong.")
            
        }
        return action!
    }
    
    func animateForAction(_ actions: [SimonSaysAction]) {
        // pop the first action off the array
        var currentActions = actions
        let currentAction = currentActions.removeFirst()
        
        // use a switch to blink the button
        switch currentAction {
        case .balancingBall:
            balancingBallButton.alpha = 0.5
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(blink), userInfo: currentActions, repeats: false)
        case .hoopJump:
            hoopJumpButton.alpha = 0.5
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(blink), userInfo: currentActions, repeats: false)
        case .platform:
            platformButton.alpha = 0.5
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(blink), userInfo: currentActions, repeats: false)
        case .tightrope:
            tightropeButton.alpha = 0.5
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(blink), userInfo: currentActions, repeats: false)
        }
        
    }
    
    func comparePressedActionToSequence(simonSaysActionSequence: [SimonSaysAction], currentButtonPressed: SimonSaysAction) {
        var currentSequence = simonSaysActionSequence
        let currentSequenceAction = currentSequence.removeFirst()
        
        if currentButtonPressed != currentSequenceAction {
            print("You didn't do as Simon said.  You lose. :P")
        } else {
            print("You pressed the right button!")
        }
        
    }
    
    @objc func animateForTimer(timer:Timer) {
        if let currentActions = timer.userInfo as? [SimonSaysAction] {
            animateForAction(currentActions)
        }
    }
    @objc func blink(timer:Timer) {
        balancingBallButton.alpha = 1.0
        hoopJumpButton.alpha = 1.0
        platformButton.alpha = 1.0
        tightropeButton.alpha = 1.0
        
        
        
        if let currentActions = timer.userInfo as? [SimonSaysAction] {
            if currentActions.count > 0 {
                _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(animateForTimer), userInfo: currentActions, repeats: false)
                
            } else {
                //do something later
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        simonSaysActionSequence.append(randomAction())
        simonSaysActionSequence.append(randomAction())
        simonSaysActionSequence.append(randomAction())
        simonSaysActionSequence.append(randomAction())
        
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

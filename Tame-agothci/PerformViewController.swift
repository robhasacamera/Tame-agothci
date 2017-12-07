//
//  PerformViewController.swift
//  Tame-agotchi
//
//  Created by Robert J Cole on 10/31/17.
//  Copyright © 2017 Robert Cole. All rights reserved.
//

import UIKit

class PerformViewController: UIViewController {
    
    var simonSaysActionSequence: [SimonSaysAction] = []
    var timer: Timer?
    var currentButtonPressed: SimonSaysAction?
    var playCounter = 0
    var performScore = 0
    var highScore: Int = 0
    let defaults = UserDefaults.standard
    
    func saveHighScore() {
        defaults.set(highScore, forKey: "savedHighScore")
    }
    
    func getHighScore() {
        highScore = defaults.integer(forKey: "savedHighScore")
    }
    
    @IBOutlet weak var hoopJumpButton: UIButton!
    @IBOutlet weak var platformButton: UIButton!
    @IBOutlet weak var tightropeButton: UIButton!
    @IBOutlet weak var balancingBallButton: UIButton!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func hoopJumpButtonPressed(_ sender: Any) {
        comparePressedActionToSequence(currentButtonPressed: SimonSaysAction.hoopJump)
    }
    
    @IBAction func platformButtonPressed(_ sender: Any) {
        comparePressedActionToSequence(currentButtonPressed: SimonSaysAction.platform)
    }
    
    @IBAction func tightropeButtonPressed(_ sender: Any) {
        comparePressedActionToSequence(currentButtonPressed: SimonSaysAction.tightrope)
    }
    
    @IBAction func balancingBallButtonPressed(_ sender: Any) {
        comparePressedActionToSequence(currentButtonPressed: SimonSaysAction.balancingBall)
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func playSequence() {
        // copy array
        hoopJumpButton.isEnabled = false
        platformButton.isEnabled = false
        tightropeButton.isEnabled = false
        balancingBallButton.isEnabled = false
        
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
    
    func comparePressedActionToSequence(currentButtonPressed: SimonSaysAction) {
        if playCounter < simonSaysActionSequence.count {
            let currentSequenceAction = simonSaysActionSequence[playCounter]
            if currentButtonPressed != currentSequenceAction {
                descriptionLabel.text = "You didn't do as Simon said.  You lose. You'll need to do some more training and try again."
                saveHighScore()
                // TODO: end the game
                //clear the sequence array
                simonSaysActionSequence.removeAll()
                
                //disable the buttons so they can't play
                hoopJumpButton.isEnabled = false
                platformButton.isEnabled = false
                tightropeButton.isEnabled = false
                balancingBallButton.isEnabled = false
                //go back to the main view controller
                doneButton.isEnabled = true
            } else {
                descriptionLabel.text = "You pressed the right button!"
                performScore += 10
                scoreLabel.text = "Score: \(performScore)"
                playCounter += 1
                if playCounter == simonSaysActionSequence.count {
                    descriptionLabel.text = "DUDE! You won! Now go eat a gazelle!"
                    performScore += 100
                    scoreLabel.text = "Score: \(performScore)"
                    playCounter = 0
                    simonSaysActionSequence.append(randomAction())
                    playSequence()
                    
                    // TODO: continue the game
                }
                compareHighScoreAndScore()
            }
        } else {
            print("Oops... You choked on an elephant tusk.")
        }
        
    }
    
    func compareHighScoreAndScore() {
        if highScore < performScore {
            highScore = performScore
            highScoreLabel.text = "High Score: \(highScore)"
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
                hoopJumpButton.isEnabled = true
                platformButton.isEnabled = true
                tightropeButton.isEnabled = true
                balancingBallButton.isEnabled = true
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.isEnabled = false
        getHighScore()
        highScoreLabel.text = "High Score: \(highScore)"
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

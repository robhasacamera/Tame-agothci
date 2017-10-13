//
//  GameViewController.swift
//  Tame-agothci
//
//  Created by Robert J Cole on 10/11/17.
//  Copyright © 2017 Robert Cole. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var lion: Lion?
    var opponents = [Opponent]()
    var selectedOpponent: Opponent?
    var playerScore = 0
    var opponentScore = 0
    var currentRound = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        opponents.append(Opponent(correctGuessPercentage: 0.25, trainerName: "Ralph Newbie", lionName: "Hairball"))
        opponents.append(Opponent(correctGuessPercentage: 0.50, trainerName: "Larry \"Scar\" Henderson", lionName: "Ghost"))
        opponents.append(Opponent(correctGuessPercentage: 0.75, trainerName: "Leo Lionel", lionName: "Mr. Purrfect"))
        // Do any additional setup after loading the view.
        
        if let lion = lion {
            selectedOpponent = opponents[(lion.level-1)]
        }
        if let selectedOpponent = selectedOpponent {
            let opponentName = selectedOpponent.trainerName
            let opponentLionName = selectedOpponent.lionName
            opponentNameLabel.text = "\(opponentLionName) trained by \(opponentName)"
            opponentScoreLabel.text = "Score: \(opponentScore)"
            playerScoreLabel.text = "Score: \(playerScore)"
            roundLevelLabel.text = "Round \(currentRound)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hoop1Pressed(_ sender: Any) {
    }
    
    @IBAction func hoop2Pressed(_ sender: Any) {
    }
   
    @IBAction func hoop3Pressed(_ sender: Any) {
    }
    
    @IBAction func hoop4Pressed(_ sender: Any) {
    }
    
    @IBOutlet weak var roundLevelLabel: UILabel!
    
    @IBOutlet weak var playerScoreLabel: UILabel!
    
    @IBOutlet weak var opponentNameLabel: UILabel!
    
    @IBOutlet weak var opponentScoreLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

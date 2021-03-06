//
//  GameViewController.swift
//  Tame-agotchi
//
//  Created by Robert J Cole on 10/11/17.
//  Copyright © 2017 Robert Cole. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {
    var lion: Lion?
    var opponents = [Opponent]()
    var selectedOpponent: Opponent?
    var playerScore = 0 {
        didSet {
           playerScoreLabel.text = "Score: \(playerScore)"
        }
    }
    var opponentScore = 0 {
        didSet {
            opponentScoreLabel.text = "Score: \(opponentScore)"
        }
    }
    var currentRound = 1 {
        didSet {
            roundLevelLabel.text = "Round \(currentRound)"
        }
    }
    var hoop1 = 0
    var hoop2 = 0
    var hoop3 = 0
    var hoop4 = 0
    
    @IBOutlet weak var roundLevelLabel: UILabel! {
        didSet {
            roundLevelLabel.text = "Round \(currentRound)"
        }
    }
    @IBOutlet weak var playerScoreLabel: UILabel! {
        didSet {
            playerScoreLabel.text = "Score: \(playerScore)"
        }
    }
    @IBOutlet weak var opponentNameLabel: UILabel!
    @IBOutlet weak var opponentScoreLabel: UILabel! {
        didSet {
            opponentScoreLabel.text = "Score: \(opponentScore)"
        }
    }
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var opponentImageView: UIImageView!
    
    @IBOutlet weak var hoop1Button: UIButton!
    @IBOutlet weak var hoop2Button: UIButton!
    @IBOutlet weak var hoop3Button: UIButton!
    @IBOutlet weak var hoop4Button: UIButton!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    let defaults = UserDefaults.standard
    
    func saveLionLevel() {
        defaults.set(lion?.level, forKey: "savedLionLevel")
    }
    
    func getLionLevel() {
        if let lionLevel = defaults.object(forKey: "savedLionLevel") as? Int {
            lion?.level = lionLevel
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        opponents.append(Opponent(correctGuessPercentage: 0.25, trainerName: "Ralph Newbie", lionName: "Hairball", imageName: "Lion-Hairball"))
        opponents.append(Opponent(correctGuessPercentage: 0.50, trainerName: "Larry \"Scar\" Henderson", lionName: "Ghost", imageName: "Lion-Ghost"))
        opponents.append(Opponent(correctGuessPercentage: 0.75, trainerName: "Leo Lionel", lionName: "Mr. Purrfect", imageName: "Lion-MrPurrfect"))
        // Do any additional setup after loading the view.
        
        if let lion = lion {
            getLionLevel()
            selectedOpponent = opponents[(lion.level-1)]
        }
        if let selectedOpponent = selectedOpponent {
            let opponentName = selectedOpponent.trainerName
            let opponentLionName = selectedOpponent.lionName
            opponentNameLabel.text = "\(opponentLionName) trained by \(opponentName)"
            opponentImageView.image = UIImage(named: selectedOpponent.imageName)
        }
        doneButton.isEnabled = false
        setupRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Button Actions
    fileprivate func resetHoops() {
        hoop1 = 0
        hoop2 = 0
        hoop3 = 0
        hoop4 = 0
    }
    
    private func correctHoop(_ hoop: Int) -> Bool {
        return hoop == 1
    }
    
    private func updateForCorrectGuess() {
        messageLabel.text = "You guessed correctly!"
        playerScore += 1
        playerScoreLabel.text = "Score: \(playerScore)"
    }
    
    private func updateForIncorrectGuess() {
        messageLabel.text = "Wrong hoop.  Better luck next round."
    }
    
    private func updateForCorrectOpponentGuess() {
        opponentScore += 1
        opponentScoreLabel.text = "Score: \(opponentScore)"
    }
    
    private func hoopPressed(hoop: Int) {
        if correctHoop(hoop) {
            updateForCorrectGuess()
        } else {
            updateForIncorrectGuess()
        }
        
        if let opponent = selectedOpponent, opponent.didGuessHoop() {
            updateForCorrectOpponentGuess()
        }
        
        gameWinner()
        
        if currentRound == 5 {
            doneButton.isEnabled = true
        }
        if currentRound < 5 {
            currentRound += 1
            roundLevelLabel.text = "Round \(currentRound)"
            resetHoops()
            setupRound()
        }
    }
    
    @IBAction func hoop1Pressed(_ sender: Any) {
        hoopPressed(hoop:hoop1)
    }
    
    @IBAction func hoop2Pressed(_ sender: Any) {
        hoopPressed(hoop: hoop2)
    }
   
    @IBAction func hoop3Pressed(_ sender: Any) {
        hoopPressed(hoop: hoop3)
    }
    
    @IBAction func hoop4Pressed(_ sender: Any) {
        hoopPressed(hoop: hoop4)
    }    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
       if currentRound == 5 {
            doneButton.isEnabled = true
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //Training Functions
    func setupRound() {
        let randomHoopNumber = (Int(arc4random_uniform(4)) + 1)
        switch randomHoopNumber {
        case 1:
            hoop1 = 1
        case 2:
            hoop2 = 1
        case 3:
            hoop3 = 1
        case 4:
            hoop4 = 1
        default:
            print("Why did this happen?")
        }        
    }
    
    fileprivate func isGameOver() -> Bool {
        return currentRound == 5
    }
    
    fileprivate func playerWon() -> Bool {
        return playerScore > opponentScore
    }
    
    private func updateForPlayerWinning() {
        messageLabel.text = "Congratulations! You won!"
        lion?.level += 1
        lion?.hunger = 30
        lion?.happiness = 10
    }
    
    private func updateForPlayerLosing() {
        messageLabel.text = "Sorry. You lost."
        lion?.happiness = 0
    }
    
    func gameWinner() {
        if isGameOver() {
            if playerWon() {
                updateForPlayerWinning()
            } else {
                updateForPlayerLosing()
            }
            saveLionLevel()
            hoop1Button.isEnabled = false
            hoop2Button.isEnabled = false
            hoop3Button.isEnabled = false
            hoop4Button.isEnabled = false
        }
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

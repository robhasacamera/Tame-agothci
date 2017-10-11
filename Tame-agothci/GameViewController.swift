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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

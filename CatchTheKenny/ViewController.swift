//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by ProSmart on 17.8.21..
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
  
    @IBOutlet weak var frog1: UIImageView!
    @IBOutlet weak var frog2: UIImageView!
    @IBOutlet weak var frog3: UIImageView!
    @IBOutlet weak var frog4: UIImageView!
    @IBOutlet weak var frog5: UIImageView!
    @IBOutlet weak var frog6: UIImageView!
    @IBOutlet weak var frog7: UIImageView!
    @IBOutlet weak var frog8: UIImageView!
    @IBOutlet weak var frog9: UIImageView!
    
    var score = 0
    var counter = 0
    var timer = Timer()
    var frogArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        //HighScore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        
        frog1.isUserInteractionEnabled = true
        frog2.isUserInteractionEnabled = true
        frog3.isUserInteractionEnabled = true
        frog4.isUserInteractionEnabled = true
        frog5.isUserInteractionEnabled = true
        frog6.isUserInteractionEnabled = true
        frog7.isUserInteractionEnabled = true
        frog8.isUserInteractionEnabled = true
        frog9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increseScore))
        
        frog1.addGestureRecognizer(recognizer1)
        frog2.addGestureRecognizer(recognizer2)
        frog3.addGestureRecognizer(recognizer3)
        frog4.addGestureRecognizer(recognizer4)
        frog5.addGestureRecognizer(recognizer5)
        frog6.addGestureRecognizer(recognizer6)
        frog7.addGestureRecognizer(recognizer7)
        frog8.addGestureRecognizer(recognizer8)
        frog9.addGestureRecognizer(recognizer9)
        
        frogArray = [frog1, frog2, frog3, frog4, frog5, frog6, frog7, frog8, frog9]
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideFrog), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func increseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            //Skrivanje svih zaba kad se zavrsi igra
            for frog in frogArray {
                frog.isHidden = true
            }
            
            //HighScore
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            //Alert
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay Function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideFrog), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        
    }
    
    @objc func hideFrog() {
        
        for frog in frogArray {
            frog.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(frogArray.count - 1)))
        frogArray[random].isHidden = false
        
    }
    
    
    
    


}


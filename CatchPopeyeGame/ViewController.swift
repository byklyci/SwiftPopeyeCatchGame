//
//  ViewController.swift
//  CatchPopeyeGame
//
//  Created by Yusuf Kalaycı on 19.10.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var popeye1: UIImageView!
    @IBOutlet weak var popeye2: UIImageView!
    @IBOutlet weak var popeye3: UIImageView!
    @IBOutlet weak var popeye4: UIImageView!
    @IBOutlet weak var popeye5: UIImageView!
    @IBOutlet weak var popeye6: UIImageView!
    @IBOutlet weak var popeye7: UIImageView!
    @IBOutlet weak var popeye8: UIImageView!
    @IBOutlet weak var popeye9: UIImageView!
    
    var score = 0
    var timeLabelTimer = Timer()
    var counter = 0
    var popeyeArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        //HighScore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highScoreValue")
        
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "HighScore \(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "HighScore \(highScore)"
        }
        
        counter = 10
        timeLabelTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(reduceTime), userInfo: nil, repeats: true)
        
        popeyeArray = [popeye1,popeye2,popeye3,popeye4,popeye5,popeye6,popeye7,popeye8,popeye9]
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidePopeye), userInfo: nil, repeats: true)
        
        hidePopeye()
        
        popeye1.isUserInteractionEnabled = true
        popeye2.isUserInteractionEnabled = true
        popeye3.isUserInteractionEnabled = true
        popeye4.isUserInteractionEnabled = true
        popeye5.isUserInteractionEnabled = true
        popeye6.isUserInteractionEnabled = true
        popeye7.isUserInteractionEnabled = true
        popeye8.isUserInteractionEnabled = true
        popeye9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        popeye1.addGestureRecognizer(recognizer1)
        popeye2.addGestureRecognizer(recognizer2)
        popeye3.addGestureRecognizer(recognizer3)
        popeye4.addGestureRecognizer(recognizer4)
        popeye5.addGestureRecognizer(recognizer5)
        popeye6.addGestureRecognizer(recognizer6)
        popeye7.addGestureRecognizer(recognizer7)
        popeye8.addGestureRecognizer(recognizer8)
        popeye9.addGestureRecognizer(recognizer9)
        
    
    }
    
    @objc func hidePopeye(){
        for popeyes in popeyeArray {
            popeyes.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(popeyeArray.count - 1)))
        popeyeArray[random].isHidden = false
        
    }

    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
   
    
    @objc func reduceTime(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0{
            timeLabelTimer.invalidate()
            hideTimer.invalidate()
            
            for popeyes in popeyeArray {
                popeyes.isHidden = true
            }
            
            //HighScore
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "HighScore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScoreValue")
            }
            
            //ALERT
            let alert = UIAlertController(title: "Time's Up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //Replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timeLabelTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.reduceTime), userInfo: nil, repeats: true)
                

                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.hidePopeye), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
  

}


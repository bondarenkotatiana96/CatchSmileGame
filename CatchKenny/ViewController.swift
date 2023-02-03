//
//  ViewController.swift
//  CatchKenny
//
//  Created by Tatiana Bondarenko on 2/1/23.
//

import UIKit

class ViewController: UIViewController {

// Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var smileArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0

//Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!


    @IBOutlet weak var smile1: UIImageView!
    @IBOutlet weak var smile2: UIImageView!
    @IBOutlet weak var smile3: UIImageView!
    @IBOutlet weak var smile4: UIImageView!
    @IBOutlet weak var smile5: UIImageView!
    @IBOutlet weak var smile6: UIImageView!
    @IBOutlet weak var snile7: UIImageView!
    @IBOutlet weak var smile8: UIImageView!
    @IBOutlet weak var smile9: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "Score: \(score)"

        // High score check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")

        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highest score: \(highScore)"
        }

        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highest score: \(highScore)"
        }

// Images
        smile1.isUserInteractionEnabled = true
        smile2.isUserInteractionEnabled = true
        smile3.isUserInteractionEnabled = true
        smile4.isUserInteractionEnabled = true
        smile5.isUserInteractionEnabled = true
        smile6.isUserInteractionEnabled = true
        snile7.isUserInteractionEnabled = true
        smile8.isUserInteractionEnabled = true
        smile9.isUserInteractionEnabled = true

        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        smile1.addGestureRecognizer(recognizer1)
        smile2.addGestureRecognizer(recognizer2)
        smile3.addGestureRecognizer(recognizer3)
        smile4.addGestureRecognizer(recognizer4)
        smile5.addGestureRecognizer(recognizer5)
        smile6.addGestureRecognizer(recognizer6)
        snile7.addGestureRecognizer(recognizer7)
        smile8.addGestureRecognizer(recognizer8)
        smile9.addGestureRecognizer(recognizer9)

        smileArray = [smile1, smile2, smile3, smile4, smile5, smile6, snile7, smile8, smile9]

// Timers
        counter = 10
        timeLabel.text = "\(counter)"

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideImage), userInfo: nil, repeats: true)

        hideImage()
    }

    @objc func hideImage() {
        smileArray.forEach { smile in
            smile.isHidden = true
        }

        let random = Int(arc4random_uniform(UInt32(smileArray.count - 1)))
        smileArray[random].isHidden = false
    }

    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    @objc func countDown() {
        counter -= 1
        timeLabel.text = "\(counter)"

        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()

            smileArray.forEach { smile in
                smile.isHidden = true
            }

            // High Score
            if score > highScore {
                highScore = score
                highScoreLabel.text = "Highest Score: \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highscore")
            }

            // Alert
            let alert = UIAlertController(title: "Time's up!", message: "Want to play again?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Replay", style: .default) { _ in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"

                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideImage), userInfo: nil, repeats: true)
            }
            let cancelAction = UIAlertAction(title: "No", style: .cancel)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
    }

}


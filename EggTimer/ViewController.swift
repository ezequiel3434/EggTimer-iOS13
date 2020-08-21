//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var counter = 0
    let eggTimer = [ "Soft": 1, "Medium": 7, "Hard": 12 ]
    var timer = Timer()
    var time = 0
    
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressBar.progress = 0
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        mainTitleLabel.text = hardness
        guard let hard = eggTimer[hardness] else { return  }
        time = hard * 60
       
        
        counter = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        

    }
    
    
    @objc func updateCounter() {
        //example functionality
        if counter < time {
           
            counter += 1
            
            progressBar.progress = (Float(counter)/Float(time))
            
        } else {
            timer.invalidate()
            mainTitleLabel.text = "DONE!"
            playSound("alarm_sound")
        }
    }
    
    func playSound(_ title: String) {
        let url = Bundle.main.url(forResource: title, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
}




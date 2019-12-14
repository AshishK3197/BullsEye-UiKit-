//
//  ViewController.swift
//  BullsEye(UiKit)
//
//  Created by Ashish Kumar on 08/12/19.
//  Copyright © 2019 Ashish Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentSliderValue: Int = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var targetLabel : UILabel!
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var trackRound : UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let rounded  = slider.value.rounded()
        currentSliderValue = Int(rounded)
        startOver()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackImageLeft = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackImageLeft.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackImageRight = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackImageRight.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showAlert(){
        var bonusPoint = 0
        var difference = targetValue - currentSliderValue
        if difference < 0{
            difference *= -1
        }
        
        var points = 100 - difference
        score = score + points
        
        let title: String
        if difference == 0{
            title = "Perfect Shot"
            bonusPoint = 100
            points = points + bonusPoint
        }else if difference < 5{
            title = "You almost had it"
            if difference == 1{
                bonusPoint = 50
                points = points + bonusPoint
            }
        }else{
            title = "You were way off."
        }
        
        
        let alert = UIAlertController(title: title, message: "You scored \(points) points.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider : UISlider){
        let rounded  = slider.value.rounded()
        currentSliderValue = Int(rounded)
        
    }
    
    func startNewRound(){
        round = round + 1
        targetValue = Int.random(in: 1...100)
        currentSliderValue = 50
        slider.value = Float(currentSliderValue)
        updateLabel()

    }
    
    func updateLabel(){
        targetLabel.text = String(targetValue)
        totalScore.text = String(score)
        trackRound.text = String(round)
        
    }
    
    @IBAction func startOver(){
         round = 0
         score = 0
        startNewRound()
        
    }

}


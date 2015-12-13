//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Anjam Nabil Islam on 12/10/15.
//  Copyright © 2015 Anjam. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation {
        case add
        case subtract
        case divide
        case multiply
        case empty
    }
    
    var btnSound: AVAudioPlayer!
    var CurrentNumber = ""
    var LeftNumberStr: String = ""
    var RightNumberStr: String = ""
    var result: String = ""
    var CurrentOperation: Operation = Operation.empty
    
    @IBOutlet weak var ScreenOutput: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let SoundPath = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let SoundURL = NSURL(fileURLWithPath:SoundPath!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: SoundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {}
        ScreenOutput.text=""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func NumberPressed(btn: UIButton){
        PlayBtnSound()
        CurrentNumber += "\(btn.tag)"
        UpdateScreenOutput()
    }
    
    @IBAction func AddPressed(sender: AnyObject){
        ProcessOperation(Operation.add)
    }
    
    @IBAction func SubtractPressed(sender: AnyObject){
        ProcessOperation(Operation.subtract)
    }
    
    @IBAction func MultiplyPressed(sender: AnyObject){
        ProcessOperation(Operation.multiply)
    }
    
    @IBAction func DividePressed(sender: AnyObject){
        ProcessOperation(Operation.divide)
    }
    
    @IBAction func EqualPressed(sender: AnyObject){
        ProcessOperation(CurrentOperation)
    }
    
    func PlayBtnSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func ProcessOperation(op: Operation){
        PlayBtnSound()
        
        if CurrentOperation != Operation.empty {
            if CurrentNumber != "" {
                RightNumberStr = CurrentNumber
                CurrentNumber = ""
                
                if CurrentOperation == Operation.add {
                    result = "\(Double(LeftNumberStr)!+Double(RightNumberStr)!)"
                } else if CurrentOperation == Operation.subtract{
                    result = "\(Double(LeftNumberStr)!-Double(RightNumberStr)!)"
                } else if CurrentOperation == Operation.multiply {
                    result = "\(Double(LeftNumberStr)!*Double(RightNumberStr)!)"
                } else if CurrentOperation == Operation.divide {
                    result = "\(Double(LeftNumberStr)!/Double(RightNumberStr)!)"
                }
                
                LeftNumberStr = result
                ScreenOutput.text = result
            }
            CurrentOperation = op

            
        } else {
            LeftNumberStr = CurrentNumber
            CurrentOperation = op
            CurrentNumber = ""
        }
    }
    
    func UpdateScreenOutput() {
        ScreenOutput.text = CurrentNumber
    }

}


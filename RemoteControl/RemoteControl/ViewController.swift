//
//  ViewController.swift
//  RemoteControl
//
//  Created by Elijah Caluya on 2/1/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var powerSwitch: UISwitch!
    
    
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!

    
    @IBOutlet weak var channelLabel: UILabel!

    
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        powerLabel.text = (sender.isOn ? "ON" : "OFF")
    }
    
    @IBAction func changeVolume(_ sender: UISlider) {
        volumeLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func channelUp(_ sender: UIButton!) {
        var sum = (Int(channelLabel.text!) ?? 0) + 1
        if sum > 99 {
            sum = 1
        }
        channelLabel.text = "\(sum)"
    }
    
    @IBAction func channelDown(_ sender: UIButton) {
        var diff = (Int(channelLabel.text!) ?? 0) - 1
        if diff < 1 {
            diff = 99
        }
        channelLabel.text = "\(diff)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        powerLabel.text = "ON"
        powerSwitch.setOn(true, animated: true)
        volumeSlider.setValue(50, animated: true)
    }


}

	

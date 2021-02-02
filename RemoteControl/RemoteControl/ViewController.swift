//
//  ViewController.swift
//  RemoteControl
//
//  Created by Elijah Caluya on 2/1/21.
//

import UIKit

class ViewController: UIViewController {

    // Outlets for the power switch
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var powerSwitch: UISwitch!
    
    // Outlets for the volume
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!

    // Outlets for the channel
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var currentChannel: UILabel!
    
    // Outlets for the buttons mainly used for enabling and disabling
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    
    // Outlet for favorite channel segmented control
    @IBOutlet weak var favSegement: UISegmentedControl!
    
    // Outlet for the background to change color when powered off and on
    @IBOutlet weak var backgroundView: UIView!
    
    
    // Function to power on and off the remote
    @IBAction func switchToggled(_ sender: UISwitch) {
        powerLabel.text = (sender.isOn ? "ON" : "OFF")
        checkDisable()
    }
    
    
    // Function to change the volume with the slider
    @IBAction func changeVolume(_ sender: UISlider) {
        volumeLabel.text = "\(Int(sender.value))"
    }
    
    
    // Increase current channel by one
    @IBAction func channelUp(_ sender: UIButton!) {
        var sum = (Int(channelLabel.text!) ?? 0) + 1
        if sum > 99 {
            sum = 1
        }
        channelLabel.text = "\(sum)"
    }
    
    
    // Decrease current channel by one
    @IBAction func channelDown(_ sender: UIButton) {
        var diff = (Int(channelLabel.text!) ?? 0) - 1
        if diff < 1 {
            diff = 99
        }
        channelLabel.text = "\(diff)"
    }
    
    
    // When pressing a number button to change channel put it in the input box so the user is aware of what channel they are trying to change to.
    @IBAction func pressNum(_ sender: UIButton) {
        let current = currentChannel.text
        if current!.count == 2 {
            currentChannel.text = sender.currentTitle
        }
        else {
            currentChannel.text = current! + sender.currentTitle!
        }
        checkChannel()
    }
    
    
    // Changing to channel of favorites saved using segmented control
    @IBAction func favChannel(_ sender: UISegmentedControl) {
        if let channel = sender.titleForSegment(at: sender.selectedSegmentIndex){
            if channel == "ABC" {
                channelLabel.text = "7"
            }
            else if channel == "NBC" {
                channelLabel.text = "11"
            }
            else if channel == "PBS" {
                channelLabel.text = "22"
            }
            else if channel == "FOX" {
                channelLabel.text = "2"
            }
        }
    }
    
    
    // Function to disable all other controls when powered off (I am unaware of a better way to do this but if I knew I would try to implement it)
    func checkDisable(){
        if powerSwitch.isOn {
            backgroundView.backgroundColor = UIColor.systemGreen
            volumeSlider.isEnabled = true
            zeroButton.isEnabled = true
            oneButton.isEnabled = true
            twoButton.isEnabled = true
            threeButton.isEnabled = true
            upButton.isEnabled = true
            fourButton.isEnabled = true
            fiveButton.isEnabled = true
            sixButton.isEnabled = true
            downButton.isEnabled = true
            sevenButton.isEnabled = true
            eightButton.isEnabled = true
            nineButton.isEnabled = true
            favSegement.isEnabled = true
        }
        else {
            backgroundView.backgroundColor = UIColor.red
            volumeSlider.isEnabled = false
            zeroButton.isEnabled = false
            oneButton.isEnabled = false
            twoButton.isEnabled = false
            threeButton.isEnabled = false
            upButton.isEnabled = false
            fourButton.isEnabled = false
            fiveButton.isEnabled = false
            sixButton.isEnabled = false
            downButton.isEnabled = false
            sevenButton.isEnabled = false
            eightButton.isEnabled = false
            nineButton.isEnabled = false
            favSegement.isEnabled = false
        }
    }
    
    // Funciton to check if the current input for a channel is valid and if so, change the channel to it.
    func checkChannel(){
        let current = currentChannel.text
        if current!.count == 2 {
            if current!.prefix(1) == "0"{
                channelLabel.text = String(current!.suffix(1))
            }
            else {
                channelLabel.text = current
            }
        }
    }
    
    
    // Load the app with standard settings
    override func viewDidLoad() {
        super.viewDidLoad()
        powerLabel.text = "ON"
        powerSwitch.setOn(true, animated: true)
        volumeSlider.setValue(50, animated: true)
    }


}

	

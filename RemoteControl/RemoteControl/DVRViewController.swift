//
//  DVRViewController.swift
//  RemoteControl
//
//  Created by Elijah Caluya on 2/15/21.
//

import UIKit

class DVRViewController: UIViewController {
    // Labels for the current power and state of the DVR
    @IBOutlet weak var powerStatus: UILabel!
    @IBOutlet weak var stateOutlet: UILabel!
    
    // Outlet for the power switch
    @IBOutlet weak var powerSwitch: UISwitch!
    
    // Outlets for all of the buttons so they can be disabled when the remote is turned off
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var stopButtonOutlet: UIButton!
    @IBOutlet weak var pauseButtonOutlet: UIButton!
    @IBOutlet weak var fastForwardOutlet: UIButton!
    @IBOutlet weak var fastRewindOutlet: UIButton!
    @IBOutlet weak var recordButtonOutlet: UIButton!
    
    // Variables to keep track of current state, message, and action
    // playingState == 0 => stopped
    // playingState == 1 => playing
    // playingState == 2 => recording
    var playingState = 0
    var message = ""
    var action = ""
    
    
    
    // Action for toggling the power switch
    @IBAction func powerSwitchToggle(_ sender: UISwitch) {
        powerStatus.text = (sender.isOn ? "ON" : "OFF")
        checkDisable()
    }
    
    
    // Action for when play button is pressed
    @IBAction func playButton(_ sender: UIButton) {
        action = "Playing"
        // Can only play when not recording so throw alert when it is
        if playingState == 2 {
            message = "Cannot play because DVR is recording"
            displayAlert(message, state: 1, stateAction: action)
        }
        else {
            changeState(action, 1)
        }
    }
    
    
    // Action to stop all actions
    @IBAction func stopButton(_ sender: UIButton) {
        action = "Stopped"
        changeState(action, 0)
    }
    
    
    // Action to pause what is currently playing
    @IBAction func pauseButton(_ sender: UIButton) {
        action = "Paused"
        // Can only pause when playing so show custom alerts based on current state
        if playingState == 2 {
            message = "Cannot pause because DVR is recording"
            displayAlert(message, state: 1, stateAction: action)
        }
        else if playingState == 0 {
            message = "Cannot pause because DVR is stopped"
            displayAlert(message, state: 1, stateAction: action)
        }
        else {
            changeState(action, 1)
        }
    }
    
    
    // Action to fast forward
    @IBAction func fastForward(_ sender: UIButton) {
        action = "Fast Forwarding"
        // Can only fast forward when playing so show custom alert depending on current state
        if playingState == 2 {
            message = "Cannot fast forward because DVR is recording"
            displayAlert(message, state: 1, stateAction: action)
        }
        else if playingState == 0 {
            message = "Cannot fast forward because DVR is stopped"
            displayAlert(message, state: 1, stateAction: action)
        }
        else {
            changeState(action, 1)
        }
    }
    
    
    // Action to fast rewind
    @IBAction func fastRewind(_ sender: UIButton) {
        action = "Fast Rewinding"
        // Can only fast rewind when playing so show custom alert depending on current state
        if playingState == 2 {
            message = "Cannot fast rewind because DVR is recording"
            displayAlert(message, state: 1, stateAction: action)
        }
        else if playingState == 0 {
            message = "Cannot fast rewind because DVR is stopped"
            displayAlert(message, state: 1, stateAction: action)
        }
        else {
            changeState(action, 1)
        }
    }
    
    
    // Action to record
    @IBAction func recordButton(_ sender: UIButton) {
        action = "Recording"
        // Can only record when stopped so show alert when called and teh DVR is playing
        if playingState == 1 {
            message = "Cannot record because DVR is playing"
            displayAlert(message, state: 2, stateAction: action)
        }
        else {
            changeState(action, 2)
        }
    }
    
    
    // Function to display alert when invalid operation is pressed
    func displayAlert(_ msg: String, state: Int, stateAction: String){
        let title = "Invlaid Operation"
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        // Create actions to cancel or force the operation selected
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let continueAction = UIAlertAction(title: "Continue Anyway", style: .default, handler: {
            action in self.forceChangeState(stateAction, state)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(continueAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    // Function to force an operation and display alert to user to confirm
    func forceChangeState(_ stateAction: String, _ state: Int){
        let title = "Forced Operation"
        let message = "Force changed operation to \(stateAction)"
        changeState(stateAction, state)
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    // Function that changes the current state and updates state label
    func changeState(_ text : String, _ state: Int){
        playingState = state
        stateOutlet.text = text
    }
    
    
    // Function for disabling and enabling buttons when power is off or on
    func checkDisable(){
        if powerSwitch.isOn {
            action = "Stopped"
            changeState(action, 0)
            playButtonOutlet.isEnabled = true
            stopButtonOutlet.isEnabled = true
            pauseButtonOutlet.isEnabled = true
            fastForwardOutlet.isEnabled = true
            fastRewindOutlet.isEnabled = true
            recordButtonOutlet.isEnabled = true
            
        }
        else {
            playButtonOutlet.isEnabled = false
            stopButtonOutlet.isEnabled = false
            pauseButtonOutlet.isEnabled = false
            fastForwardOutlet.isEnabled = false
            fastRewindOutlet.isEnabled = false
            recordButtonOutlet.isEnabled = false
        }
    }
    
    // Function that will bring our segue to the first screen
    @IBAction func backToTV(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        action = "Stopped"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

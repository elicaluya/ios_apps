//
//  ConfigViewController.swift
//  RemoteControl
//
//  Created by Elijah Caluya on 2/21/21.
//

import UIKit

class ConfigViewController: UIViewController {

    // Outlet for entering label
    @IBOutlet weak var labelOutlet: UITextField!
    
    // Outlets for the channel label and the channel stepper
    @IBOutlet weak var channelNum: UILabel!
    @IBOutlet weak var channelStepper: UIStepper!
    
    
    // Method to close the keyboard when pressing the return key
    @IBAction func closeLabel(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    // Method to adjust the channel
    @IBAction func adjustChannel(_ sender: UIStepper) {
        channelNum.text = Int(sender.value).description
    }
    
    // Method to cancel saving the configuration
    @IBAction func cancelAction(_ sender: UIButton) {
        labelOutlet.text = ""
        channelNum.text = "1"
        channelStepper.value = 1
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        channelStepper.wraps = true
        channelStepper.autorepeat = true
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

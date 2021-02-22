//
//  ConfigViewController.swift
//  RemoteControl
//
//  Created by Elijah Caluya on 2/21/21.
//

import UIKit

class ConfigViewController: UIViewController {

    // Outlet for the segmented control
    @IBOutlet weak var favSegment: UISegmentedControl!
    
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
        reset()
    }
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        if validLabel() {
            let tvSegment = self.tabBarController!.viewControllers![0] as! ViewController
            tvSegment.favSegement.setTitle(labelOutlet.text, forSegmentAt: favSegment.selectedSegmentIndex)
            if favSegment.selectedSegmentIndex == 0 {
                tvSegment.favChannel1 = channelNum.text!
            } else if favSegment.selectedSegmentIndex == 1 {
                tvSegment.favChannel2 = channelNum.text!
            } else if favSegment.selectedSegmentIndex == 2 {
                tvSegment.favChannel3 = channelNum.text!
            } else if favSegment.selectedSegmentIndex == 3 {
                tvSegment.favChannel4 = channelNum.text!
            }
            reset()
        }
    }
    
    func reset(){
        favSegment.selectedSegmentIndex = 0
        labelOutlet.text = ""
        channelNum.text = "1"
        channelStepper.value = 1
    }
    
    func validLabel() -> Bool {
        let entry = labelOutlet.text
        if entry!.count < 1 || entry!.count > 4 {
            let title = "Invalid Label Size"
            let message = "Label size needs to be in range 1 - 4"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            return false
        }
        let title = "Success"
        let message = "Successfully Saved New Configuration"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        return true
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

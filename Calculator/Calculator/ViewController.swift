//
//  ViewController.swift
//  Calculator
//
//  Created by Elijah Caluya on 1/24/21.
//

import UIKit

class ViewController: UIViewController {

    // Outlet label for the answer
    @IBOutlet weak var number: UILabel!
    
    // Integer to store the value we are adding with the input
    var addNum : Int = 0
    
    // Action when user presses a number button
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let num = sender.currentTitle {
            // Label will change to number pressed if initially 0
            if number.text! == "0" {
                number.text = "\(num)"
            }
            // Otherwise adjust the current number shown based on what buttons user presses.
            else {
                let current = number.text! + num
                number.text = "\(current)"
            }
        }
    }
    
    // Action for when user presses + button to add numbers
    @IBAction func addition(_ sender: UIButton) {
        addNum = Int(number.text!) ?? 0
        number.text = "0"
    }
    
    // Action for when user presses = button to compute sum
    @IBAction func equals(_ sender: UIButton) {
        let currNum = Int(number.text!) ?? 0
        let sum = addNum + currNum
        number.text = "\(sum)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


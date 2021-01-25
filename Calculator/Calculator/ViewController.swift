//
//  ViewController.swift
//  Calculator
//
//  Created by Elijah Caluya on 1/24/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var number: UILabel!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if let num = sender.currentTitle {
            if number.text! == "0" {
                number.text = "\(num)"
            }
            else if num == "C"{
                number.text = "0"
            }
            else {
                let current = number.text! + num
                number.text = "\(current)"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


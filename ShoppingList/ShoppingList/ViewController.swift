//
//  ViewController.swift
//  ShoppingList
//
//  Created by Elijah Caluya on 2/7/21.
//

import UIKit

class ViewController: UIViewController {

    // Outlet used for tapping on the background to close a keyboard
    @IBOutlet var textFields: [UIControl]!
    
    // Outlets for the text fields for description and quantity
    @IBOutlet weak var descOutlet: UITextField!
    @IBOutlet weak var quantOutlet: UITextField!
    
    // Outlet for the textview that displays the shopping list
    @IBOutlet weak var listDisplay: UITextView!
    
    // Array to hold the shopping list
    var shoppingList: [String] = []

    // Clicking the new list button will clear the current contents of the shopping list, the displayt text view, and text in the TextFields
    @IBAction func newList(_ sender: UIButton) {
        shoppingList.removeAll()
        listDisplay.text = "No Items"
        descOutlet.text = ""
        quantOutlet.text = ""
    }
    
    // The new item button will clear the current text in the text fields
    @IBAction func newItem(_ sender: UIButton) {
        descOutlet.text = ""
        quantOutlet.text = ""
    }
    
    // Will add and display new item to shopping list if it is a valid entry
    @IBAction func add(_ sender: UIButton) {
        if descOutlet.text == "" || quantOutlet.text == "" {
            displayAlert(message: "Text Input is empty")
        }
        else if validInput(descOutlet.text!){
            displayAlert(message: "Description contains invalid characters")
        }
        else {
            let desc = descOutlet.text
            let quant = quantOutlet.text
            let entry = String(quant!) + "x " + desc!
            shoppingList.append(entry)
            var text = ""
            for i in 0..<shoppingList.count {
                text += "\(shoppingList[i])\n"
            }
            listDisplay.text = text
        }
    }
    
    // Function for displaying a popup if there is an invalid input
    func displayAlert(message msg: String){
        let title = "Invalid Input"
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // Function to check for valid input. Returns true if there are invalid characters in the input
    func validInput(_ input: String) -> Bool{
        let descRegEx = ".*[^A-Za-z].*"
        let validInput = NSPredicate(format: "SELF MATCHES %@", descRegEx)
        return validInput.evaluate(with: input)
    }
    
    // Action to close the keyboard when pressing return
    @IBAction func closeDesc(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    // Action to close numerical keyboard when touching the background
    @IBAction func backgroundTouched(_ sender: UIControl) {
        for tf in textFields {
            tf.resignFirstResponder()
        }
        listDisplay.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Want to disable the Textview that displays our shopping list
        listDisplay.isUserInteractionEnabled = false
    }


}


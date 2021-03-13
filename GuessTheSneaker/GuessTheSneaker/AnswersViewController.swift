//
//  AnswersViewController.swift
//  GuessTheSneaker
//
//  Created by Elijah Caluya on 3/12/21.
//

import UIKit

class AnswersViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    

    @IBOutlet weak var shoeImage: UIImageView!
    @IBOutlet weak var shoePicker: UIPickerView!
    
    var shoesList = [Shoe]()
    let urlString = "https://shoe-images-ios.s3-us-west-1.amazonaws.com"
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shoesList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let shoe = shoesList[row]
        if shoe.brand == "Air Jordan"{
            if shoe.model!.count == 8 {
                return "\(shoe.brand!) \(shoe.model!.suffix(1)) \(shoe.colorway!)"
            }
            else {
                return "\(shoe.brand!) \(shoe.model!.suffix(2)) \(shoe.colorway!)"
            }
        }
        else {
            return "\(shoe.brand!) \(shoe.model!) \(shoe.colorway!)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        let shoe = shoesList[row]
        if shoe.brand == "Air Jordan"{
            if shoe.model!.count == 8 {
                label.text = "\(shoe.brand!) \(shoe.model!.suffix(1)) \(shoe.colorway!)"
            }
            else {
                label.text = "\(shoe.brand!) \(shoe.model!.suffix(2)) \(shoe.colorway!)"
            }
        }
        else {
            label.text = "\(shoe.brand!) \(shoe.model!) \(shoe.colorway!)"
        }
        
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }
    
    // Function to display the shoe by pulling it from online source
    func displayShoe(shoe: Shoe){
        let imgURL = "\(urlString)/\(shoe.id!).png"
        shoeImage.load(url: URL(string: imgURL)!)
    }
    
    @IBAction func dismissAnswers(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        displayShoe(shoe: shoesList.first!)
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

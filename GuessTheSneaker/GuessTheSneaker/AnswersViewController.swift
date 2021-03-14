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
    
    // shoesList will hold all of the shoe objects from the data
    var shoesList = [Shoe]()
    let urlString = "https://shoe-images-ios.s3-us-west-1.amazonaws.com"
    
    
    // Specify one component for the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Specify length of shoesList for picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shoesList.count
    }
    
    // Specify what to return for picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(shoesList[row].brand!) \(shoesList[row].model!) \(shoesList[row].colorway!)"
    }
    
    // SPecify how to display items in the picker
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        if shoesList[row].brand == "Air Jordan"{
            label.text = "\(shoesList[row].model!) \(shoesList[row].colorway!)"
        }
        else {
            label.text = "\(shoesList[row].brand!) \(shoesList[row].model!) \(shoesList[row].colorway!)"
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
    
    // Action for when the show button is pressed to display the shoe chosen from picker
    @IBAction func showShoe(_ sender: UIButton) {
        let shoe = shoesList[shoePicker.selectedRow(inComponent: 0)]
        displayShoe(shoe: shoe)
    }
    
    // dismiss segue
    @IBAction func dismissAnswers(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        displayShoe(shoe: shoesList.first!)
        self.shoePicker.delegate = self
        self.shoePicker.dataSource = self
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

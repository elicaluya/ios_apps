//
//  GameplayViewController.swift
//  GuessTheSneaker
//
//  Created by Elijah Caluya on 3/5/21.
//

import UIKit

class GameplayViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var shoeImage: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var quitButton: UIBarButtonItem!
    
    var brand: String  = ""
    var brandList = [Shoe]()
    var currentShoes = [Shoe]()
    var currentIndex: Int = 0
    let urlString = "https://shoe-images-ios.s3-us-west-1.amazonaws.com"
    var modelList = [String]()
    var colorwayList = [String]()
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return modelList.count
        } else {
            return colorwayList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return modelList[row]
        } else {
            return colorwayList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        if component == 0 {
            label.text = modelList[row]
        } else {
            label.text = colorwayList[row]
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
    
    // Function to get a random shoe not already picked and add it to the list
    func getRandShoe() -> Shoe {
        var shoe = brandList.randomElement()!
        while currentShoes.contains(shoe) {
            shoe = brandList.randomElement()!
        }
        currentShoes.append(shoe)
        return shoe
    }
    
    // Populate the lists for the pickers with the correct answer and wrong choices
    func populateLists(currentShoe: Shoe) {
        modelList.append(currentShoe.model!)
        colorwayList.append(currentShoe.colorway!)
        
        var randBrand = brandList.randomElement()?.model
        var randColorway = brandList.randomElement()?.colorway
        for _ in 0...1 {
            while modelList.contains(randBrand!){
                randBrand = brandList.randomElement()?.model
            }
            modelList.append(randBrand!)
            
            while colorwayList.contains(randColorway!){
                randColorway = brandList.randomElement()?.colorway
            }
            colorwayList.append(randColorway!)
        }
        modelList.shuffle()
        colorwayList.shuffle()
    }
    
    // Load game by displaying the current image of a random shoe and populating lists with correct and incorrect choices
    func loadGame(){
        let shoe = getRandShoe()
        displayShoe(shoe: shoe)
        populateLists(currentShoe: shoe)
    }
    
    @IBAction func submit(_ sender: UIButton) {
        let title = "Chosen Shoe:"
        let message = "You have selected \(modelList[picker.selectedRow(inComponent: 0)]) and \(colorwayList[picker.selectedRow(inComponent: 1)])"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let okayAction = UIAlertAction(title: "Confirm", style: .default, handler: nil)
        alertController.addAction(cancelAction
        )
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func quitGame(_ sender: UIBarButtonItem) {
        currentShoes.removeAll()
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        brandLabel?.text = brand
        currentShoes.removeAll()
        currentIndex = 0
        loadGame()
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

extension UIImageView {
    func load(url: URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

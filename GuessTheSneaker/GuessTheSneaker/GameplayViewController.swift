//
//  GameplayViewController.swift
//  GuessTheSneaker
//
//  Created by Elijah Caluya on 3/5/21.
//

import UIKit

class GameplayViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var correct_counter: UILabel!
    @IBOutlet weak var wrong_counter: UILabel!
    @IBOutlet weak var shoeImage: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var quitButton: UIBarButtonItem!
    
    var brand: String  = ""
    var brandList = [Shoe]()
    var currentShoes = [Shoe]()
    let urlString = "https://shoe-images-ios.s3-us-west-1.amazonaws.com"
    var modelList = [String]()
    var colorwayList = [String]()
    var correct_count = 0
    var wrong_count = 0
    var didWin = false
    
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
        modelList.removeAll()
        colorwayList.removeAll()
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
        picker.reloadAllComponents()
    }
    
    // Load game by displaying the current image of a random shoe and populating lists with correct and incorrect choices
    func loadGame(){
        let shoe = getRandShoe()
        displayShoe(shoe: shoe)
        populateLists(currentShoe: shoe)
    }
    
    // Reset Game by setting values back to 0 and clearing the current shoes list
    func resetGame(){
        currentShoes.removeAll()
        didWin = false
        loadGame()
        correct_count = 0
        correct_counter.text = String(0)
        wrong_count = 0
        wrong_counter.text = String(0)
    }
    
    
    func checkAnswer(model: String, colorway: String){
        let correct_model = currentShoes.last?.model
        let correct_cw = currentShoes.last?.colorway
        
        var title = ""
        var message = ""
        if correct_model == model && correct_cw == colorway {
            title = "Correct!"
            message = "You picked the correct answer!"
            correct_count += 1
            correct_counter.text = String(correct_count)
        }
        else {
            title = "Wrong!"
            message = "You picked the wrong answer!"
            wrong_count += 1
            wrong_counter.text = String(wrong_count)
        }
        
        // Checking end game
        if correct_count == 10 {
            didWin = true
            performSegue(withIdentifier: "GameEnded", sender: nil)
            resetGame()
        }
        if wrong_count == 3 {
            performSegue(withIdentifier: "GameEnded", sender: nil)
            resetGame()
        }
        else {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: { self.loadGame() })
        }
    }
    
    @IBAction func submit(_ sender: UIButton) {
        let title = "Chosen Shoe:"
        let model_choice = modelList[picker.selectedRow(inComponent: 0)]
        let cw_choice = colorwayList[picker.selectedRow(inComponent: 1)]
        let message = "Choose \(model_choice) and \(cw_choice)?"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let okayAction = UIAlertAction(title: "Confirm", style: .default, handler: { action in
            self.checkAnswer(model: model_choice, colorway: cw_choice)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func quitGame(_ sender: UIBarButtonItem) {
        currentShoes.removeAll()
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameEnded" {
            if let target = segue.destination as? WinLoseViewController {
                target.didWin = didWin
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        brandLabel?.text = brand
        resetGame()
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

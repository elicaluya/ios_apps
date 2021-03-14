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
    
    
    // String of brand to display on page
    var brand: String  = ""
    // List to hold all shoes of a certain brand
    var brandList = [Shoe]()
    // List to hold shoes that have already been displayed
    var currentShoes = [Shoe]()
    // url for pulling shoes from aws s3 bucket
    let urlString = "https://shoe-images-ios.s3-us-west-1.amazonaws.com"
    // Lists for holding models and colorways for picker
    var modelList = [String]()
    var colorwayList = [String]()
    // Counts to keep track of correct and wrong choices
    var correct_count = 0
    var wrong_count = 0
    // Limits for the pinch to zoom
    var recognizerScale:CGFloat = 1.0
    let maxScale:CGFloat = 1.5
    let minScale:CGFloat = 0.8

    
    // Specify 2 components for model and colorway
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // Specifying list size for each component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return modelList.count
        } else {
            return colorwayList.count
        }
    }
    
    // Specifying what list to pull from depending on component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return modelList[row]
        } else {
            return colorwayList[row]
        }
    }
    
    // Specifying how to display text in the picker
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
    
    // Function to get a random shoe not already picked and add it to the currentShoes list
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
        // Clear list to fill with new data
        modelList.removeAll()
        colorwayList.removeAll()
        // FIrst add the current shoe's data to the model and colorway list
        modelList.append(currentShoe.model!)
        colorwayList.append(currentShoe.colorway!)
        
        // Choose random model and colorway to put into list
        var randBrand = brandList.randomElement()?.model
        var randColorway = brandList.randomElement()?.colorway
        // Need 2 other random choices
        for _ in 0...1 {
            // If the random choice is in the list, get another random element
            while modelList.contains(randBrand!){
                randBrand = brandList.randomElement()?.model
            }
            modelList.append(randBrand!)
            
            while colorwayList.contains(randColorway!){
                randColorway = brandList.randomElement()?.colorway
            }
            colorwayList.append(randColorway!)
        }
        // Randomize the order of choices in the lists and reflect the changes in the picker
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
        loadGame()
        correct_count = 0
        correct_counter.text = String(0)
        wrong_count = 0
        wrong_counter.text = String(0)
    }
    
    // Checking the answer given by the user and if game is over or not
    func checkAnswer(model: String, colorway: String){
        let correct_model = currentShoes.last?.model
        let correct_cw = currentShoes.last?.colorway
        
        var title = ""
        var message = ""
        // model and colorway both need to match in order for answer to be correct
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
            performSegue(withIdentifier: "WinGame", sender: nil)
            resetGame()
        }
        else if wrong_count == 3 {
            performSegue(withIdentifier: "LoseGame", sender: nil)
            resetGame()
        }
        else {
            // Display message if not end game
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: { self.loadGame() })
        }
    }
    
    // Submit the user's choices
    @IBAction func submit(_ sender: UIButton) {
        let title = "Chosen Shoe:"
        let model_choice = modelList[picker.selectedRow(inComponent: 0)]
        let cw_choice = colorwayList[picker.selectedRow(inComponent: 1)]
        let message = "Choose \(model_choice) and \(cw_choice)?"
        // User has option to confirm or cancel their choice
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let okayAction = UIAlertAction(title: "Confirm", style: .default, handler: { action in
            self.checkAnswer(model: model_choice, colorway: cw_choice)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // Return to main menu
    @IBAction func quitGame(_ sender: UIBarButtonItem) {
        currentShoes.removeAll()
        dismiss(animated: true, completion: nil)
    }
    
    // Function for pinch to zoom
    @objc func pinchGesture(sender: UIPinchGestureRecognizer){
        guard sender.view != nil else {return}
        
        if sender.state == .began || sender.state == .changed {
            if (recognizerScale < maxScale && sender.scale > 1.0) || (recognizerScale > minScale && sender.scale < 1.0) {
                sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
                recognizerScale *= sender.scale
                sender.scale = 1.0
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // For pinch to zoom functionality
        shoeImage.isUserInteractionEnabled = true
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
        shoeImage.addGestureRecognizer(pinchGesture)
        // Set brand label to corresponding brand and set default values for the game
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

// Need this extension in order to pull images from online resource
// Will display error in console: nw_protocol_get_quic_image_block_invoke dlopen libquic failed
// Researched online and was advised to ignore error as it is a bug
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

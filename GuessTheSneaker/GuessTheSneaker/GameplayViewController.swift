//
//  GameplayViewController.swift
//  GuessTheSneaker
//
//  Created by Elijah Caluya on 3/5/21.
//

import UIKit

class GameplayViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickList[row]
    }
    
    
    @IBOutlet weak var shoeImage: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBAction func submitButton(_ sender: UIButton) {
    }
    @IBOutlet weak var quitButton: UIBarButtonItem!
    
    var brand: String  = ""
    var brandList = [Shoe]()
    var currentShoes = [Shoe]()
    let urlString = "https://shoe-images-ios.s3-us-west-1.amazonaws.com"
    var pickList = [String]()
    
    
    // Function to display the shoe by pulling it from online source
    func displayShoe(shoe: Shoe){
        let imgURL = "\(urlString)/\(shoe.id!).png"
        shoeImage.load(url: URL(string: imgURL)!)
    }
    
    func getRandShoe() -> Shoe {
        var shoe = brandList.randomElement()!
        while currentShoes.contains(shoe) {
            shoe = brandList.randomElement()!
        }
        currentShoes.append(shoe)
        return shoe
    }
    
    func createList() {
        for s in brandList {
            pickList.append("\(s.model!) \(s.colorway!)")
        }
    }
    
    @IBAction func submit(_ sender: UIButton) {
        let title = "Chosen Shoe:"
        let message = "You have selected \(pickList[picker.selectedRow(inComponent: 0)])"
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
        let shoe = getRandShoe()
        displayShoe(shoe: shoe)
        createList()
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

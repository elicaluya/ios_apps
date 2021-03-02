//
//  DetailViewController.swift
//  TableViewApp
//
//  Created by Elijah Caluya on 3/1/21.
//

import UIKit

class DetailViewController: UIViewController {
    // Outlets for all the labels and ImageView on the details page
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var debut: UILabel!
    @IBOutlet weak var subunit: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var animal: UILabel!
    @IBOutlet weak var memberPic: UIImageView!
    
    // Member variable used for pulling info
    var member: Member?
    
    // Populate the labels and ImageView with info from the corresponding member
    override func viewWillAppear(_ animated: Bool) {
        if let m = member {
            name.text = m.stageName
            fullName.text = "Full Name: \(m.lastName) \(m.firstName)"
            birthday.text = "Birthday: \(m.birthday)"
            debut.text = "Debut: \(m.debut)"
            subunit.text = "Sub-Unit: \(m.unit.rawValue)"
            color.text = "Representative Color: \(m.color)"
            animal.text = "Representative Animal: \(m.animal)"
            memberPic.load(url: URL(string: m.pic)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

// Need extension of UIImageView in order to load image in from the web
// Will throw 'nw_protocol_get_quic_image_block_invoke dlopen libquic failed' warning on simulator but not on an actual device.
// Looked online for solution and was suggested to ignore the warning
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

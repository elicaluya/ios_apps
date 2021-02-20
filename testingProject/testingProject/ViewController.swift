//
//  ViewController.swift
//  testingProject
//
//  Created by Elijah Caluya on 2/19/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var urlImage: UIImageView!
    
    let url = "https://elijah-caluya-web.s3-us-west-1.amazonaws.com/PersonalWebsite/img/androidapp_screenshot.PNG"

    
    
    @IBAction func getImage(_ sender: UIButton) {
        urlImage.load(url: URL(string: url)!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


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


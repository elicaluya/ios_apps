//
//  GameplayViewController.swift
//  GuessTheSneaker
//
//  Created by Elijah Caluya on 3/5/21.
//

import UIKit

class GameplayViewController: UIViewController {

    @IBOutlet weak var quitButton: UIBarButtonItem!
    
    
    @IBAction func quitGame(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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

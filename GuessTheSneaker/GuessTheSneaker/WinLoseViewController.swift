//
//  WinLoseViewController.swift
//  GuessTheSneaker
//
//  Created by Elijah Caluya on 3/12/21.
//

import UIKit

class WinLoseViewController: UIViewController {

    @IBOutlet weak var win_lose_label: UILabel!
    
    var didWin = false
    
    @IBAction func restart(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mainMenu(_ sender: UIButton) {
        var top: UIViewController = self;
        while top.presentingViewController != nil {
            top = top.presentingViewController!
        }
        top.dismiss(animated: true, completion: nil)
    }
    
    func checkWin(){
        if didWin == true {
            win_lose_label.text = "You Win!"
            self.view.backgroundColor = UIColor.green
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        definesPresentationContext = true
        checkWin()
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

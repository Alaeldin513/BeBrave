//
//  PinScreenViewController.swift
//  Assault Prevention
//
//  Created by Alaeldin Tirba on 12/20/17.
//  Copyright © 2017 Alaeldin Tirba. All rights reserved.
//

import UIKit

class PinScreenViewController: UIViewController {

    
    @IBOutlet weak var pinPostionOne: UILabel!
    @IBOutlet weak var pinPostionTwo: UILabel!
    @IBOutlet weak var pinPostionThree: UILabel!
    @IBOutlet weak var pinPostionFour: UILabel!
    
    @IBOutlet weak var oneButton: DesignableButton!
    @IBOutlet weak var twoButton: DesignableButton!
    @IBOutlet weak var threeButton: DesignableButton!
    @IBOutlet weak var fourButton: DesignableButton!
    @IBOutlet weak var fiveButon: DesignableButton!
    @IBOutlet weak var sixButton: DesignableButton!
    @IBOutlet weak var sevenButton: DesignableButton!
    @IBOutlet weak var eightButton: DesignableButton!
    @IBOutlet weak var nineButton: DesignableButton!
    @IBOutlet weak var zeroButton: DesignableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard Int(pinPostionOne.text!) != nil else {
            pinPostionOne.text = sender.currentTitle!
            pinPostionOne.isHidden = false
            return
        }
        
        guard Int(pinPostionTwo.text!) != nil else {
            pinPostionTwo.text = sender.currentTitle!
            pinPostionTwo.isHidden = false
            return
        }
        
        guard Int(pinPostionThree.text!) != nil else {
            pinPostionThree.text = sender.currentTitle!
            pinPostionThree.isHidden = false
            return
        }
        
        guard Int(pinPostionFour.text!) != nil else {
            pinPostionFour.text = sender.currentTitle!
            pinPostionFour.isHidden = false
            var pin = pinPostionOne.text! + pinPostionTwo.text! + pinPostionThree.text! + pinPostionFour.text!
            print(pin)
            performSegue(withIdentifier: "userInfoSegue", sender: nil)
            return
        }
        
        print("all Done no more numbers")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

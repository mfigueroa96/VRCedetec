//
//  ViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 17/02/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var aboutBtn: DesignableButton!
    
    @IBAction func share(_ sender: Any) {
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutBtn.leftImage = UIImage();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


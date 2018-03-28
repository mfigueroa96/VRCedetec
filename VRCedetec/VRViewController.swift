//
//  VRViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 18/02/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit

class VRViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    var timer = Timer();

    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerAction), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    var countClicks = 0;
    @IBAction func OnHotSpotClick(_ sender: Any) {
        countClicks = countClicks + 1;
        
        switch countClicks {
        case 1:
            image.image = UIImage(named: "View3.png");
        case 2:
            image.image = UIImage(named: "View4.png");
        case 3:
            image.image = UIImage(named: "View3.png");
        case 4:
            image.image = UIImage(named: "View2.png");
        case 5:
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var counter = 0;
    @objc func TimerAction()
    {
        counter = counter + 1;
        if (counter == 3)
        {
            timer.invalidate();
            image.image = UIImage(named: "View2.png");
        }
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

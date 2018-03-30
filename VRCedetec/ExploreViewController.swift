//
//  ExploreViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 17/02/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    var classrooms = [Classroom]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ReturnToMain(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let btn = sender as! UIButton
        switch (btn.tag)
        {
            case 1:
                let next = segue.destination as! ExploreFloorsViewController
                next.classrooms = classrooms;
                break;
            case 2:
                let next = segue.destination as! ExploreAreasViewController
                next.classrooms = classrooms;
                break;
        default:
            print("other")
        }
    }

}

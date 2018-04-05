//
//  ProjectDetailsViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 04/04/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: UIViewController {

    
    @IBOutlet weak var infoView: UITextView!
    var project : Project? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoView.text = "NOMBRE: " + (project?.name)! + "\n\nSTATUS: " + (project?.status)! + "\n\nSALONES DE CLASES:\n";
        
        for resource in (project?.resources)! {
            infoView.text.append(resource + "\n");
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GoBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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

//
//  PreviewViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 18/02/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var locationTxt: UITextView!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var processInd: UIActivityIndicatorView!

    
    var room : Classroom? = nil;
    
    @IBAction func share(_ sender: Any) {
        var textoFijo = "¡Saludos desde CEDETEC!"
        textoFijo = textoFijo + " Estoy en " + locationTxt.text + "."
        textoFijo = textoFijo + " Puedes verlo aquí:"
        if let miSitio = NSURL(string: "http://199.233.252.86/201811/images/CEDETEC/104Gear.JPG") {
            let objetosParaCompartir = [textoFijo, miSitio] as [Any]
            let actividadRD = UIActivityViewController(activityItems: objetosParaCompartir, applicationActivities: nil)
            
            self.present(actividadRD, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processInd.isHidden = true
        
        locationTxt.text = (room?.name)! + ", " + (room?.floor)!;
        descriptionTxt.text = room?.description;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GoBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    var timer = Timer()
    
    @IBAction func exploreBtn(_ sender: Any) {
        processInd.isHidden = false;
        processInd.startAnimating()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerAction), userInfo: nil, repeats: true)
    }
    
    var counter = 0;
    @objc func TimerAction()
    {
        let siguienteVista = self.storyboard?.instantiateViewController(withIdentifier: "ARView") as! ARViewController
        siguienteVista.classroom = room;
        self.present(siguienteVista, animated: true, completion: nil)
        timer.invalidate()
        processInd.stopAnimating()
        processInd.isHidden = true
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let next = segue.destination as! ARViewController;
//        next.classroom = room;
//    }
    

}

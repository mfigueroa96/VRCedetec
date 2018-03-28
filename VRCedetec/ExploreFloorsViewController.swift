//
//  ExploreFloorsViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 18/02/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit

class ExploreFloorsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var floorSegmentedControl: UISegmentedControl!
    
    var mainFloor = [""];
    
    var firstFloor = ["Taller de mecánica", "Sala de computación"],
        secondFloor = ["Salón 2D", "Sala de Audio Digital", "Multimedia"],
        thirdFloor = ["Salón de Multimedia 2"],
        fourthFloor = ["Taller de maderas", "Arquitectura"];
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mainFloor[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainFloor.count;
    }
    
    @IBAction func OnFloorChange(_ sender: Any) {
        switch floorSegmentedControl.selectedSegmentIndex
        {
            case 0:
                mainFloor = firstFloor;
                break;
            case 1:
                mainFloor = secondFloor;
                break;
            case 2:
                mainFloor = thirdFloor;
                break;
            case 3:
                mainFloor = fourthFloor;
                break;
            default: break;
        }
        
        self.pickerView.reloadAllComponents();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainFloor = firstFloor;
        self.pickerView.reloadAllComponents();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GoBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    

//     MARK: - Navigation
//
//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! PreviewViewController
        next.room = mainFloor[pickerView.selectedRow(inComponent: 0)];
        next.floor = floorSegmentedControl.selectedSegmentIndex + 1;
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
    }
}

//
//  ExploreFloorsViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 18/02/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit

class ExploreFloorsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var classrooms = [Classroom]()
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var floorSegmentedControl: UISegmentedControl!
    
    var mainFloor = [Classroom]();
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mainFloor[row].name;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainFloor.count;
    }
    
    @IBAction func OnFloorChange(_ sender: Any) {
        mainFloor.removeAll();
        let origin = floorSegmentedControl.selectedSegmentIndex;
        for room in classrooms
        {
            let floor = Int(room.floor.replacingOccurrences(of: "F-", with: ""));
            if (floor! - 1 == origin)
            {
                mainFloor.append(room)
            }
        }
        
        self.pickerView.reloadAllComponents();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainFloor.removeAll();
        for room in classrooms
        {
            let floor = Int(room.floor.replacingOccurrences(of: "F-", with: ""));
            if (floor! - 1 == 0)
            {
                mainFloor.append(room)
            }
        }
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
        next.room = mainFloor[pickerView.selectedRow(inComponent: 0)]
    }
}

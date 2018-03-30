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
    
    let jsonAddress = "http://199.233.252.86/201811/zenith/cedetec.classrooms.json"
    var classrooms = [Classroom]()
    
    func LoadData()
    {
        let url = URL(string: jsonAddress)
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
                do
                {
                    let rooms = try JSONDecoder().decode([Classroom].self, from: data!)
                    for eachClassroom in rooms {
                        self.classrooms.append(eachClassroom)
                    }
                }
                catch
                {
                    print(error.localizedDescription)
                }
            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutBtn.leftImage = UIImage();
        LoadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let option = sender as! UIButton;
        switch option.tag {
        case 1:
            let next = segue.destination as! ExploreViewController
            next.classrooms = classrooms
            break;
        case 4:
            let next = segue.destination as! SearchViewController
            next.classrooms = classrooms
            break;
        default:
            print("other")
        }
    }


}


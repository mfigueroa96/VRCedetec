//
//  AreaViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 19/02/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit

class AreaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var roomsView: UITableView!
    
    var mainRooms = ["Taller de mecánica", "Taller de termodinámica"];
    var floorSpecs = ["Primer piso", "Segundo piso"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomsView.delegate = self;
        roomsView.dataSource = self;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainRooms.count
    }
    
    var index = 0;
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = roomsView.dequeueReusableCell(withIdentifier: "cell")
        index = indexPath.row;
        cell?.textLabel?.text = mainRooms[indexPath.row];
        cell?.detailTextLabel?.text = floorSpecs[indexPath.row];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let next:PreviewViewController = PreviewViewController()
//        next.floor = String(floorSpecs[indexPath.row])
//        next.room = mainRooms[indexPath.row]
//        self.present(next, animated: true, completion: nil)
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

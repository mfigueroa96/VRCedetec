//
//  ProjectsViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 04/04/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var projectsView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    var index = 0;
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectsView.dequeueReusableCell(withIdentifier: "cell")
        index = indexPath.row;
        cell?.textLabel?.text = projects[indexPath.row].name;
//        print(projects[indexPath.row].name);
        cell?.tag = indexPath.row
        return cell!;
    }
    
    
    var users = [User]();
    var projects = [Project]();

    override func viewDidLoad() {
        super.viewDidLoad()

        projectsView.delegate = self;
        projectsView.dataSource = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func GoBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let next = segue.destination as! ProjectDetailsViewController;
        let cell = sender as! UITableViewCell
        next.project = projects[cell.tag];
    }

}

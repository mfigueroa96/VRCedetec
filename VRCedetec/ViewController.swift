//
//  ViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 17/02/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit

struct Classroom : Decodable
{
    let id : String
    let num : String
    let name : String
    let depts : String
    let details : String
    let tags : String
    let imgs : String
    let floor : String
    let contact : String
    let description : String
}

struct User : Decodable
{
    let userId : String
    let projects : [(Project)]
}

struct Project : Decodable
{
    let name : String
    let status : String
    let resources : [(String)]
    let userId : String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var aboutBtn: DesignableButton!
    
    @IBAction func share(_ sender: Any) {
        
    }
    
    let jsonAddress = "http://199.233.252.86/201811/zenith/"
    var classrooms = [Classroom]()
    var users = [User]()
    
    func LoadData()
    {
        let url = URL(string: "http://199.233.252.86/201811/zenith/cedetec.classrooms.json")
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
            
                for classroom in self.classrooms {
                    print(classroom.id)
                }
        }.resume()
        
        let url2 = URL(string: "http://199.233.252.86/201811/zenith/cedetec.users.json")
        URLSession.shared.dataTask(with: url2!) {
            (data, response, error) in
                do
                {
                    print("Imma here")
                    let users = try JSONDecoder().decode([User].self, from: data!)
                    print("Nowimmahere")
                    for eachUser in users {
                        self.users.append(eachUser);
                        print(eachUser.userId);
                    }
                }
                catch
                {
                    print(error.localizedDescription)
                }
            
            for classroom in self.users {
                print(classroom.userId)
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
        case 6:
            var projects = [Project]();
            for user in users {
                for project in user.projects {
                    projects.append(project);
                }
            }
            
            let next = segue.destination as! ProjectsViewController
            next.users = users;
            next.projects = projects;
        default:
            print("other")
        }
    }


}


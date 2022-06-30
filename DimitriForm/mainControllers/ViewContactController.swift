//
//  ViewContactController.swift
//  DimitriForm
//
//  Created by Kei on 5/19/22.
//

import Foundation
import UIKit

class ViewContactController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var userdata:[UserData] = []
    var status = ""
    var session = ""
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userdata = UserDatabase.getUserDatas()
        self.registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Common.AppUtility.lockOrientation(.landscape)
           // Or to rotate and lock
    //        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       // Don't forget to reset when view is being removed
       Common.AppUtility.lockOrientation(.all)
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "ContactTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "ContactTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as? ContactTableViewCell {
            cell.nameL.text = userdata[indexPath.row].firstname! + " " + userdata[indexPath.row].lastname!;
            cell.primaryL.text = userdata[indexPath.row].primary;
            cell.secondaryL.text = userdata[indexPath.row].secondary;
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "editcontroller") as! EditController
        newViewController.UserId = userdata[indexPath.row].id!
        newViewController.pageinfo = "contact"
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func Backbtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "admincontroller") as! AdminController
        newViewController.session = self.session
        self.present(newViewController, animated: true, completion: nil)
    }
}

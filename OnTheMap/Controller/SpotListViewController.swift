//
//  SpotListViewController.swift
//  OnTheMap
//
//  Created by 강선미 on 26/07/2019.
//  Copyright © 2019 Yoshimi. All rights reserved.
//

import UIKit

class SpotListViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var addSpotButton: UIBarButtonItem!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var studentLocArray = [StudentLocation]()
    var recordNum: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.recordNum = StudentsLocationData.studentsData.count
        // Sorting students location array
        studentLocArray.append(contentsOf: StudentsLocationData.studentsData.sorted(by: {$0.updatedAt > $1.updatedAt}))
        
    }
    
    @IBAction func addSpotTapped(_ sender: Any) {
        
        activityIndicator.startAnimating()
        let alertVC = UIAlertController(title: "Warning!", message: "You've already put your pin on the map.\nWould you like to overwrite it?", preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [unowned self] (_) in
            self.performSegue(withIdentifier: "addSpot", sender: true)
        }))
        
        alertVC.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
      
        present(alertVC, animated: true, completion: nil)
        activityIndicator.stopAnimating()
    }
    
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "addSpot" {

            let controller = segue.destination as! FindSpotViewController

        }
    }

    

}
extension SpotListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")!
        
        cell.textLabel?.text = studentLocArray[indexPath.row].firstName + " " + studentLocArray[indexPath.row].lastName
        cell.detailTextLabel?.text = studentLocArray[indexPath.row].mediaURL
        cell.imageView?.image = UIImage(named: "icon_pin")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = UIApplication.shared
        app.open(URL(string: studentLocArray[indexPath.row].mediaURL) ?? URL(string: "")!, options: [:], completionHandler: nil)
    }
    
}

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
  
    @IBOutlet weak var tableView: UITableView!
    
    var studentLocArray = [StudentLocation]()
    var recordNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UdacityClient.getStudentLocation(singleStudent: false, completion:{ (data, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "")
                return
            }
            StudentsLocationData.studentsData = data
            self.recordNum = StudentsLocationData.studentsData.count
            self.tableView.reloadData()
 
        })
        //recordNum = StudentsLocationData.studentsData.count

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addSpotTapped(_ sender: Any) {
        let alertVC = UIAlertController(title: "Warning!", message: "You've already put your pin on the map.\nWould you like to overwrite it?", preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [unowned self] (_) in
            self.performSegue(withIdentifier: "addSpot", sender: true)
        }))
        
        alertVC.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        
        present(alertVC, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
extension SpotListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentsLocationData.studentsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentSpotCell")!
        
        let studentSpot = StudentsLocationData.studentsData[indexPath.row]
        
        cell.textLabel?.text = studentSpot.firstName + " " + studentSpot.lastName
        cell.detailTextLabel?.text = studentSpot.mediaURL
        cell.imageView?.image = UIImage(named: "icon_pin")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = UIApplication.shared
        app.open(URL(string: StudentsLocationData.studentsData[indexPath.row].mediaURL) ?? URL(string: "")!, options: [:], completionHandler: nil)
    }
    
}

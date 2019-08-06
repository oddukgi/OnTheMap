//
//  MapViewController.swift
//  OnTheMap
//
//  Created by 강선미 on 26/07/2019.
//  Copyright © 2019 Yoshimi. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshMap(animated)
    }
    
    @IBAction func refreshMap(_ sender: Any) {
        pullData()
        
    }
    

    @IBAction func addSpotTapped(_ sender: Any) {
    
        activityIndicator.startAnimating()
        let alertVC = UIAlertController(title: "Warning!", message: "You've already put your pin on the map.\nWould you like to overwrite it?", preferredStyle: .alert)
        
        UdacityClient.getStudentLocation(singleStudent: false, completion:{ (data, error) in
            
            guard let data = data else {
                print(error?.localizedDescription ?? "")
                return
            }
            if data.count > 0 {
            alertVC.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [unowned self] (_) in
                self.performSegue(withIdentifier: "addSpot",  sender: (true, data))
            }))
        
            alertVC.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
           } else {
                self.performSegue(withIdentifier: "addPin", sender: (false, []))

            }
            
        })
        self.activityIndicator.stopAnimating()
    }

    
    func pullData() {
        runActivityIndicator(true)
        UdacityClient.getStudentLocation(singleStudent: false, completion:{ (data, error) in
          
             guard let data = data else {
                 print(error?.localizedDescription ?? "")
                 return
             }
             DispatchQueue.main.async {
                StudentsLocationData.studentsData = data
                self.copyData()
            }
               self.runActivityIndicator(false)
        })
    }
    
    func copyData() {
        self.annotations.removeAll()
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        for val in StudentsLocationData.studentsData {
         self.annotations.append(val.getMapAnnotation())
        }
        self.mapView.addAnnotations(self.annotations)
        
        
    }
    
    func alert(_ title: String, _ messageBody: String) {
        
        let alert = UIAlertController(title: title, message: messageBody, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSpot" {
            let destinationVC = segue.destination as? FindSpotViewController
            let updateStudentInfo = sender as? (Bool, [StudentLocation])
            destinationVC?.updatePin = updateStudentInfo?.0
            destinationVC?.studentArray = updateStudentInfo?.1
        }
    }
    func runActivityIndicator(_ bflag: Bool) {
        if bflag {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIButton
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            
            guard let annotation = view.annotation else {
                return
            }
            guard var subtitle = annotation.subtitle else {
                return
            }
            if subtitle!.isValidURL {
                if subtitle!.starts(with: "www") {
                    subtitle! = "https://" + subtitle!
                }
                let url = URL(string: subtitle!)
                UIApplication.shared.open(url!)
            } else {
                
                alert("No URL", "There's no URL to open")
            }
        }
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        _ = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
    }
    
}
extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}

extension StudentLocation  {
    func getMapAnnotation() -> MKPointAnnotation {
        let mapAnnotation = MKPointAnnotation()
        mapAnnotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        mapAnnotation.title = "\(firstName) \(lastName)"
        mapAnnotation.subtitle = "\(mediaURL)"
        
        return mapAnnotation
    }
}



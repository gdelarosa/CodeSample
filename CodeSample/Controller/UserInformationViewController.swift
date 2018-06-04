//
//  UserInformationViewController.swift
//  CodeSample
//
//  Created by Gina De La Rosa on 5/30/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//  Displays user information from the JSONPlaceholder API

import UIKit
import MapKit
import CoreLocation

struct UserInformation: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat, lng: String
}

struct Company: Codable {
    let name, catchPhrase, bs: String
}

class UserInformationViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var suite: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var zip: UILabel!
    @IBOutlet weak var userWebsite: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDatafromAPI()
    }
    
    /* Redirects to URL link after clicking */
    @IBAction func websiteAction(_ sender: Any) {
        guard
            let url = URL(string: "https://www.abtei-st-hildegard.de/hildegard-von-bingen/")
            else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    /**
     Returns the fetched API data from JSONPlaceholder and displays basic user information.
    */
    func fetchDatafromAPI() {
      
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/1") else { return }
        URLSession.shared.dataTask(with: url) {
            (data, response , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(UserInformation.self, from: data)
                
                DispatchQueue.main.async {
                    self.userName.text = userData.name
                    self.userWebsite.text = userData.website
                    self.street.text = userData.address.street
                    self.suite.text = userData.address.suite
                    self.city.text = userData.address.city
                    self.zip.text = userData.address.zipcode
                    
                    /* Add pin to map from coordinates returned from JSON */
 
                    let latitude = (userData.address.geo.lat as NSString).doubleValue
                    let longitude = (userData.address.geo.lng as NSString).doubleValue
                    let location = CLLocationCoordinate2DMake(latitude, longitude)
                    let span = MKCoordinateSpanMake(10.0, 10.0)
                    let region = MKCoordinateRegionMake(location, span)
                    self.map.setRegion(region, animated: true)
                    let annotation = MKPointAnnotation()
                    annotation.title = "-37.3159, 81.1496"
                    annotation.coordinate = location
                    self.map.addAnnotation(annotation)
                }
                print(userData)
            } catch let error {
                print("Error", error)
            }
            }.resume()
    }
}


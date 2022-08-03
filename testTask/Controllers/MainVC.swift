//
//  MainVC.swift
//  testTask
//
//  Created by evilb on 30.07.2022.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MainPresenterDelegate {

    
    
    var cities = [CityModel]()
    var filteredCities: [CityModel]!
    
    private let presenter = MainPresenter()
    
    var lon: Double = 0
    var lat: Double = 0
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        presenter.setDelegate(delegate: self)
        presenter.fetchingInfo()
        searchBar.delegate = self
        filteredCities = cities
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell

        cell.setCells(city: filteredCities[indexPath.row].name, index: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lon = cities[indexPath.row].coord.lon
        lat = cities[indexPath.row].coord.lat
        
        presenter.presentDetailController(identifier: "showDetail")
    }
    
    func presentCity(city: [CityModel]) {
        self.cities = city
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as! DetailVC
            vc.lat = lat
            vc.lon = lon
        }
    }
    
//    MARK: Search Bar Config
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCities = []
        
        if searchText == "" {
            filteredCities = cities
        } else {
            for city in cities {
                if city.name.lowercased().contains(searchText.lowercased()) {
                    filteredCities.append(city)
                }
            }
        }
        
        self.tableView.reloadData()
    }

}


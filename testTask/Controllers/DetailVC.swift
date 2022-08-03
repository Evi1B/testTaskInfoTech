//
//  DetailVC.swift
//  testTask
//
//  Created by evilb on 30.07.2022.
//

import UIKit
import MapKit

class DetailVC: UIViewController, UIScrollViewDelegate, DetailPresenterDelegate {
    
    var weather = [WeatherModel]()
    
    @IBOutlet weak var mapView: MKMapView!
    let annotation = MKPointAnnotation()
    
    @IBOutlet weak var descriptoinLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var minAirLabel: UILabel!
    @IBOutlet weak var maxAirLabel: UILabel!
    @IBOutlet weak var airHumindityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var headerHeightContstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    let scrollTopEdgeInsets: CGFloat = 200
    
    var lat: Double?
    var lon: Double?
    
    private let presenter = DetailPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.layer.masksToBounds = true
        scrollView.contentInset = UIEdgeInsets(top: scrollTopEdgeInsets, left: 0, bottom: 0, right: 0)
        presenter.setDelegate(delegate: self)
        presenter.fetchingInfo(lat: lat!, lon: lon!)
        
        setMap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setLabels()
        print(weather)
    }
    
    private func setLabels() {
        self.descriptoinLabel.text = "Опис:\n\(self.weather[0].weather[0].description)"
        self.currentTempLabel.text = "Поточна температура: \(self.weather[0].main.temp) ℃"
        self.minAirLabel.text = "Мін. повітря: \(self.weather[0].main.temp_min) 💨"
        self.maxAirLabel.text = "Макс. повітря: \(self.weather[0].main.temp_max) 💨"
        self.airHumindityLabel.text = "Вологість: \(self.weather[0].main.humidity) 💧"
        self.windSpeedLabel.text = "Швидкість повітря: \(self.weather[0].wind.speed) 🌬"
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let minHeight:CGFloat = 0
        let maxHeight:CGFloat = 200+minHeight
        let yPos = scrollView.contentOffset.y
        let newHeaderViewHeight = (maxHeight - yPos)-(maxHeight-minHeight)
        let tempNewHeaderViewHeight = (maxHeight - yPos)-(maxHeight-minHeight)
        
        if (newHeaderViewHeight > maxHeight) {
            headerHeightContstraint.constant = (max(tempNewHeaderViewHeight, maxHeight)+(minHeight/2))
        } else {
            headerHeightContstraint.constant = (max(newHeaderViewHeight, minHeight)+(minHeight/2))
        }
    }
    
    private func setMap() {
        let initialLocation = CLLocation(latitude: lat ?? 0, longitude: lon ?? 0)
        mapView.centerToLocation(initialLocation)
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat ?? 0, longitude: lon ?? 0)
        mapView.addAnnotation(annotation)
    }
    
    func presentWeather(weather: WeatherModel) {
        self.weather = [weather]
    }
    
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

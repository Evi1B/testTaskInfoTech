//
//  Presenter.swift
//  testTask
//
//  Created by evilb on 02.08.2022.
//

import Foundation
import UIKit

protocol MainPresenterDelegate: Any {
    func presentCity(city: [CityModel])
}

typealias PresenterDelegate = MainPresenterDelegate & UIViewController

class MainPresenter {
    
    weak var delegate: PresenterDelegate?
    
    public func fetchingInfo() {
        guard let path = Bundle.main.path(forResource: "city_list", ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            
            let city = try JSONDecoder().decode([CityModel].self, from: data)
            self.delegate?.presentCity(city: city)
        } catch {
            print("Parse Error")
        }
        
    }
    
    public func presentDetailController(identifier: String) {
        delegate?.performSegue(withIdentifier: identifier, sender: self)
    }
    
    public func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
}

protocol DetailPresenterDelegate: Any {
    func presentWeather(weather: WeatherModel)
}

typealias DetailDelegate = DetailPresenterDelegate & UIViewController

class DetailPresenter {
    
    weak var delegate: DetailDelegate?
    
    public func fetchingInfo(lat: Double, lon: Double) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=109a5407557dce27ce24905c1ee75884&units=metric") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data , _, error in
            guard let data = data, error == nil else { return }
            do {
                let weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
                self?.delegate?.presentWeather(weather: weatherData)
                print(weatherData)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    public func setDelegate(delegate: DetailDelegate) {
        self.delegate = delegate
    }
    
}

//
//  WeatherViewController.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/12/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var tadayLabel: UILabel!
    @IBOutlet weak var todayCollectionView: UICollectionView!
    
    @IBOutlet weak var nextDaysLabel: UILabel!
    @IBOutlet weak var nextDaysCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBt: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    var locationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        todayCollectionView.dataSource = self
        nextDaysCollectionView.dataSource = self
        registerCell()
        setupLocationManager()
        getCurrentWeater(lat: latitude ?? Settings.YEREVAN.latitude.rawValue,
                         lon: longitude ?? Settings.YEREVAN.longitude.rawValue)
    }
    
    // MARK: - Setups
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Inits
    func initWeatherView(weather: Weather, main: Main, name: String?) {
        if let humidity = main.humidity {
            self.humidityLabel.text = "Humidity: \(humidity) %"
        }
        if let minTemp = main.tempMin {
            self.minTempLabel.text = "Min Temp: \(minTemp) º"
        }
        if let maxTemp = main.tempMax {
            self.maxTempLabel.text = "Max Temp: \(maxTemp) º"
        }
        if let pressure = main.pressure {
            self.pressureLabel.text = "Pressure: \(pressure)"
        }
        if let temp = main.temp {
            self.weatherLabel.text = "\(temp) º"
        }
        
        self.cityLabel.text = name
        self.weatherDescriptionLabel.text = weather.description
    }
    
    // MARK: - Registers
    private func registerCell() {
        let nib = UINib(nibName: WeatherCollectionViewCell.name, bundle: nil)
        todayCollectionView.register(nib, forCellWithReuseIdentifier: WeatherCollectionViewCell.id)
        nextDaysCollectionView.register(nib, forCellWithReuseIdentifier: WeatherCollectionViewCell.id)
    }
    
    // MARK: - Actions
    @IBAction func searchBtAction(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Server request
    func getCurrentWeater(lat: Double, lon: Double) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        WeatherService.shered.weatherResponse(appid: Settings.Weather.ApiKey, lat: lat, lon: lon, units: Settings.WeatherType.Metric.rawValue) { (weaterResponseData) in
            switch weaterResponseData {
            case .base(response: let baseResposne):
                CheckBaseHelper.checkBaseResponse(baseResposne, viewController: self)
            case .success(let resultsData):
                guard let weather = resultsData.weather, weather.count >= 1 else {return}
                guard let main = resultsData.main else {return}
                self.initWeatherView(weather: weather[0], main: main, name: resultsData.name)
            case .isOffline:
                return
            }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WeatherViewController:  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == todayCollectionView {
            return 13
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let todayCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.id, for: indexPath) as? WeatherCollectionViewCell
        let nextDaysCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.id, for: indexPath) as? WeatherCollectionViewCell
        
        if collectionView == todayCollectionView {
            return todayCollectionViewCell ?? UICollectionViewCell()
        } else {
            return nextDaysCollectionViewCell ?? UICollectionViewCell()
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            let locValue = location.coordinate
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            latitude = locValue.latitude
            longitude = locValue.longitude
        }
    }
}

//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!

    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    @IBAction func btnSearchTapped(_ sender: Any) {
        searchTextField.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something..."
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = textField.text {
            weatherManager.fetchWeather(cityName: cityName)
        }

        searchTextField.text = ""
        searchTextField.placeholder = "Search"
    }
}

// MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {

    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
        }
    }

    func didFailWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print(location.coordinate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

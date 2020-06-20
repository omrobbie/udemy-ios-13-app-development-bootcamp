//
//  WeatherManager.swift
//  Clima
//
//  Created by omrobbie on 19/06/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {

    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
}

struct WeatherManager {

    var delegate: WeatherManagerDelegate?

    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=c2818357c736d789a6086696fc8d9b30&units=metric"

    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        if let url =  URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                if let data = data {
                    if let weather = self.parseJSON(data) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }.resume()
        }
    }

    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()

        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodeData.name
            let temp = decodeData.main.temp
            let weatherId = decodeData.weather[0].id

            let weather = WeatherModel(conditionId: weatherId, cityName: name, temperature: temp)
            return weather
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

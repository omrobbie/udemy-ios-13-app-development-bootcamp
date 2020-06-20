//
//  WeatherManager.swift
//  Clima
//
//  Created by omrobbie on 19/06/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {

    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {

    var delegate: WeatherManagerDelegate?

    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=c2818357c736d789a6086696fc8d9b30&units=metric"

    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
    }

    func performRequest(urlString: String) {
        if let url =  URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                if let data = data {
                    if let weather = self.parseJSON(weatherData: data) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }.resume()
        }
    }

    func parseJSON(weatherData: Data) -> WeatherModel? {
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

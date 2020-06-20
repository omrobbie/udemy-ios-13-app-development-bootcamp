//
//  WeatherManager.swift
//  Clima
//
//  Created by omrobbie on 19/06/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {

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
                    self.parseJSON(weatherData: data)
                }
            }.resume()
        }
    }

    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()

        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodeData.name)
            print(decodeData.main.temp)
            print(decodeData.weather[0].id)
            print(getConditionName(weatherId: decodeData.weather[0].id))
        } catch {
            print(error.localizedDescription)
        }
    }

    func getConditionName(weatherId: Int) -> String {
        switch weatherId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

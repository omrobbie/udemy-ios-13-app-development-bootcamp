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
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            task.resume()
        }
    }

    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }

        if let data = data {
            let dataString = String(data: data, encoding: .utf8)
            print(dataString)
        }
    }
}

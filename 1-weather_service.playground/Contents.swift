/*
 This file contains unfinished Weather Service class that's responsible for fetching weather data for a specific city.
 A stubbed network service is provided that simulates a network request with controllable behavior.

 Goals:
 • Complete weather service networking.
 • Implement caching.

 Bonus round:
 • Refactor callback-based code to Swift Concurrency
 */

import Foundation
import PlaygroundSupport

// MARK: - Playground Setup

PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - Models

struct Weather: Codable {
    let temperature: Double
    let condition: String
    let city: String
}


// MARK: - Network Service

/// Stubs network request, follows behavior defined in constructor. Simulates correct request, network error, or invalid data
class StubNetworkService {
    enum Behavior {
        case success
        case networkError
        case incorrectData
    }

    enum StubError: Error {
        case simulatedError
    }

    let behavior: Behavior

    init(behavior: Behavior) {
        self.behavior = behavior
    }

    func performRequest(with url: URL, completion: @escaping @Sendable (Result<Data, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [behavior] in
            switch behavior {
            case .success:
                var city = "Unknown"
                if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                   let cityQuery = components.queryItems?.first(where: { $0.name == "city" })?.value {
                    city = cityQuery
                }

                let jsonString = """
                {
                    "temperature": 18.0,
                    "condition": "Sunny",
                    "city": "\(city)"
                }
                """

                let data = jsonString.data(using: .utf8)!
                completion(.success(data))

            case .networkError:
                completion(.failure(StubError.simulatedError))

            case .incorrectData:
                let jsonString = """
                {
                    "temp": 999,
                    "desc": "Unknown"
                }
                """
                let data = jsonString.data(using: .utf8)!

                completion(.success(data))
            }
        }
    }
}

// MARK: - Weather Service

class WeatherService {
    private let networkService: StubNetworkService

    init(networkService: StubNetworkService) {
        self.networkService = networkService
    }

    func fetchWeather(for city: String, completion: @escaping @Sendable (Result<Weather, Error>) -> Void) {
        // Example: let url = URL(string: "https://api.example.com/weather?city=\(city)")!
        fatalError("fetchWeather not implemented")
    }
}

// MARK: - Testing

func fetchWeather(_ behavior: StubNetworkService.Behavior) {
    let networkService = StubNetworkService(behavior: behavior)
    let weatherService = WeatherService(networkService: networkService)

    weatherService.fetchWeather(for: "New York") { result in
        switch result {
        case .success(let weather):
            print("Fetched weather for \(weather.city): \(weather.temperature)°, \(weather.condition)")

        case .failure(let error):
            print("Error fetching weather: \(error)")
        }
    }
}

fetchWeather(.success)
//fetchWeather(.incorrectData)
//fetchWeather(.networkError)


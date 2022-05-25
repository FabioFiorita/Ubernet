//
//  ProvidersViewModel.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 24/05/22.
//

import Foundation

class ProvidersViewModel: ObservableObject {
    @Published var plans: [Plan] = []
    @Published var installers: [Installer] = []
    
    func fetchPlans() {
        guard let url = URL(string: "https://app-challenge-api.herokuapp.com/plans") else {return}
        url.getResult { (result: Result<[Plan], Error>) in
            switch result {
            case let .success(plans):
                DispatchQueue.main.async {
                    self.plans = plans
                }
                print(plans)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    func fetchPlan(state: String) {
        let str = "?state=\(state)"
        guard let url = URL(string: "https://app-challenge-api.herokuapp.com/plans\(str)") else {return}
        url.getResult { (result: Result<[Plan], Error>) in
            switch result {
            case let .success(plans):
                DispatchQueue.main.async {
                    self.plans = plans
                }
                print(plans)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func fetchPlan(installerID: Int) {
        let str = "?installer=\(installerID)"
        guard let url = URL(string: "https://app-challenge-api.herokuapp.com/plans\(str)") else {return}
        url.getResult { (result: Result<[Plan], Error>) in
            switch result {
            case let .success(plans):
                DispatchQueue.main.async {
                    self.plans = plans
                }
                print(plans)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func fetchInstallers() {
        guard let url = URL(string: "https://app-challenge-api.herokuapp.com/installers") else {return}

        url.getResult { (result: Result<[Installer], Error>) in
            switch result {
            case let .success(installers):
                DispatchQueue.main.async {
                    self.installers = installers
                }
                print(installers)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func fetchInstaller(planID: Int) {
        let str = "?plan=\(planID)"
        guard let url = URL(string: "https://app-challenge-api.herokuapp.com/installers\(str)") else {return}
        url.getResult { (result: Result<[Installer], Error>) in
            switch result {
            case let .success(installers):
                DispatchQueue.main.async {
                    self.installers = installers
                }
                print(installers)
            case let .failure(error):
                print(error)
            }
        }
    }
}


extension JSONDecoder {
    static let shared: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}

extension Data {
    func decodedObject<T: Decodable>() throws -> T {
        try JSONDecoder.shared.decode(T.self, from: self)
    }
}

extension URL {
    func getResult<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: self) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                completion(.success(try data.decodedObject()))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

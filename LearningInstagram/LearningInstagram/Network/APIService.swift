//
//  APIService.swift
//  LearningInstagram
//
//  Created by Lakshmi Ranganatha Hema on 28/03/24.
//

import Foundation
import Combine

enum APIError: Error {
    case requestFailed
    case invalidData
    case badURL
}
struct HttpData<Data: Decodable> {
    public let response: HTTPURLResponse
    public let data: Data?
}

class APIService<Model: Decodable>: ObservableObject {
    @Published private(set) var result: Result<Model, Error>?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://8e83981122504f39b0e37a63f1a71230.api.mockbin.io/") else {
            self.result = .failure(APIError.requestFailed)
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.result = .failure(error)
                case .finished:
                    break
                }
            } receiveValue: { httpData in
                if let parsedData = try? JSONDecoder().decode(Model.self, from: httpData.data) {
                    self.result = .success(parsedData)
                }
            }
            .store(in: &cancellables)
    }
}

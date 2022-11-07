//
//  NetworkManager.swift
//  HomeTestProject
//
//  Created by Rafael Ribeiro on 05.11.22.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Codable>(
        methodType: MethodType = .GET,
        _ absoluteURL: String,
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: absoluteURL) else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
        
        let request = buildRequest(from: url, methodType: methodType)

        let data = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let res = try decoder.decode(T.self, from: data)
                completion(.success(res))
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
        }
        
        data.resume()
    }
    
    func request(
        methodType: MethodType = .GET,
        _ absoluteURL: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard let url = URL(string: absoluteURL) else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
        
        let request = buildRequest(from: url, methodType: methodType)
        
        let data = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            completion(.success(()))
        }

        data.resume()
    }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

extension NetworkingManager.NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "URL ins't valid"
        case .invalidStatusCode:
            return "Status code fails into the wrong range"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode:
            return "Fail to decode"
        case .custom(let error):
            return "Something went wrong \(error.localizedDescription)"
        }
    }
}

extension NetworkingManager {
    enum MethodType {
        case GET
        case POST(data: Data?)
    }
}

private extension NetworkingManager {
    func buildRequest(from url: URL, methodType: MethodType) -> URLRequest {
        var request = URLRequest(url: url)

        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }

        return request
    }
}

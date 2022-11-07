//
//  Endpoint.swift
//  HomeTestProject
//
//  Created by Rafael Ribeiro on 07.11.22.
//

import Foundation

enum Endpoint {
    case people
    case detail(id: Int)
    case create(submissionData: Data?)
}

extension Endpoint {
    var host: String { "reqres.in" }
    
    var path: String {
        switch self {
        case .people,
             .create:
            return "/api/users"
        case .detail(let id):
            return "/api/users/\(id)"
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .people,
             .detail:
            return .GET
        case .create(let data):
            return .POST(data: data)
        }
    }
}

extension Endpoint {
    enum MethodType {
        case GET
        case POST(data: Data?)
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = host
        urlComponent.path = path

        #if DEBUG
        urlComponent.queryItems = [
            URLQueryItem(name: "delay", value: "1")
        ]
        #endif

        return urlComponent.url
    }
}

//
//  NetworkManager.swift
//  MovieLists
//
//  Created by Ferhat Şayık on 31.07.2025.
//

import Foundation

enum APIError: Error {
    case urlSessionError(String)
    case serverError(String = "Invalid API Key")
    case invalidResponse(String = "Invalid response from server.")
    case decodingError(String = "Error parsing server response.")
}


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    init (){}
    
    @discardableResult
    func download(url: URL, completion: @escaping (Result<Data, Error>) -> ()) -> URLSessionDataTask {
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data = data else {
                
                completion(.failure(URLError(.badURL)))
                return
            }
            
            completion(.success(data))
        }
        dataTask.resume()
        return dataTask
    }
    
}


//
//  asd.swift
//  MovieLists
//
//  Created by Ferhat Şayık on 3.08.2025.
//

import Foundation

final class NetworkManager2 {
 
    let url = URL(string: "https://api.themoviedb.org/3/person/popular")!
    var components = URLComponents(url: self.url, resolvingAgainstBaseURL: true)!
    let queryItems: [URLQueryItem] = [
      URLQueryItem(name: "language", value: "en-US"),
      URLQueryItem(name: "page", value: "1"),
    ]
    components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

    var request = URLRequest(url: components.url!)
    request.httpMethod = "GET"
    request.timeoutInterval = 10
    request.allHTTPHeaderFields = [
      "accept": "application/json",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ODQ2YjdjZTVkMmM2NWFlMjg4MmNjZmQwOGVmMWRmZSIsIm5iZiI6MTc1Mzk2NzYyNy41NzUsInN1YiI6IjY4OGI2YzBiMWM4NjRkNWEzYzA5ZGRlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.n-q-Go2wfpVTFuHyLZ0MpDVcHYq6Jk80zB3COeKKdxc"
    ]

    let (data, _) = try await URLSession.shared.data(for: request)
    print(String(decoding: data, as: UTF8.self))
    
}

//
//  APIManager.swift
//  DemoTask
//
//  Created by MacMini-dev on 24/05/23.
//

import UIKit
// MARK: - DataError
enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case error(_ error: Error?)
}

// MARK: - APIManager Class
final class APIManager {
    static let shared = APIManager()
    private init() {}
    typealias Handler = (Result<[AuthorModel], DataError>) -> Void
    
//    func fetchAuthorsData(completion: @escaping Handler) {
//        guard let url = URL(string: Constant.API.authorUrl) else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data, error == nil else {
//                completion(.failure(.invalidData))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse,
//                    200...299 ~= response.statusCode else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//
//            do {
//                let authors = try JSONDecoder().decode([AuthorModel].self, from: data)
//                completion(.success(authors))
//            } catch {
//                completion(.failure(.error(error)))
//            }
//
//        }.resume()
//    }
    
    func requestAuthors<T: Decodable>(url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw DataError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw DataError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}

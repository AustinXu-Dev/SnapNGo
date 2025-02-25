//
//  APIManager.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/3.
//

import Foundation

protocol APIManager: AnyObject {
    associatedtype ModelType: Codable
    var methodPath: String { get }
}

extension APIManager {
    
    // MARK: - Adding a route to a Default Main Route of an API
    var url: URL {
        let urlString = "https://snap-n-go.vercel.app/api" + methodPath
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        return url
    }
    
    // MARK: - Execution of API, compatable with all methods
    func execute(data: Codable? = nil, getMethod: String? = nil, token: String? = nil, completion: @escaping(Result<ModelType, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        
        if let method = getMethod {
            request.httpMethod = method
        }
        
        //MARK: - Post, Put, PATCH
        if let data = data, getMethod == "POST" || getMethod == "PUT" || getMethod == "PATCH"{
            do{
                let jsonData = try JSONEncoder().encode(data)
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                print("Error encoding header: \(error)")
                completion(.failure(error))
                return
            }
        }
        
        // MARK: - Header
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print(error)
                print("In API manager: ", error.localizedDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                print("In API Manager: ",httpResponse.statusCode, httpResponse.statusCode.description)
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
//            if getMethod == "POST" || getMethod == "PUT" {
//                return
//            }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(formatter)
            //MARK: - Get and Delete
            if let responseData = data {
                print("API Manager",responseData)
                do {
                    let decodeData = try decoder.decode(ModelType.self, from: responseData)
                    print("api manager: ", decodeData)
                    completion(.success(decodeData))
                } catch let decodingError as DecodingError {
                    print("‼️ Decoding Error: \(decodingError)")
                    
                    switch decodingError {
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context.debugDescription)")
                    case .keyNotFound(let key, let context):
                        print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
                    case .typeMismatch(let type, let context):
                        print("Type mismatch for \(type): \(context.debugDescription)")
                    case .valueNotFound(let type, let context):
                        print("Value of type \(type) was expected but not found: \(context.debugDescription)")
                    @unknown default:
                        print("Unknown decoding error")
                    }
                    
                    completion(.failure(decodingError))
                }
                catch {
                    completion(.failure(error))
                }
            } else if getMethod == "DELETE" && (200...299).contains(httpResponse.statusCode) {
                do {
                    let decodeData = try decoder.decode(ModelType.self, from: Data())
                    completion(.success(decodeData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

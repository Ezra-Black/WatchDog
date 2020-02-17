//
//  NetworkManager.swift
//  Watch Dog
//
//  Created by Nick Nguyen on 2/16/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation

enum HTTPMethod : String {
    case get = "GET"
    case post = "POST"
}
enum NetworkError: Error {
    case badUrl
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
    case badImage
}


class DogController {
    
    let baseURL = URL(string: "https://dog.ceo/api")!
    
    var dogs : [Dog]  = []
    
    func fetchAllDogsImage(completion: @escaping (Result<[Dog],NetworkError>) -> Void) {
        let allDogsURL = baseURL.appendingPathComponent("breeds/image/random")
        print(allDogsURL)
        var request = URLRequest(url: allDogsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error receiving dogs image data : \(error)" )
                completion(.failure(NetworkError.badUrl))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetworkError.otherError))
                
                return
            }
          
            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let image = try decoder.decode(Dog.self, from: data)
                self.dogs.append(image)
                completion(.success(self.dogs))
            } catch let error {
                print(error)
            }
     
        }.resume()
        
    }
    
    func performSearchBreed(searchTerm: String, completion: @escaping (Result<[Dog],NetworkError>) -> Void ) {
        let breedURL = baseURL.appendingPathComponent("/breed/\(searchTerm)/images/random")
        print(breedURL)
        var request = URLRequest(url: breedURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                return
            }
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            do {
                let breedImage = try decoder.decode(Dog.self, from: data)
                self.dogs.append(breedImage)
                completion(.success(self.dogs))
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}






























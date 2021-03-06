//
//  RMNetworkManager.swift
//  RickAndMorty
//
//  Created by Felix Alexander Sotelo Quezada on 30-03-21.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString,UIImage>()
    private init(){}
    
    func getAllCharacters(page: Int, completed: @escaping (Result<[Character], RMErrors>) -> Void) {
        
        let url = Constants.RMUrl.apiUrl + "/character?page=\(page)"
        
        guard let apiUrl = URL(string: url) else {
            completed(.failure(.unableToComplete))
            return
            
        }
            let session = URLSession.shared
            let task = session.dataTask(with: apiUrl) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                
                let characters = try decoder.decode(ListOfCharacters.self, from: data)
                
                completed(.success(characters.results))
                
            }catch{
                completed(.failure(.invalidResponse))
            }
        }
            
        task.resume()

        }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void)  {
         let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
    
    }




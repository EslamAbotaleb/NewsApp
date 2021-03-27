//
//  StoreClient.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit


class NewsServiceApi {
    
    static let shared = NewsServiceApi()
    private let router = Router<StoreAPI>()
    let cache = NSCache<NSString,UIImage>()
    
    func getAllSources(completion: @escaping (Result<AllSourceModel,StoreError>) -> Void){
        router.request(.allSources) { (data, response, error) in
            
            if error != nil {
                completion(.failure(.connectionError))
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidDate))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let categories = try decoder.decode(AllSourceModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(categories))

                }
            }
            catch{
                completion(.failure(.decodeError))
            }
        }
    }
    
    func getTopHeadline(country: String, category: String, completion: @escaping (Result<TopHeadLineModel,StoreError>) -> Void){
        router.request(.topHeadline(country: country, category: category)) { (data, response, error) in
            
            if error != nil {
                completion(.failure(.connectionError))
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidDate))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let topHeadline = try decoder.decode(TopHeadLineModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(topHeadline))

                }
            }
            catch{
                completion(.failure(.decodeError))
            }
        }
    }
    
   
    
    
    
    
    func downloadImage(from stringURL:String , completed: @escaping (UIImage?) -> Void) {
        let imageKey = NSString(string: stringURL)
        
        if let image = cache.object(forKey: imageKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: stringURL) else {
            completed(nil)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self ,
                error == nil ,
                let response = response as? HTTPURLResponse ,
                response.statusCode == 200 ,
                let data = data ,
                let image = UIImage(data: data)
                else {
                    
                    completed(nil)
                    return
            }
            self.cache.setObject(image, forKey: imageKey)
            completed(image)
        }
        
        dataTask.resume()
    }
}

//
//  NetworkManager.swift
//  AdvaitFoundationDemo
//
//  Created by Gopu on 05/05/24.
//

import Foundation

enum HttpMethod:String {
    case get = "GET"
    case post = "POST"
}


class NetworkManager {
    
    static var shared = NetworkManager()
    
    private init() { }
    
    func request(url:URL,method:HttpMethod,params:[String:Any]?,completion:@escaping(Result<Data,Error>)->Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = params {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters,options: [])
            }catch {
                completion(.failure(error))
                return
            }
        }
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            
            guard let httpResponse = response else {
                let unknownErr = NSError(domain: "UnknownEror", code: 0, userInfo: nil)
                completion(.failure(unknownErr))
                return
            }
            
            guard let data = data else {
                let unknownErr = NSError(domain: "UnknownEror", code: 0, userInfo: nil)
                completion(.failure(unknownErr))
                return
            }     
            
            completion(.success(data))
        }
        task.resume()
        
    }
    
    
    
    
}

//
//  ImageGridViewModel.swift
//  AdvaitFoundationDemo
//
//  Created by Gopu on 05/05/24.
//

import Foundation
import UIKit



class ImageGridViewModel {
    
    private let neteorkManager:NetworkManager
    private let decoder = JSONDecoder()

   
    init(neteorkManager: NetworkManager = NetworkManager.shared) {
        self.neteorkManager = neteorkManager
    }
    
    
    func fetchImgData(completion: @escaping (Result<(data: Data, model: ImageGridResponse), Error>) -> Void) {
        guard  let urlReq = URL(string: ClientUrl.imageUrl) else { return }
        neteorkManager.request(url: urlReq, method: .get, params: nil) { result in
            switch result {
            case .success(let resultData):
                do {
                    let decodedData = try self.decoder.decode(ImageGridResponse.self,from: resultData)
                    print("decodeData=\(decodedData)")
                    completion(.success((resultData, decodedData)))

                } catch {
                    completion(.failure(error))

                }
                    
            case .failure(let err):
                completion(.failure(err))


            }
           
        }
        
    }
    
    
    
    
    
    
}

//
//  NetworkManager.swift
//  mars
//
//  Created by mars uzhanov on 03.03.2024.
//

import Foundation
import UIKit

protocol NetworkManagerDelegate {
    func didUpdateBooks(with results: [Books.Items])
//    func loadMoreBooks(with results: [Books.Items])
    func didFailWithError(_ error: Error)
}

final class APICaller {
    
    static let shared = APICaller()
    
    var delegate: NetworkManagerDelegate?
    let urlString = "\(K.apiUrl)key=\(K.apiKey)"
    
    func fetchBooks(query: String) {
        let urlString = "\(urlString)&q=\(query)"
        request(with: urlString)
    }
    
    func fetchBooks(query: String, page: Int) {
//        print(page)
        let urlString = "\(urlString)&q=\(query)&startIndex=\(page * 2)"
        request(with: urlString)
    }
    
    func request(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data, error == nil {
                if let model = self.parseJSON(data) {
                    self.delegate?.didUpdateBooks(with: model.items)
                }
            } else {
                print("Error")
            }
        }
        task.resume()
    }
    
//    func requestMore(with urlString: String) {
//        guard let url = URL(string: urlString) else { return }
//        let task = URLSession.shared.dataTask(with: url) { data, _, error in
//            if let data, error == nil {
//                if let model = self.parseJSON(data) {
//                    self.delegate?.loadMoreBooks(with: model.items)
//                }
//            } else {
//                print("Error")
//            }
//        }
//        task.resume()
//    }
    
    func parseJSON(_ data: Data) -> Books? {
        do {
            let decodedData = try JSONDecoder().decode(Books.self, from: data)
            return decodedData
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}




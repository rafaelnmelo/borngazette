//
//  APICaller.swift
//  BornGazette
//
//  Created by Rafael Melo on 11/05/24.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class APICaller {
    
    static func getArticles(callback: @escaping (_ result: Result<NewsModel,NetworkError>) -> Void) {
        
        guard let url = URL(string: NetworkConstant.shared.techNews) else {
            callback(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            print(dataResponse?.prettyPrintedJSON ?? "")
            if error == nil,
               let data = dataResponse {
                do {
                    let resulData = try JSONDecoder().decode(NewsModel.self, from: data)
                    callback(.success(resulData))
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            } else {
                callback(.failure(.canNotParseData))
            }
        }.resume()
    }
}

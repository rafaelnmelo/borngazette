//
//  ArticlePresenter.swift
//  BornGazette
//
//  Created by Rafael Melo on 13/05/24.
//

import UIKit
//MARK: - CLASS -
class ArticlePresenter {
    var article: Article?
    var favorite = [String:Dictionary<String, String>]()
    
    init(article: Article?) {
        self.article = article
    }
}

//MARK: - READ LATER MANAGEMENT -
extension ArticlePresenter {
    
    func isArticleSaved(article: Article?) -> Bool {
        for item in UserDefaultsManager.shared.readLaterList {
            for subItem in item.value {
                if subItem.value == "\(article?.title ?? "")" {
                    return true
                }
            }
        }
        return false
    }
    
    func buildArticle(data: Article?) -> [String:Dictionary<String, String>]{
        var content = [String:String]()
        
        content["sourceID"] = "\(data?.source?.id ?? "")"
        content["sourceName"] = "\(data?.source?.name ?? "")"
        content["author"] = data?.author
        content["title"] = data?.title
        content["description"] = data?.description
        content["url"] = data?.url
        content["urlToImage"] = data?.urlToImage
        content["publishedAt"] = data?.publishedAt
        content["content"] = data?.content
        
        var article = [String:Dictionary<String, String>]()
        article["\(data?.title ?? "")"] = content
        return article
    }
    
}

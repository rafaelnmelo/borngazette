//
//  ReadLaterPresenter.swift
//  BornGazette
//
//  Created by Rafael Melo on 13/05/24.
//

import UIKit

protocol ReadLaterPresenterDelegate: AnyObject {
    func fetchSuccess()
}

class ReadLaterPresenter {
    var delegate: ReadLaterPresenterDelegate?
    var articles: [HeadlineCell.Content] = []
}

//MARK: - OBJECT MAPPERS -
extension ReadLaterPresenter {
    
    func articlesMapper() {
        var article = [String:String]()
        var content = [HeadlineCell.Content]()
        
        for item in UserDefaultsManager.shared.readLaterList {
            for subItem in item.value {
                switch subItem.key {
                case "sourceID":
                    article["sourceID"] = subItem.value
                case "sourceName":
                    article["sourceName"] = subItem.value
                case "author":
                    article["author"] = subItem.value
                case "title":
                    article["title"] = subItem.value
                case "description":
                    article["description"] = subItem.value
                case "url":
                    article["url"] = subItem.value
                case "urlToImage":
                    article["urlToImage"] = subItem.value
                case "publishedAt":
                    article["publishedAt"] = subItem.value
                case "content":
                    article["content"] = subItem.value
                default:
                    break
                }
            }
                
            let articleSaved = HeadlineCell.Content(sourceID: article["sourceID"],
                                                    sourceName: article["sourceName"],
                                                    author: article["author"],
                                                    title: article["title"],
                                                    description: article["description"],
                                                    url: article["url"],
                                                    urlToImage: article["urlToImage"],
                                                    publishedAt: article["publishedAt"],
                                                    content: article["content"])
            content.append(articleSaved)
        }
        
        self.articles = content
        self.delegate?.fetchSuccess()
//        return content.sorted(by: { $0.title ?? "" > $1.title ?? ""})
    }
}

//MARK: - BUILDERS -
extension ReadLaterPresenter {
    
    func numberOfNewsRows() -> Int{
        articles.count
    }
    
    func newsForRow(at indexPath: IndexPath) -> HeadlineCell.Content{
        articles[indexPath.row]
    }
    
    func articleForDetail(at indexPath: IndexPath) -> Article {
        Article(source: Source(id: articles[indexPath.row].sourceID, name: articles[indexPath.row].sourceName),
                author: articles[indexPath.row].author,
                title: articles[indexPath.row].title,
                description: articles[indexPath.row].description,
                url: articles[indexPath.row].url,
                urlToImage: articles[indexPath.row].urlToImage,
                publishedAt: articles[indexPath.row].publishedAt,
                content: articles[indexPath.row].content)
    }
}

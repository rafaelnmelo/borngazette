//
//  ArticlePresenter.swift
//  BornGazette
//
//  Created by Rafael Melo on 13/05/24.
//

protocol ArticlePresenterDelegate: AnyObject {
    func setButtonTitle(title: String)
    func showMessage(title: String, message: String)
    func openBrowser(url: URL)
}

import UIKit
//MARK: - CLASS -
class ArticlePresenter {
    var article: Article?
    var favorite = [String:Dictionary<String, String>]()
    var delegate: ArticlePresenterDelegate?
    
    init(article: Article?) {
        self.article = article
    }
}

//MARK: - FUNCTIONS -
extension ArticlePresenter {
    func setupButton(article: Article?) {
        if isArticleSaved(article: article){
            self.delegate?.setButtonTitle(title: "Lido!")
        } else {
            self.delegate?.setButtonTitle(title: "Ler Depois")
        }
    }
    
    func checkList(article: Article?) {
        let item = buildArticle(data: article)
            
        if isArticleSaved(article: article) {
            UserDefaultsManager.shared.removeFromReadLater(item)
            self.delegate?.showMessage(title: "Item removido",
                                       message: "Este artigo foi removido da lista 'Ler depois'")
            self.delegate?.setButtonTitle(title: "Ler Depois")
        } else {
            UserDefaultsManager.shared.addToReadLater(item)
            self.delegate?.showMessage(title: "Item salvo",
                                       message: "Este artigo foi adiciona na lista 'Ler depois'")
            self.delegate?.setButtonTitle(title: "Lido!")
        }
    }
    
    func checkURL(urlString: String?) {
        guard let url = URL(string: urlString ?? "") else { return }
        self.delegate?.openBrowser(url: url)
    }
}

//MARK: - READ LATER MANAGEMENT -
extension ArticlePresenter {
    func isArticleSaved(article: Article?) -> Bool {
        let list = UserDefaultsManager.shared.userDefaults.object(forKey: UserDefaultsKeys.readLaterList.rawValue) as? [String:Dictionary<String, String>] ?? [:]
        
        for item in list {
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

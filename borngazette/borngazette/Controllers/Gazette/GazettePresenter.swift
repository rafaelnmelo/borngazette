//
//  GazettePresenter.swift
//  BornGazette
//
//  Created by Rafael Melo on 11/05/24.
//

import Foundation

protocol GazettePresenterDelegate: AnyObject {
    func fetchSuccess()
    func fetchFailure()
}
//MARK: - CLASS -
class GazettePresenter {
    
    private let gazetteService: APICaller
    weak var delegate: GazettePresenterDelegate?
    
    var articles = [Article]()
    
    init(gazetteService: APICaller = APICaller()) {
        self.gazetteService = gazetteService
    }
    
//MARK: - FUNCTIONS -
    func getArticles() {
        APICaller.getArticles { [weak self] result in
            switch result {
            case .success(let newsList):
                self?.articlesMapper(data: newsList)
                self?.delegate?.fetchSuccess()
                break
            case .failure:
                self?.delegate?.fetchFailure()
                break
            }
        }
    }

}

//MARK: - OBJECT MAPPERS -
extension GazettePresenter {

    func articlesMapper(data: NewsModel) {
        guard let result = data.articles else {return}
        self.articles = result
    }
    
}

//MARK: - BUILDERS -
extension GazettePresenter {
    
    func numberOfNewsRows() -> Int{
        return articles.count
    }
    
    func newsForRow(at indexPath: IndexPath) -> HeadlineCell.Content{
        
        let data = HeadlineCell.Content(sourceID: articles[indexPath.row].source?.id,
                                        sourceName: articles[indexPath.row].source?.name,
                                        author: articles[indexPath.row].author,
                                        title: articles[indexPath.row].title,
                                        description: articles[indexPath.row].description,
                                        url: articles[indexPath.row].url,
                                        urlToImage: articles[indexPath.row].urlToImage,
                                        publishedAt: articles[indexPath.row].publishedAt,
                                        content: articles[indexPath.row].content)
        return data
    }
    
    func articleForDetail(at indexPath: IndexPath) -> Article {
        return articles[indexPath.row]
    }
}

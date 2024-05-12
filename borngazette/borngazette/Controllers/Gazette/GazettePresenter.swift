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
    func getMoviesList() {
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
        
        let data = HeadlineCell.Content(title: articles[indexPath.row].title,
                                        author: articles[indexPath.row].author,
                                        name: articles[indexPath.row].source?.name,
                                        image: articles[indexPath.row].urlToImage)
        return data
    }
    
    func articleForDetail(at indexPath: IndexPath) -> ArticleViewController.Content {
        let article = ArticleViewController.Content(publicationDate: articles[indexPath.row].publishedAt,
                                                    articleContent: articles[indexPath.row].content,
                                                    newsPhoto: articles[indexPath.row].urlToImage)
        return article
    }
}

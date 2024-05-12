//
//  ArticleViewController.swift
//  BornGazette
//
//  Created by Rafael Melo on 11/05/24.
//

import UIKit

class ArticleViewController: BaseViewController {

    lazy var backgroundImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0.4
        return image
    }()
       
    private lazy var newsPhoto: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var publicationDate: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private lazy var articleContent: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [publicationDate, articleContent])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    struct Content {
        var publicationDate: String?
        var articleContent: String?
        var newsPhoto: String?
    }
}

//MARK: - FUNCTIONS -
extension ArticleViewController {
    func build(data: Content) {
        self.publicationDate.text = data.publicationDate?.readableDate
        self.articleContent.text = data.articleContent
        self.newsPhoto.downloaded(from: data.newsPhoto)
    }
}

//MARK: - VIEWCODE PROTOCOL -
extension ArticleViewController: ViewCodeProtocol {
    func buildHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(newsPhoto)
        view.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            newsPhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            newsPhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            newsPhoto.heightAnchor.constraint(equalTo: newsPhoto.widthAnchor, multiplier: 0.75),
            
            stackView.topAnchor.constraint(equalTo: newsPhoto.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func applyAdditionalChanges() {
        coordinator?.navigationController.navigationBar.prefersLargeTitles = false
        title = "Detalhes"
    }
}

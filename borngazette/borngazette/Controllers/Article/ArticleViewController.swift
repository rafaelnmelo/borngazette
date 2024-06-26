//
//  ArticleViewController.swift
//  BornGazette
//
//  Created by Rafael Melo on 11/05/24.
//

import UIKit

class ArticleViewController: BaseViewController {

    lazy var backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "background"))
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
    
    private lazy var articleDate: UILabel = {
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
    
    private lazy var readMore: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 10))
        button.backgroundColor = .clear
        button.setTitle("Ler mais", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(checkURL), for: .touchUpInside)
        return button
    }()
    
    private lazy var readLater: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 10))
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(checkReadLaterList), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    //MARK: STACKS
    private lazy var articleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [articleDate, articleContent, actionsStack])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var actionsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [readMore, readLater])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var presenter: ArticlePresenter?
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.setupButton(article: article)
    }
    
    struct Content {        
        var sourceID: String?
        var sourceName: String?
        var author: String?
        var title: String?
        var description: String?
        var url: String?
        var urlToImage: String?
        var publishedAt: String?
        var content: String?
    }
}

//MARK: - FUNCTIONS -
extension ArticleViewController {
    func build(data: Article) {
        self.articleDate.text = data.publishedAt?.readableDate
        self.articleContent.text = data.content
        self.newsPhoto.downloaded(from: data.urlToImage)
        self.article = data
    }
    
    func setupPresenter() {
        presenter = ArticlePresenter(article: article)
        presenter?.delegate = self
    }
    
    @objc func checkURL(sender: UIButton!) {
        self.presenter?.checkURL(urlString: article?.url)
    }
    
    @objc func checkReadLaterList(_ sender: Any) {
        self.presenter?.checkList(article: article)
    }
}

//MARK: - VIEWCODE PROTOCOL -
extension ArticleViewController: ViewCodeProtocol {
    func buildHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(newsPhoto)
        view.addSubview(articleStack)
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
            
            articleStack.topAnchor.constraint(equalTo: newsPhoto.bottomAnchor),
            articleStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            articleStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            articleStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
        
        let actionsStackViewConstraint = actionsStack.heightAnchor.constraint(equalToConstant: 50)
        actionsStackViewConstraint.isActive = true
        actionsStackViewConstraint.priority = UILayoutPriority.init(999)
    }
    
    func applyAdditionalChanges() {
        title = "Artigo"
    }
}

//MARK: - PRESENTER DELEGATE -
extension ArticleViewController: ArticlePresenterDelegate {
    func setButtonTitle(title: String) {
        self.readLater.setTitle(title, for: .normal)
    }
    
    func showMessage(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
    func openBrowser(url: URL) {
        UIApplication.shared.open(url)
    }
}

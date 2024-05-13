//
//  HeadlineCell.swift
//  BornGazette
//
//  Created by Rafael Melo on 11/05/24.
//

import UIKit

//MARK: - CLASS -
class HeadlineCell: UITableViewCell {

    public static var identifier: String {
        get {
            "HeadlineCell"
        }
    }
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    private lazy var newsPhoto: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var headlineLb: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var newsDescription: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var author: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    //MARK: STACKS
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [author, headlineLb])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var headlineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newsPhoto, titleStackView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var articleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headlineStackView, newsDescription])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
extension HeadlineCell {
    func build(data: Content) {
        self.headlineLb.text = data.title
        self.author.text = data.author
        self.newsDescription.text = data.description
        self.newsPhoto.downloaded(from: data.urlToImage)
    }
}

//MARK: - VIEWCODE PROTOCOL -
extension HeadlineCell: ViewCodeProtocol {
    func buildHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(blurView)
        containerView.addSubview(articleStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            blurView.topAnchor.constraint(equalTo: containerView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            articleStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            articleStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            articleStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            articleStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
        ])
        
//        let heightConstraint = containerView.heightAnchor.constraint(equalToConstant: 175)
//        heightConstraint.isActive = true
//        heightConstraint.priority = UILayoutPriority.init(999)
        
        let headlineStackViewConstraint = headlineStackView.heightAnchor.constraint(equalToConstant: 70)
        headlineStackViewConstraint.isActive = true
        headlineStackViewConstraint.priority = UILayoutPriority.init(999)
    }
    
    func applyAdditionalChanges() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
    }
}

//
//  GazetteViewController.swift
//  BornGazette
//
//  Created by Rafael Melo on 11/05/24.
//

import UIKit

//MARK: - CLASS -
class GazetteViewController: BaseViewController {
    
    var presenter: GazettePresenter?
    
    lazy var backgroundImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0.4
        return image
    }()
    
    lazy var tableview: UITableView = {
        let tableview = UITableView(frame: self.view.frame, style: .insetGrouped)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .clear
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(HeadlineCell.self, forCellReuseIdentifier: HeadlineCell.identifier)
        return tableview
    }()
    
    lazy var emptyView: UITextView = {
        let view = UITextView(frame: self.view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.text = "Não foram encontradas notícias"
        view.textAlignment = .center
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPresenter()
        self.setupView()
        self.getNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

//MARK: - FUNCTIONS -
extension GazetteViewController {
    
    private func setupPresenter() {
        presenter = GazettePresenter()
        presenter?.delegate = self
    }
    
    private func getNews() {
        presenter?.getArticles()
    }
    
    func removeLoading() {
        self.removeActivityIndicator()
    }
}

//MARK: - VIEWCODE PROTOCOL -
extension GazetteViewController: ViewCodeProtocol {
    func buildHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(tableview)
        view.addSubview(emptyView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func applyAdditionalChanges() {
    }
}
//MARK: - TABLE VIEW DELEGATE -
extension GazetteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = presenter?.articleForDetail(at: indexPath) {
            coordinator?.goToArticle(article: data)
        }
    }
    
}

//MARK: - TABLE VIEW DATA SOURCE -
extension GazetteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfNewsRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineCell.identifier, for: indexPath) as? HeadlineCell {
            if let data = presenter?.newsForRow(at: indexPath) {
                cell.build(data: data)
                return cell
            }
        }
        return UITableViewCell()
    }
}

//MARK: - PRESENTER DELEGATE -
extension GazetteViewController: GazettePresenterDelegate {
    func showEmptyView() {
        DispatchQueue.main.async {
            self.tableview.isHidden = true
            self.emptyView.isHidden = false
        }
        self.removeLoading()
    }
    
    func reloadTableview() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
        self.removeLoading()
    }
    
    func showLoading() {
        self.showActivityIndicator()
    }
}

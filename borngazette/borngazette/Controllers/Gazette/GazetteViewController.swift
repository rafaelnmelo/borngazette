//
//  GazetteViewController.swift
//  BornGazette
//
//  Created by Rafael Melo on 11/05/24.
//

import UIKit

//MARK: - CLASS -
class GazetteViewController: BaseViewController {
    
    private var presenter: GazettePresenter?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPresenter()
        self.setupView()
        self.getNews()
    }
}

//MARK: - FUNCTIONS -
extension GazetteViewController {
    
    private func setupPresenter() {
        presenter = GazettePresenter()
        presenter?.delegate = self
    }
    
    private func getNews() {
        presenter?.getMoviesList()
    }
}

//MARK: - VIEWCODE PROTOCOL -
extension GazetteViewController: ViewCodeProtocol {
    func buildHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(tableview)
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
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func applyAdditionalChanges() {
        coordinator?.navigationController.navigationBar.prefersLargeTitles = true
        title = "Manchetes"
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
    func fetchFailure() {
        print("Falhou")
        //TODO: Elaborate failure
    }
    
    func fetchSuccess() {
        print("Sucesso")
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
        //TODO: Elaborate success
    }
}

//MARK: - ARTICLEVIEWCONTROLLER DELEGATE -
//extension GazetteViewController: ArticleViewControllerDelegate {
//    func saveForLater(index: Int) {
//        self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
//    }
//}

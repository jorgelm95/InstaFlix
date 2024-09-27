//
//  MovieListViewController.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import UIKit
import InstaFlixDomain

final class MovieListViewController: UIViewController, MovieListViewType {
    
    private struct Constants {
        static let paddingTop: CGFloat = 10
        static let paddingLeft: CGFloat = 10
        static let paddingRight: CGFloat = 10
        static let paddingBottom: CGFloat = 10
        static let shadowOpacity: Float = 0.3
        static let emptyStateImage = "magnifyingglass.circle"
        static let emptyStateNetworkImage = "wifi.slash"
    }
    
    // MARK: - Private properties -
    
    private lazy var ContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .instaFlixLighGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var loadingView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        return activityIndicator
    }()
    
    // MARK: - internal Properties -

    
    var items: [Movie] = [] {
        didSet {
            if items.isEmpty {
                movieListState = .emptyResults
            }
            tableView.reloadData()
        }
    }

    var movieListState: MovieListState = .initialEmpty {
        didSet {
            checkEmptyState()
        }
    }
    
    var presenter: MovieListPresenterType?
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = Strings.ListMovies.screenTitle
        setupContentView()
        setupTableView()
        checkEmptyState()
        presenter?.fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setupNavigationBarAppearance()
        VerifyNeedsRefreshMovies()
    }
    
    // MARK: - internal methods -

    func removeLoadingView() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    // MARK: - Private methods -
    
    private func VerifyNeedsRefreshMovies() {
        guard let presenter else { return }
        if presenter.shouldShouwFavoriteMovie {
            presenter.fetchMovies()
        }
    }
    
    private func setupContentView() {
        view.addSubview(ContentView)
        
        ContentView.addConstraints(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor)
    }
    
    private func setupTableView() {
        ContentView.addSubview(tableView)
        tableView.addConstraints(
            top: ContentView.topAnchor,
            leading: ContentView.leadingAnchor,
            bottom: ContentView.bottomAnchor,
            trailing: ContentView.trailingAnchor)
    }
    
    private func showLoadingView() {
        loadingView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        loadingView.backgroundColor = .InstaBlue
        activityIndicator.center = self.view.center
        activityIndicator.color = .InstaBlue
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
    }
    
    private func checkEmptyState() {
        switch movieListState {
        case .initialEmpty:
            tableView.setEmptyState(
                text: Strings.ListMovies.emptyStateTitle,
                image: Constants.emptyStateImage, delegate: self)
        case .emptyResults:
            tableView.setEmptyState(
                text: Strings.ListMovies.emptyResultTitle,
                image: Constants.emptyStateImage, delegate: self)
        case .NetworkError:
            items = []
            tableView.setEmptyState(
                text: Strings.ListMovies.emptyStateNetworkTitle,
                image: Constants.emptyStateNetworkImage, delegate: self)
        case .filled:
            tableView.backgroundView = nil
        }
    }
    
    func showInformativeAlert() {
        let alert = UIAlertController(
            title: Strings.ListMovies.addMovieSuccessTitle,
            message: Strings.ListMovies.addMovieSuccessMessage,
            preferredStyle: .alert)
               
        let okAction = UIAlertAction(title: Strings.ListMovies.addMovieAlertButtonTitle, style: .default)
               
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate -

extension MovieListViewController: UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        presenter?.goToMovieDetail(item)
    }
}

// MARK: - UITableViewDataSource -

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.reuseIdentifier, for: indexPath) as! MovieListTableViewCell
        let item = items[indexPath.row]
        cell.configure(with: item)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
}

// MARK: - saveFavoriteMoviewViewDelegate -

extension MovieListViewController: saveFavoriteMoviewViewDelegate {
    func saveMovie(movie: Movie) {
        presenter?.saveFavorite(movie: movie)
    }
}

// MARK: - RetryDataDelegate -

extension MovieListViewController: RetryDataDelegate {
    func retryGetData() {
        guard let presenter else { return }
        presenter.fetchMovies()
    }
}

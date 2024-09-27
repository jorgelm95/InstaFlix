//
//  MovieDetailViewController.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import UIKit
import InstaFlixDomain

class MovieDetailViewController: UIViewController, MovieDetailViewType {
    
    // MARK: - Private properties -
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(MovieDetailTableViewCell.self, forCellReuseIdentifier: MovieDetailTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Internal properties -
    
    var presenter: MovieDetailPresenter?
    var movieDetail: Movie = Movie(
        id: 0,
        adult: false,
        originalTitle: .empty,
        overview: .empty,
        releaseDate: .empty,
        originalLanguage: .empty,
        voteAverage: .empty,
        hasVideo: false,
        posterPath: .empty)
    
    // MARK: - LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.MovieDetail.screenTitle
        setupTableView()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setupNavigationBarAppearance()
    }
    
    // MARK: - Private methods -
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.addConstraints(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor)
    }
}

// MARK: - UITableViewDataSource -

extension MovieDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.reuseIdentifier, for: indexPath) as? MovieDetailTableViewCell else { return UITableViewCell() }
        cell.configure(movie: movieDetail)
        
        return cell
    }
}

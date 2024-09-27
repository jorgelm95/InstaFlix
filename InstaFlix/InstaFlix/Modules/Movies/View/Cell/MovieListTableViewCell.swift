//
//  MovieListTableViewCell.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import UIKit
import InstaFlixDomain

final class MovieListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: MovieListTableViewCell.self)
    
    private struct Constants {
        static let paddingTop: CGFloat = 10
        static let paddingLeft: CGFloat = 10
        static let paddingRight: CGFloat = 10
        static let paddingBottom: CGFloat = 10
        static let titleLabelFontSize: CGFloat = 14
        static let textLabelfontsize: CGFloat = 16
        static let posterMovieImageSize: CGSize = CGSize(width: 150, height: 200)
    }
    
    private lazy var moviewView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font =  UIFont.boldSystemFont(ofSize: Constants.titleLabelFontSize)
        label.textColor = .black
        return label
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font =  UIFont.boldSystemFont(ofSize: Constants.textLabelfontsize)
        label.textColor = .instaFlixLighGray
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.boldSystemFont(ofSize: Constants.textLabelfontsize)
        label.textColor = .black
        return label
    }()
    
    private lazy var allowPublicLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: Constants.textLabelfontsize)
        label.textColor = .black
        return label
    }()
    
    lazy var addFavoriteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .InstaBlue
        button.tintColor = .white
        button.layer.cornerRadius = 5.0
        button.setTitle("Add to favorite", for: .normal)
        let image = UIImage(systemName: "heart")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(saveFavorite(_:)), for: .touchUpInside)
        return button
    }()
    
    var movie: Movie?
    var delegate: saveFavoriteMoviewViewDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
        setupPosterImageView()
        setupInformationStackView()
        setupInformationLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: Movie) {
        self.movie = movie
        self.selectionStyle = .none
        titleLabel.text = movie.originalTitle
        languageLabel.text = movie.originalLanguage
        releaseDateLabel.text = movie.releaseDate
        posterImageView.downloadImage(from: movie.posterPath)
    }
    
    private func setupContentView() {
        contentView.addSubview(moviewView)
        moviewView.addConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 10.0,
            paddingLeft: 16.0,
            paddingBottom: 10.0,
            paddingRight: 16.0)
        
        moviewView.layer.cornerRadius = 15.0
        moviewView.layer.shadowOpacity = 0.3
        moviewView.layer.shadowOffset = CGSize(width: 0, height: 2)
        moviewView.layer.shadowRadius = 4
    }
    
    private func setupPosterImageView() {
        moviewView.addSubview(posterImageView)
        posterImageView.addConstraints(
            top: moviewView.topAnchor,
            leading: moviewView.leadingAnchor,
            paddingTop: 5.0,
            paddingLeft: 10.0,
            width: Constants.posterMovieImageSize.width,
            height: Constants.posterMovieImageSize.height)
    }
    
    private func setupInformationStackView() {
        moviewView.addSubview(infoStackView)
        infoStackView.addConstraints(
            top: moviewView.topAnchor,
            leading: posterImageView.trailingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
    }
    
    private func setupInformationLabels() {
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(languageLabel)
        infoStackView.addArrangedSubview(releaseDateLabel)
        infoStackView.addArrangedSubview(addFavoriteButton)
        
        addFavoriteButton.addConstraints(
            height: 30.0)
    }
    
    @objc private func saveFavorite(_ sender: UIEvent) {
        print("movie saved")
        let image = UIImage(systemName: "start.fill")
        self.addFavoriteButton.setImage(image, for: .selected)
        guard let movie else { return }
        delegate?.saveMovie(movie: movie)
    }
}

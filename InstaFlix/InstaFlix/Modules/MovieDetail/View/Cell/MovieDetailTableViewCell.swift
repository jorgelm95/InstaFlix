//
//  MovieDetailTableViewCell.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import UIKit
import InstaFlixDomain

final class MovieDetailTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: MovieDetailTableViewCell.self)
    
    var movie: Movie?
    
    private struct Constants {
        static let paddingTop: CGFloat = 10
        static let paddingLeft: CGFloat = 16.0
        static let paddingRight: CGFloat = 16.0
        static let paddingBottom: CGFloat = 10
        static let textFontsize: CGFloat = 20
        static let titleFontSize: CGFloat = 22
        static let movieImageHeight: CGFloat = 200
        static let buttonCornerRadius: CGFloat = 10
        static let buttonHeight: CGFloat = 50.0
        static let addFavoritePaddingTop: CGFloat = 20.0
        static let alternativeTextsFontSize: CGFloat = 14
    }
    
    // MARK: - Private properties -
    
    private lazy var detailView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        label.textColor = UIColor.instaFlixLighGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.alternativeTextsFontSize)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var overvewDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.textFontsize)
        label.numberOfLines = 0
        label.textColor = .instaFlixLighGray
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var originalLanguageLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.alternativeTextsFontSize)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var allowPublicLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.textFontsize)
        label.textColor = .instaFlixLighGray
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(posterImageView)
        contentView.addSubview(overviewTitleLabel)
        contentView.addSubview(overvewDescriptionLabel)
        contentView.addSubview(originalLanguageLable)
        contentView.addSubview(allowPublicLabel)
    
        setupTitleLabel()
        setupPosterImageLabel()
        setupOverviewTitleLabel()
        setupOverviewMessageLabel()
        setupInformationStackView()
    }
    
    // MARK: - LifyCicle -
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitleLabel.text = .empty
        overviewTitleLabel.text = .empty
        overvewDescriptionLabel.text = .empty
        allowPublicLabel.text = .empty
    }
    
    // MARK: - Configuration -
    
    func configure(movie: Movie) {
        self.movie = movie
        self.selectionStyle = .none
        self.movieTitleLabel.text = movie.originalTitle
        self.posterImageView.downloadImage(from: movie.posterPath)
        self.overvewDescriptionLabel.text = movie.overview
        self.originalLanguageLable.text = "original languaje " + movie.originalLanguage
        self.allowPublicLabel.text = !movie.adult ?  Strings.MovieDetail.allowAllPublic : Strings.MovieDetail.notAllowAllPublic
    }
    
    // MARK: - Private methods -
    
    private func setupdetailViewView() {
        detailView.addConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingBottom: Constants.paddingBottom,
            paddingRight: Constants.paddingRight)
    }
    
    private func setupTitleLabel(){
        movieTitleLabel.addConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
    }
    
    private func setupPosterImageLabel() {
        posterImageView.addConstraints(
            top: movieTitleLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight,
            height: Constants.movieImageHeight)
    }
    
    private func setupOverviewTitleLabel() {
        overviewTitleLabel.addConstraints(
            top: posterImageView.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
    }
    
    private func setupOverviewMessageLabel() {
        overvewDescriptionLabel.addConstraints(
            top: overviewTitleLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
    }
    
    private func setupInformationStackView() {
        contentView.addSubview(infoStackView)
        infoStackView.addConstraints(
            top: overvewDescriptionLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
        
        infoStackView.addArrangedSubview(originalLanguageLable)
        infoStackView.addArrangedSubview(allowPublicLabel)
    }
}

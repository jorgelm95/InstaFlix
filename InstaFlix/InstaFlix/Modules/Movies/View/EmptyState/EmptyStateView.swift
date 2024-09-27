//
//  EmptyStateView.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import UIKit

protocol RetryDataDelegate: AnyObject {
    func retryGetData()
}

final class EmptyStateView: UIView {
    
    private struct Constants {
        static let paddingTop: CGFloat = 10
        static let paddingLeft: CGFloat = 20
        static let paddingRight: CGFloat = 20
        static let imageSize: CGSize = CGSize(width: 100, height: 100)
        static let animationDuration: Double = 2.0
        static let animationDelay: Double = 0
    }
    
    // MARK: - Private properties -
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .instaFlixLighGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var retryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .InstaBlue
        button.tintColor = .white
        button.layer.cornerRadius = 5.0
        button.setTitle("Retry", for: .normal)
        button.addTarget(self, action: #selector(retryFetchMovies(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Internal properties -
    
    var text: String = ""
    var image: String = ""
    weak var delegate: RetryDataDelegate?
    
    // MARK: - Lifecycle -
    
    init(
        text: String,
        image: String,
        frame: CGRect,
        delegate: RetryDataDelegate) {
            super.init(frame: frame)
            self.text = text
            self.image = image
            self.delegate = delegate
            setupView()
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - private Methods -
    
    private func setupView() {
        addSubview(imageView)
        addSubview(textLabel)
        addSubview(retryButton)
        
        imageView.image = UIImage(systemName: image)
        imageView.addConstraints(
            centerX: centerXAnchor,
            centerY: centerYAnchor,
            width: Constants.imageSize.width,
            height: Constants.imageSize.height)
        
        textLabel.text = text
        textLabel.addConstraints(
            top: imageView.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            centerX: centerXAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
        
        retryButton.addConstraints(
            top: textLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            centerX: centerXAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight,
            height: 50.0)
        
        UIView.animate(
            withDuration: Constants.animationDuration,
            delay: Constants.animationDelay,
            options: [.repeat, .autoreverse], animations: {
                self.imageView.transform = CGAffineTransform(rotationAngle: 45.0)
            }, completion: nil)
    }
    
    @objc private func retryFetchMovies(_ sender: UIEvent) {
        guard let delegate else { return }
        delegate.retryGetData()
    }
}

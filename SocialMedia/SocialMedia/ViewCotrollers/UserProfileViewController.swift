//
//  UserProfileViewController.swift
//  SocialMedia
//
//  Created by Alikhan Kassiman on 28.02.2025.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController {
    private let profile: UserProfile
    private let imageLoader: ImageLoader
    
    private let profileImageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.1
        return view
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 60
        imageView.backgroundColor = .systemGray5
        // Add a subtle border
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let statsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    init(profile: UserProfile, imageLoader: ImageLoader) {
        self.profile = profile
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithProfile()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = profile.username
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        [profileImageView, usernameLabel, bioLabel, statsContainerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        [followersCountLabel, followersLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            statsContainerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            bioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 16),
            bioLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            bioLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            statsContainerView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 30),
            statsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            statsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            statsContainerView.heightAnchor.constraint(equalToConstant: 100),
            statsContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            followersCountLabel.centerXAnchor.constraint(equalTo: statsContainerView.centerXAnchor),
            followersCountLabel.centerYAnchor.constraint(equalTo: statsContainerView.centerYAnchor, constant: -12),
            
            followersLabel.centerXAnchor.constraint(equalTo: statsContainerView.centerXAnchor),
            followersLabel.topAnchor.constraint(equalTo: followersCountLabel.bottomAnchor, constant: 4)
        ])
    }
    
    private func configureWithProfile() {
        usernameLabel.text = profile.username
        bioLabel.text = profile.bio
        followersCountLabel.text = "\(profile.followers)"
        followersLabel.text = "followers"
        
        imageLoader.loadImage(url: profile.imageUrl) { [weak self] image in
            self?.profileImageView.image = image
        }
    }
}

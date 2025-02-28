//
//  FeedViewController.swift
//  SocialMedia
//
//  Created by Alikhan Kassiman on 28.02.2025.
//

import UIKit
import Foundation

class FeedViewController: UIViewController, UICollectionViewDelegate {
    private let viewModel: FeedSystem
    private let tableView = UITableView()
    private let hashtagFilterView = HashtagFilterView()
    private let refreshControl = UIRefreshControl()
    
    init(viewModel: FeedSystem) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureHashtags()
        setupNavigationBar()
    }
    
    
    private func setupNavigationBar() {
  
        navigationItem.title = "Canals"
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        navigationController?.navigationBar.tintColor = .systemIndigo
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .systemBackground
        
        let addButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(addPostTapped)
        )
        addButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addPostTapped() {
        let postCreationVC = PostMakeViewController(viewModel: viewModel) { [weak self] post in
            self?.viewModel.addPost(post)
            self?.tableView.reloadData()
            self?.hashtagFilterView.configure(with: self?.viewModel.uniqueHashtags ?? [])
        }
        
        let nav = UINavigationController(rootViewController: postCreationVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }

    private func configureHashtags() {
        hashtagFilterView.hashtagDelegate = self
        hashtagFilterView.configure(with: viewModel.uniqueHashtags)
    }
    
    @objc private func handleRefresh() {
        // Simulating a refresh
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    private func setupUI() {
        // Modern appearance for the view
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 1.0, alpha: 1.0)
            
        view.addSubview(hashtagFilterView)
        hashtagFilterView.translatesAutoresizingMaskIntoConstraints = false
        hashtagFilterView.layer.shadowColor = UIColor.black.cgColor
        hashtagFilterView.layer.shadowOffset = CGSize(width: 0, height: 2)
        hashtagFilterView.layer.shadowRadius = 4
        hashtagFilterView.layer.shadowOpacity = 0.05
        hashtagFilterView.backgroundColor = .systemBackground
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 1.0, alpha: 1.0)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        view.addSubview(tableView)
        
        refreshControl.tintColor = .systemIndigo
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        let emptyStateLabel = UILabel()
        emptyStateLabel.text = "No posts to show"
        emptyStateLabel.textColor = .systemGray
        emptyStateLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.isHidden = true
        view.addSubview(emptyStateLabel)
        
        NSLayoutConstraint.activate([
            hashtagFilterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hashtagFilterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hashtagFilterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hashtagFilterView.heightAnchor.constraint(equalToConstant: 60),
            
            tableView.topAnchor.constraint(equalTo: hashtagFilterView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        
        // Set row height to automatic
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPosts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = viewModel.getPost(at: indexPath.row)
        let profile = viewModel.getProfile(for: post)
        
        cell.configure(with: post, profile: profile, imageLoader: viewModel.imageLoader)
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0.05 * Double(indexPath.row), options: [], animations: {
            cell.alpha = 1
        })
        
        cell.onDelete = { [weak self] in
            self?.viewModel.removePost(post)
            self?.tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.getPost(at: indexPath.row)
        if let profile = viewModel.getProfile(for: post) {
            let profileVC = UserProfileViewController(profile: profile, imageLoader: viewModel.imageLoader)
            navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension FeedViewController: HashtagFilterDelegate {
    func didSelectHashtag(_ hashtag: String?) {
        print("Selected hashtag: \(hashtag ?? "All")")
        
        // Add subtle animation when filtering
        UIView.animate(withDuration: 0.25, animations: {
            self.tableView.alpha = 0.5
        }) { _ in
            self.viewModel.filterPosts(byHashtag: hashtag)
            self.tableView.reloadData()
            
            UIView.animate(withDuration: 0.25) {
                self.tableView.alpha = 1.0
            }
        }
    }
}

extension FeedViewController: ProfileUpdateDelegate {
    func profileDidUpdate(_ profile: UserProfile) {
        tableView.reloadData()
    }
    
    func profileLoadingError(_ error: Error) {
        let alert = UIAlertController(
            title: "Error Loading Profile",
            message: "Failed to load profile: \(error.localizedDescription)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default
        ))
        
        alert.view.tintColor = .systemIndigo
        
        present(alert, animated: true)
    }
}

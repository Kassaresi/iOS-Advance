//
//  PostMakeViewController.swift
//  SocialMedia
//
//  Created by Alikhan Kassiman on 28.02.2025.
//

import UIKit
import Foundation

class PostMakeViewController: UIViewController {
    private let userSelectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select User", for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 12
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        // Add a subtle shadow
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 2
        return button
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 12
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
        return textView
    }()
    
    private let hashtagsTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add hashtags (separated by space)"
        textField.borderStyle = .none
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 12
        // Add padding to text field
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }()
    
    private let userSelectionTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.layer.cornerRadius = 12
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.systemGray4.cgColor
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.rowHeight = 60
        return tableView
    }()
    
    private let sectionTitles: [UILabel] = {
        let userLabel = UILabel()
        userLabel.text = "POST AS"
        userLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        userLabel.textColor = .systemGray
        
        let contentLabel = UILabel()
        contentLabel.text = "CONTENT"
        contentLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        contentLabel.textColor = .systemGray
        
        let hashtagsLabel = UILabel()
        hashtagsLabel.text = "HASHTAGS"
        hashtagsLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        hashtagsLabel.textColor = .systemGray
        
        return [userLabel, contentLabel, hashtagsLabel]
    }()
    
    private var selectedUserId: UUID?
    private let viewModel: FeedSystem
    private let completion: (Post) -> Void
    
    init(viewModel: FeedSystem, completion: @escaping (Post) -> Void) {
        self.viewModel = viewModel
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupTableView() {
        userSelectionTableView.delegate = self
        userSelectionTableView.dataSource = self
        userSelectionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "New Post"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Post",
            style: .done,
            target: self,
            action: #selector(doneTapped)
        )
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        userSelectionButton.addTarget(self, action: #selector(userSelectionTapped), for: .touchUpInside)
        
        // Add all views to the hierarchy
        let allViews = [sectionTitles[0], userSelectionButton, userSelectionTableView,
                        sectionTitles[1], contentTextView,
                        sectionTitles[2], hashtagsTextField]
        
        allViews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // User section
            sectionTitles[0].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            sectionTitles[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            userSelectionButton.topAnchor.constraint(equalTo: sectionTitles[0].bottomAnchor, constant: 8),
            userSelectionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userSelectionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userSelectionButton.heightAnchor.constraint(equalToConstant: 54),
            
            userSelectionTableView.topAnchor.constraint(equalTo: userSelectionButton.bottomAnchor, constant: 8),
            userSelectionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userSelectionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userSelectionTableView.heightAnchor.constraint(equalToConstant: 240),
            
            // Content section
            sectionTitles[1].topAnchor.constraint(equalTo: userSelectionTableView.bottomAnchor, constant: 24),
            sectionTitles[1].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            contentTextView.topAnchor.constraint(equalTo: sectionTitles[1].bottomAnchor, constant: 8),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentTextView.heightAnchor.constraint(equalToConstant: 220),
            
            // Hashtags section
            sectionTitles[2].topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 24),
            sectionTitles[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            hashtagsTextField.topAnchor.constraint(equalTo: sectionTitles[2].bottomAnchor, constant: 8),
            hashtagsTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hashtagsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func userSelectionTapped() {
        userSelectionTableView.isHidden.toggle()
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func doneTapped() {
        guard let userId = selectedUserId, !contentTextView.text.isEmpty else { return }
        
        let hashtags = hashtagsTextField.text?
            .components(separatedBy: " ")
            .filter { !$0.isEmpty }
            .map { $0.hasPrefix("#") ? String($0.dropFirst()) : $0 }
            ?? []
        
        let post = Post(
            id: UUID(),
            authorId: userId,
            content: contentTextView.text,
            likes: 0,
            hashtags: Set(hashtags)
        )
        
        completion(post)
        dismiss(animated: true)
    }
}

// MARK: - TableView DataSource & Delegate
extension PostMakeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAllProfiles().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let profile = viewModel.getAllProfiles()[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = profile.username
        content.secondaryText = "@\(profile.username)"
        content.textProperties.font = .systemFont(ofSize: 16, weight: .medium)
        content.secondaryTextProperties.font = .systemFont(ofSize: 14)
        content.secondaryTextProperties.color = .systemGray
        // Add more padding inside cells
        content.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let profile = viewModel.getAllProfiles()[indexPath.row]
        selectedUserId = profile.id
        userSelectionButton.setTitle(profile.username, for: .normal)
        userSelectionTableView.isHidden = true
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}

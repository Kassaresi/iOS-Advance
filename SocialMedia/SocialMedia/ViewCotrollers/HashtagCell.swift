//
//  HashtagCell.swift
//  SocialMedia
//
//  Created by Alikhan Kassiman on 28.02.2025.
//

import Foundation
import UIKit

class HashtagCell: UICollectionViewCell {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        isUserInteractionEnabled = true
        
        backgroundColor = UIColor(red: 0.9, green: 0.95, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 15
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.systemBlue.cgColor
        clipsToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 14, weight: .medium)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            contentView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    func configure(with hashtag: String, isSelected: Bool) {
        label.text = "\(hashtag)"
        if isSelected {
            backgroundColor = .systemBlue
            label.textColor = .white
            layer.borderWidth = 0
        } else {
            backgroundColor = UIColor(red: 0.9, green: 0.95, blue: 1.0, alpha: 1.0)
            label.textColor = .systemBlue
            layer.borderWidth = 1.0
            layer.borderColor = UIColor.systemBlue.cgColor
        }
    }}

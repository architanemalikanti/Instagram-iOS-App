//
//  CreatePostCollectionViewCell.swift
//  A3
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit

class CreatePostCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties (view)
    
    
    private let postButton = UIButton()
    private let textField = UITextField()
    
    private let nameLabel = UILabel()
    private let timeLabel = UILabel()
    private let messageLabel = UILabel()
    private let likeButton = UIButton()
    private let likeCountLabel = UILabel()
    private let profileImageView = UIImageView()
    
    // MARK: - Properties (data)
    
    static let reuse: String = "CreatePostCollectionViewCellReuse"
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.a3.white
        layer.cornerRadius = 16
        
        setupTextField()
        setupPostButton()
        setupProfileImageView()
        setupNameLabel()
        setupTimeLabel()
        setupMessageLabel()
        setupLikeButton()
        setupLikeCountLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up Views
    
    private func setupTextField() {
        textField.placeholder = "✏️ What's on your mind?"
        textField.font = .systemFont(ofSize: 16)
        
        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let sidePadding: CGFloat = 24
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: sidePadding)
        ])
    }
    
    private func setupPostButton() {
        postButton.backgroundColor = UIColor.a3.ruby
        postButton.layer.cornerRadius = 4
        postButton.setTitle("Post", for: .normal)
        postButton.setTitleColor(UIColor.a3.white, for: .normal)
        postButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        postButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        
        contentView.addSubview(postButton)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        
        let sidePadding: CGFloat = 24
        NSLayoutConstraint.activate([
            postButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            postButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -sidePadding),
            postButton.widthAnchor.constraint(equalToConstant: 96),
            postButton.heightAnchor.constraint(equalToConstant: 32),
            postButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 32)
        ])
    }
    
    private func setupProfileImageView() {
        profileImageView.image = UIImage(named: "AppDevLogo")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 16
        profileImageView.clipsToBounds = true
        
        contentView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 32),
            profileImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupNameLabel() {
        nameLabel.text = "Anonymous"
        nameLabel.font = .boldSystemFont(ofSize: 14)
        nameLabel.textColor = UIColor.a3.black
        
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8)
        ])
    }
    
    private func setupTimeLabel() {
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.a3.silver
        
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4)
        ])
    }
    
    private func setupMessageLabel() {
        messageLabel.font = .systemFont(ofSize: 16)
        messageLabel.textColor = UIColor.a3.black
        
        contentView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            messageLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4)
        ])
    }
    
    private func setupLikeButton() {
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = UIColor.a3.ruby
        likeButton.addTarget(self, action: #selector(likePost), for: .touchUpInside)
        
        contentView.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupLikeCountLabel() {
        likeCountLabel.font = .systemFont(ofSize: 12)
        likeCountLabel.textColor = UIColor.a3.silver
        
        contentView.addSubview(likeCountLabel)
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            likeCountLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 8),
            likeCountLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor)
        ])
    }
    
    // MARK: - Configure Method
    
    func configure(with post: Post) {
        messageLabel.text = post.message
        timeLabel.text = convertToAgo(date: post.time)
        likeCountLabel.text = "\(post.likes.count) likes"
        // Optionally set profile image if available
    }
    
    // MARK: - Button Helpers
    
    @objc private func createPost() {
        // TODO: Send a POST request to create a post
    }
    
    @objc private func likePost() {
        // TODO: Handle like action
    }
    
    // MARK: - Date Helper
    private func convertToAgo(date: Date) -> String {
        let currentDate = Date()
        let secondsAgo = Int(currentDate.timeIntervalSince(date))
        
        switch secondsAgo {
        case 0:
            return "Just now"
        case 1:
            return "1 second ago"
        case 2..<60:
            return "\(secondsAgo) seconds ago"
        case 60:
            return "1 minute ago"
        case 61..<3600:
            return "\(secondsAgo / 60) minutes ago"
        case 3600:
            return "1 hour ago"
        case 3601..<86400:
            return "\(secondsAgo / 3600) hours ago"
        case 86400:
            return "1 day ago"
        default:
            return "\(secondsAgo / 86400) days ago"
        }
    }
}

//
//  PostCollectionViewCell.swift
//  A3
//
//  Created by Renee Gowda on 11/4/24.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties (view)
    
    private let nameLabel = UILabel()
    private let timeLabel = UILabel()
    private let messageLabel = UILabel()
    private let likeButton = UIButton()
    private let likeCountLabel = UILabel()
    private let profileImageView = UIImageView()
    
    // MARK: - Properties (data)
    
    static let reuse = "PostCollectionViewCellReuse"
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.a3.white
        layer.cornerRadius = 16
        
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
    
    private func setupProfileImageView() {
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 16
        profileImageView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 32),
            profileImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupNameLabel() {
        nameLabel.font = .boldSystemFont(ofSize: 14)
        nameLabel.textColor = UIColor.a3.black
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
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
            messageLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8)
        ])
    }
    
    private func setupLikeButton() {
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = UIColor.a3.ruby
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
            nameLabel.text = post.name
            messageLabel.text = post.message
            timeLabel.text = convertToAgo(date: post.time)
            likeCountLabel.text = "\(post.likes.count) likes"
        }
        
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


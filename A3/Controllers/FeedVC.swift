//
//  FeedVC.swift
//  A3
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit

class FeedVC: UIViewController {

    // MARK: - Properties
    private var collectionView: UICollectionView!

    // Dummy data for posts in the second section
    private let dummyPosts = [
        Post(id: "1", likes: ["Alice", "Bob"], message: "Ithaca is Gorges.", time: Date(), name: "Alice"),
        Post(id: "2", likes: ["Charlie"], message: "I'm from Boston!", time: Date(), name: "Charlie"),
        Post(id: "3", likes: ["Dave", "Eve", "Frank"], message: "My classes are killing me.", time: Date(), name: "Dave"),
        Post(id: "4", likes: ["Gina"], message: "I need sleep.", time: Date(), name: "Gina")
    ]
    

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ChatDev"
        view.backgroundColor = UIColor.white


        setupCollectionView()
    }

    // MARK: - Setup Collection View
    private func setupCollectionView() {
        // Create a layout for the collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16 // Spacing between rows

        // Initialize collection view with layout
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self

        // Register cells
        collectionView.register(CreatePostCollectionViewCell.self, forCellWithReuseIdentifier: "CreatePostCell")
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "PostCell")

        // Add collection view to main view
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension FeedVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2 // Two sections: "Create Post" and "Posts"
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // Section 0 has one "Create Post" cell
        } else {
            return dummyPosts.count // Section 1 has posts
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            // Create Post cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreatePostCell", for: indexPath) as! CreatePostCollectionViewCell
            return cell
        } else {
            // Post cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCollectionViewCell
            let post = dummyPosts[indexPath.item]
            cell.configure(with: post) // Assuming `configure(with:)` is a method in PostCollectionViewCell
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32 // 16 points padding on each side

        if indexPath.section == 0 {
            return CGSize(width: width, height: 100) // "Create Post" cell size
        } else {
            return CGSize(width: width, height: 150) // Post cell size
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 16, left: 16, bottom: 24, right: 16) // First section padding
        } else {
            return UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16) // Second section padding
        }
    }
}

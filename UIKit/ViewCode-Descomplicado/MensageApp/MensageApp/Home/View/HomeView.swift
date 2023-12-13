//
//  HomeView.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 04/12/23.
//

import UIKit

class HomeView: UIView {
    
    lazy var navView: NavView = {
        let navView = NavView()
        navView.translatesAutoresizingMaskIntoConstraints = false
        return navView
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delaysContentTouches = false
        
        collectionView.register(LastMessageCollectionViewCell.self, forCellWithReuseIdentifier: LastMessageCollectionViewCell.identifier)
        collectionView.register(MessageDetailCollectionViewCell.self, forCellWithReuseIdentifier: MessageDetailCollectionViewCell.identifier)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        return collectionView
    }()
    
    public func delegateCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
    }
    
    public func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setVisualElements() {
        self.addSubview(navView)
        self.addSubview(collectionView)
        
        self.configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.navView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navView.heightAnchor.constraint(equalToConstant: 140),
            
            self.collectionView.topAnchor.constraint(equalTo: self.navView.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
}


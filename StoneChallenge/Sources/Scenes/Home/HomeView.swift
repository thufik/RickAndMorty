//
//  HomeView.swift
//  StoneChallenge
//
//  Created by Rebecca Mello on 12/12/22.
//

import UIKit

class HomeView: UIView {
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 150) 
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let col = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        col.translatesAutoresizingMaskIntoConstraints = false
        col.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.collectionIdentifier)
        
        return col
    }()

    init() {
        super.init(frame: .zero)
        setupCollection()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollection() {
        addSubview(collectionView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

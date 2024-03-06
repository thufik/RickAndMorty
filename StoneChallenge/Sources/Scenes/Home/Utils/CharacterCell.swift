//
//  CharacterCell.swift
//  StoneChallenge
//
//  Created by Rebecca Mello on 13/12/22.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    static let collectionIdentifier: String = "cell"
    private var currentImageURL: URL? = nil
    
    lazy var img: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var name: UILabel = {
        let titulo = UILabel()
        titulo.textColor = .white
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = UIFont.boldSystemFont(ofSize: 15.0)
        return titulo
    }()
    
    lazy var background: UILabel = {
        let bg = UILabel()
        bg.backgroundColor = UIColor(named: "Gray")
        bg.text = " "
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupHierarchy()
        setConstraints()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if let currentImageURL {
            ImageFetcher.shared.cancel(url: currentImageURL)
        }
        
        img.image = nil
        name.text = nil
        background.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        addSubview(img)
        addSubview(background)
        addSubview(name)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: self.topAnchor),
            img.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            img.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            img.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            background.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            name.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 5),
            name.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
    
    func setupCell(character: CharacterInfos) {
        self.currentImageURL = character.image
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        
        name.text = character.name
        
        ImageFetcher.shared.fetch(url: character.image) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.img.image = image
                }
            case .failure:
                break
            }
        }
    }
}

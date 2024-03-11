import UIKit

class HomeCharacterCell: UICollectionViewCell {
    static let collectionIdentifier: String = "cell"
    private var currentImageURL: URL? = nil
    
    lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .black
        
        return view
    }()
    
    lazy var img: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            name
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var name: UILabel = {
        let titulo = UILabel()
        titulo.textColor = .white
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = UIFont.boldSystemFont(ofSize: 15.0)
        return titulo
    }()
    
//    lazy var background: UILabel = {
//        let bg = UILabel()
//        bg.backgroundColor = UIColor(named: "Gray")
//        bg.text = " "
//        bg.translatesAutoresizingMaskIntoConstraints = false
//        return bg
//    }()
    
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
        //background.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        contentView.addSubview(backView)
        
        backView.addSubview(img)
        backView.addSubview(detailsStackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            img.heightAnchor.constraint(equalToConstant: 100),
            img.topAnchor.constraint(equalTo: self.topAnchor),
            img.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            img.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            detailsStackView.leadingAnchor.constraint(equalTo: img.trailingAnchor),
            detailsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
//        
//        NSLayoutConstraint.activate([
//            name.centerYAnchor.constraint(equalTo: background.centerYAnchor),
//            name.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 5),
//            name.trailingAnchor.constraint(equalTo: self.trailingAnchor)
//        ])
//        
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


class HomeCharacterTableViewCell: UITableViewCell {
    static let cellIdentifier: String = "cell"
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: HomeCharacterTableViewCell.cellIdentifier)
        
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

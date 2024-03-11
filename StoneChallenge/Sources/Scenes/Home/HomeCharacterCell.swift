import UIKit

class HomeCharacterTableViewCell: UITableViewCell {
    static let cellIdentifier: String = "cell"
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
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
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
        titulo.numberOfLines = 0
        titulo.textColor = .white
        titulo.textAlignment = .center
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = UIFont.boldSystemFont(ofSize: 18.0)
        return titulo
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: HomeCharacterTableViewCell.cellIdentifier)
        
        setupHierarchy()
        setConstraints()
        setupConfig()
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
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            img.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10),
            img.heightAnchor.constraint(equalToConstant: 100),
            img.widthAnchor.constraint(equalToConstant: 100),
            img.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            detailsStackView.topAnchor.constraint(equalTo: backView.topAnchor),
            detailsStackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            detailsStackView.leadingAnchor.constraint(equalTo: img.trailingAnchor),
            detailsStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
        ])
    }
    
    func setupConfig() {
        selectionStyle = .none
    }
    
    func setupCell(character: CharacterInfos) {
        self.currentImageURL = character.image
        
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

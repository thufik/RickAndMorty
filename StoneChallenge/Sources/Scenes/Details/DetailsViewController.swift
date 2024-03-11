import UIKit

protocol DetailsViewProtocol: AnyObject {
    func setupNavigation()
    func setupView()
    func setupConstraints()
}

class DetailsViewController: UIViewController {
    
    private lazy var img: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 75
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameStackView,
            statusStackView,
            speciesStackView
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 16
        stackView.backgroundColor = .black
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    lazy var nameDesc: UILabel = {
        let titulo = UILabel()
        titulo.text = "Nome"
        titulo.numberOfLines = 0
        titulo.textColor = .white
        titulo.textAlignment = .left
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = UIFont.boldSystemFont(ofSize: 18.0)
        return titulo
    }()
    
    lazy var name: UILabel = {
        let titulo = UILabel()
        titulo.text = character.name
        titulo.numberOfLines = 0
        titulo.textColor = .white
        titulo.textAlignment = .right
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = UIFont.boldSystemFont(ofSize: 18.0)
        return titulo
    }()
    
    lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameDesc,
            name
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var statusDesc: UILabel = {
        let titulo = UILabel()
        titulo.text = "Status"
        titulo.numberOfLines = 0
        titulo.textColor = .white
        titulo.textAlignment = .left
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = UIFont.boldSystemFont(ofSize: 18.0)
        return titulo
    }()
    
    lazy var status: UILabel = {
        let titulo = UILabel()
        titulo.text = character.status.rawValue
        titulo.numberOfLines = 0
        titulo.textColor = .white
        titulo.textAlignment = .right
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = UIFont.boldSystemFont(ofSize: 18.0)
        return titulo
    }()
    
    lazy var statusStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            statusDesc,
            status
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var speciesDesc: UILabel = {
        let titulo = UILabel()
        titulo.numberOfLines = 0
        titulo.text = "Espécie"
        titulo.textColor = .white
        titulo.textAlignment = .left
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = UIFont.boldSystemFont(ofSize: 18.0)
        return titulo
    }()
    
    lazy var species: UILabel = {
        let titulo = UILabel()
        titulo.text = character.species
        titulo.numberOfLines = 0
        titulo.textColor = .white
        titulo.textAlignment = .right
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = UIFont.boldSystemFont(ofSize: 18.0)
        return titulo
    }()
    
    lazy var speciesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            speciesDesc,
            species
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let interactor: DetailsInteractorProtocol
    private let character: CharacterInfos
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(interactor: DetailsInteractorProtocol, character: CharacterInfos) {
        self.interactor = interactor
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageFetcher = ImageFetcher()
        imageFetcher.fetch(url: character.image, { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.img.image = image
                }
            case .failure:
                break
            }
        })
        
        setupNavigation()
        setupView()
        setupConstraints()
    }
}

extension DetailsViewController: DetailsViewProtocol {
    func setupNavigation() {
        view.backgroundColor = .white
    }
    
    func setupView() {
        view.addSubview(img)
        view.addSubview(detailsStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            img.heightAnchor.constraint(equalToConstant: 150),
            img.widthAnchor.constraint(equalToConstant: 150),
            img.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            detailsStackView.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 16),
            detailsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            //detailsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
}

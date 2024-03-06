import UIKit

protocol CollectionDelegate: AnyObject {
    func reloadCollectionData()
}

class HomeViewController: UIViewController, CollectionDelegate {
    
    let contentView: HomeView
    var viewModel: HomeViewModel
        
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavigation()
        getAllCharacters()
        
        self.contentView.collectionView.dataSource = self
        self.contentView.collectionView.delegate = self
    }
    
    init() {
        self.contentView = HomeView()
        self.viewModel = HomeViewModel()
       
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigation() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor(named: "Green")
    }
    
    func getAllCharacters() {
        viewModel.getCharacters()
    }
    
    func reloadCollectionData() {
        self.contentView.collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = self.contentView.collectionView.contentOffset.y
        let contentHeight = self.contentView.collectionView.contentSize.height
        let height = self.contentView.collectionView.frame.size.height
        
        if offsetY > contentHeight - height {
            viewModel.getCharacters()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.collectionIdentifier, for: indexPath) as? CharacterCell else { preconditionFailure() }
        let characterInIndex = viewModel.characters[indexPath.row]

        cell.setupCell(character: characterInIndex)
        return cell
    }
}

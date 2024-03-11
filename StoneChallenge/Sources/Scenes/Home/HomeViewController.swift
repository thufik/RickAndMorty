import UIKit

protocol HomeViewProtocol: AnyObject {
    func reloadCollectionData()
    func setupNavigation()
    func setupView()
    func setupConstraints()
}

class HomeViewController: UIViewController {
    
    private lazy var datasource: UITableViewDiffableDataSource<Int, CharacterInfos> = {
        
        let datasource = UITableViewDiffableDataSource<Int, CharacterInfos>(
            tableView: tableView,
            cellProvider: { tableView,indexPath,itemIdentifier in
          
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: HomeCharacterTableViewCell.cellIdentifier,
                    for: indexPath) as? HomeCharacterTableViewCell
                else { preconditionFailure() }
                
                let characterInIndex = self.interactor.characters[indexPath.row]

                cell.setupCell(character: characterInIndex)
                return cell
                
        })
        
        return datasource
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeCharacterTableViewCell.self, forCellReuseIdentifier: HomeCharacterTableViewCell.cellIdentifier)
        tableView.delegate = self
        
        return tableView
    }()

    private let interactor: HomeInteractorProtocol
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor.viewDidLoad()
    }
}

extension HomeViewController: HomeViewProtocol {
    func setupNavigation() {
        view.backgroundColor = .systemBackground
        
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor(named: "Green")
    }

    func setupView() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func reloadCollectionData() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CharacterInfos>()
        snapshot.appendSections([0])
        snapshot.appendItems(interactor.characters)
        
        datasource.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = self.tableView.contentOffset.y
        let contentHeight = self.tableView.contentSize.height
        let height = self.tableView.frame.size.height
        
        if offsetY > contentHeight - height {
            interactor.loadCharacters()
        }
    }
}

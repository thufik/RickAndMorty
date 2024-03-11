import UIKit

protocol HomeViewProtocol: AnyObject {
    func reloadCollectionData(with snapshot: NSDiffableDataSourceSnapshot<Int, CharacterInfos>)
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
                
                let characterInIndex = self.interactor.getCharacter(at: indexPath.row)

                cell.setupCell(character: characterInIndex)
                return cell
                
        })
        
        return datasource
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeCharacterTableViewCell.self, forCellReuseIdentifier: HomeCharacterTableViewCell.cellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
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
    
    @objc private func showFilter() {
        interactor.clickFilter()
    }
}

extension HomeViewController: HomeViewProtocol {
    func setupNavigation() {
        view.backgroundColor = .systemBackground
        
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor(named: "Green")
        navigationItem.rightBarButtonItem =  UIBarButtonItem(
            image: UIImage(named: "Filter")?
                .resizeImage(targetSize: CGSize(width: 25, height: 25)), style: .done, target: self, action: #selector(showFilter))
    }

    func setupView() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func reloadCollectionData(with snapshot: NSDiffableDataSourceSnapshot<Int, CharacterInfos>) {        
        datasource.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = self.tableView.contentOffset.y
        let contentHeight = self.tableView.contentSize.height
        let height = self.tableView.frame.size.height
        
        interactor.scrollViewDidScroll(offsetY: offsetY, height: height, contentHeight: contentHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.selectCellAt(index: indexPath.row)
    }
}

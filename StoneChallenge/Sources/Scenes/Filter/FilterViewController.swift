import UIKit

protocol FilterViewProtocol: AnyObject {
    func setupView()
    func setupConstraints()
    func setupNavigation()
    func setFilterButtonState(isEnabled: Bool)
    
    var statusButtons: [UIButton] { get }
}

class FilterViewController: UIViewController {
    
    private lazy var lblFilterName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome"
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private lazy var filterTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.layer.cornerRadius = 8
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 1
        textfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textfield.addTarget(self, action: #selector(filterEditing), for: .editingChanged)
        return textfield
    }()
    
    private lazy var lblStatus: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Status"
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private lazy var aliveButton: UIButton =  {
        let button =  UIButton()
        button.backgroundColor = .black
        button.setTitle("Alive", for: .normal)
        button.addTarget(self, action: #selector(status), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private lazy var deadButton: UIButton =  {
        let button =  UIButton()
        button.backgroundColor = .black
        button.setTitle("Dead", for: .normal)
        button.addTarget(self, action: #selector(status), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private lazy var unknownButton: UIButton =  {
        let button =  UIButton()
        button.backgroundColor = .black
        button.setTitle("unknown", for: .normal)
        button.addTarget(self, action: #selector(status), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            aliveButton,
            deadButton,
            unknownButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var filterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            lblFilterName,
            filterTextField,
            lblStatus,
            buttonsStackView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var filterButton: UIButton = {
        let button =  UIButton()
        button.addTarget(self, action: #selector(filter), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Green")
        button.setTitle("Filtrar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()

    internal var statusButtons: [UIButton] = []
    
    private var buttonInitialBottomConstraint: NSLayoutConstraint?
    
    private var buttonKeyboardOpenedBottomConstraint: NSLayoutConstraint?
    
    var bottomConstraint: NSLayoutConstraint!
    
    private let interactor: FilterInteractorProtocol
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(interactor: FilterInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
        setupConstraints()
        addKeyboardNotifications()
    }
    
    private func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc
    private func filter() {
        interactor.filter()
    }
    
    @objc
    private func status(button: UIButton) {
        interactor.status(status: Status(rawValue: button.titleLabel?.text ?? .init()))
    }
    
    @objc
    private func filterEditing(textField: UITextField) {
        interactor.filterEditing(with: textField.text)
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            buttonInitialBottomConstraint?.isActive = false
            
            buttonKeyboardOpenedBottomConstraint = NSLayoutConstraint(item: filterButton, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -keyboardHeight)
            buttonKeyboardOpenedBottomConstraint?.isActive = true
            
            DispatchQueue.main.async {
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension FilterViewController: FilterViewProtocol {
    func setupNavigation() {
        view.backgroundColor = .white
        
        title = "Filtro"
        
        statusButtons.append(aliveButton)
        statusButtons.append(deadButton)
        statusButtons.append(unknownButton)
    }

    func setupView() {
        view.addSubview(filterStackView)
        view.addSubview(filterButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            filterStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            filterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        buttonInitialBottomConstraint = NSLayoutConstraint(item: filterButton, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -20)
        buttonInitialBottomConstraint?.isActive = true
    }
    
    func setFilterButtonState(isEnabled: Bool) {
        filterButton.isEnabled = isEnabled
    }
}

import UIKit
import SnapKit
import Kingfisher

class GithubSearchViewController: UIViewController {
  var mrzDetailsViewModel: MRZDetailsViewModel?
  let searchItemsViewModel = GithubSearchItemsViewModel()
  
  // MARK: - Views
  lazy var textField: BetterTextField = {
    let textField = BetterTextField()
    textField.clearButtonMode = .always
    textField.backgroundColor = .white
    textField.font = UIFont.systemFont(ofSize: 12)
    textField.edgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    textField.layer.cornerRadius = 5
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.layer.borderWidth = 0.5
    textField.placeholder = "Enter a MRZ String"
    return textField
  }()
  
  lazy var searchButton: UIButton = {
    let button = UIButton()
    button.setTitle("Search", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(searchButtonTouched(_:)), for: .touchUpInside)
    button.backgroundColor = .orange
    button.layer.cornerRadius = 4
    button.layer.masksToBounds = true
    return button
  }()
  
  lazy var fullNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Enter a MRZ String"
    label.font = UIFont.boldSystemFont(ofSize: 12)
    label.minimumScaleFactor = 0.5
    label.adjustsFontSizeToFitWidth = true
    label.numberOfLines = 1
    return label
  }()
  
  lazy var countryLabel: UILabel = {
    let label = UILabel()
    label.text = "and then hit 'Search'"
    label.font = UIFont.systemFont(ofSize: 10)
    label.textColor = .lightGray
    return label
  }()
  
  lazy var dividerView: UIView = {
    let view = UIView()
    view.backgroundColor = .lightGray
    return view
  }()
  
  lazy var userView: GithubUserView = {
    let userView = GithubUserView()
    userView.alpha = 0
    userView.addTarget(self, action: #selector(userViewTouched(_:)), for: .touchUpInside)
    return userView
  }()
  
  lazy var noUsersLabel: UILabel = {
    let label = UILabel()
    label.text = "No users found"
    label.textColor = UIColor.lightGray
    label.font = UIFont.systemFont(ofSize: 15)
    label.numberOfLines = 0
    label.textAlignment = .center
    label.alpha = 0
    return label
  }()
  
  lazy var topResultLabel: UILabel = {
    let label = UILabel()
    label.alpha = 0
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.text = "Top Result"
    label.textAlignment = .center
    return label
  }()
  
  lazy var seeAllButton: UIButton = {
    let button = UIButton()
    button.alpha = 0
    button.setTitle("See all", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(seeAllButtonTouched(_:)), for: .touchUpInside)
    button.backgroundColor = UIColor(red: 130.0/255.0, green: 193.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    button.layer.cornerRadius = 4
    button.layer.masksToBounds = true
    return button
  }()
  
  // MARK: - View Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Home"
    
    setupViews()
    setupNavigation()
    
    // Uncomment the next line to start the textfield with a random preset
    // textField.text = presets.randomElement()
  }
  
  // MARK: - Setup
  private func setupViews() {
    let textFieldHeight = 44
    let dividerHeight = 0.5
    let buttonWidth = 100
    
    view.backgroundColor = .white
    
    view.addSubview(textField)
    view.addSubview(searchButton)
    view.addSubview(fullNameLabel)
    view.addSubview(dividerView)
    view.addSubview(countryLabel)
    view.addSubview(userView)
    view.addSubview(topResultLabel)
    view.addSubview(seeAllButton)
    view.addSubview(noUsersLabel)
    
    // Auto layout
    textField.snp.makeConstraints { make in
      make.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(Constants.Layout.defaultMargin)
      make.height.equalTo(textFieldHeight)
    }
    
    searchButton.snp.makeConstraints { make in
      make.top.equalTo(textField.snp.bottom).offset(10)
      make.right.height.equalTo(textField)
      make.width.equalTo(buttonWidth)
    }
    
    fullNameLabel.snp.makeConstraints { make in
      make.centerY.equalTo(searchButton).offset(-7)
      make.left.equalTo(textField)
      make.right.equalTo(searchButton.snp.left).offset(-Constants.Layout.defaultMargin)
    }
    
    countryLabel.snp.makeConstraints { make in
      make.bottom.equalTo(dividerView).offset(-10)
      make.left.right.equalTo(dividerView)
    }
    
    dividerView.snp.makeConstraints { make in
      make.bottom.equalTo(searchButton)
      make.left.right.equalTo(fullNameLabel)
      make.height.equalTo(dividerHeight)
    }
    
    topResultLabel.snp.makeConstraints { make in
      make.top.equalTo(dividerView.snp.bottom).offset(Constants.Layout.defaultMargin)
      make.left.right.equalTo(view.safeAreaLayoutGuide).inset(Constants.Layout.defaultMargin)
    }
    
    userView.snp.makeConstraints { make in
      make.top.equalTo(topResultLabel.snp.bottom).offset(15)
      make.centerX.equalTo(view.safeAreaLayoutGuide)
    }
    
    noUsersLabel.snp.makeConstraints { make in
      make.top.equalTo(topResultLabel.snp.bottom).offset(15)
      make.left.right.equalTo(view.safeAreaLayoutGuide).inset(Constants.Layout.defaultMargin)
    }
    
    seeAllButton.snp.makeConstraints { make in
      make.top.equalTo(userView.snp.bottom).offset(Constants.Layout.defaultMargin)
      make.left.right.equalTo(view.safeAreaLayoutGuide).inset(Constants.Layout.defaultMargin)
      make.height.equalTo(textFieldHeight)
    }
  }
  
  private func setupNavigation() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Presets", style: .plain, target: self, action: #selector(presetsButtonTouched(_:)))
  }
  
  // MARK: - Handle
  // Updates the views after viewModels update
  private func update() {
    let hasError = searchItemsViewModel.error != nil
    let hasTopSearchItem = searchItemsViewModel.topSearchItem != nil
    
    // Show / hide top result as needed
    [userView, seeAllButton, topResultLabel].forEach {
      $0.alpha = hasTopSearchItem ? 1 : 0
    }
    
    let noUsersFound = (!hasError && !hasTopSearchItem)
    noUsersLabel.alpha = noUsersFound ? 1 : 0
    
    noUsersLabel.text = "No users found"
    
    if noUsersFound {
      let noUsersFoundMessage = "No users found for\n`\(searchItemsViewModel.query)`"
      Logger.log(noUsersFoundMessage, .warning)
    }
    
    if let topSearchItem = searchItemsViewModel.topSearchItem {
      let viewModel = GithubUserViewModel(topSearchItem)
      userView.usernameLabel.text = viewModel.username
      userView.avatarImageView.kf.setImage(with: viewModel.avatarUrl)
    }
    
    seeAllButton.setTitle(searchItemsViewModel.seeAllButtonText, for: .normal)
    
    fullNameLabel.text = mrzDetailsViewModel?.fullName
    fullNameLabel.textColor = hasError ? .red : .black
    
    countryLabel.text = mrzDetailsViewModel?.country
    countryLabel.textColor = hasError ? .red : .lightGray
    
    if let error = searchItemsViewModel.error {
      handleError(error)
    }
  }
  
  private func handleError(_ error: Error) {
    countryLabel.text = "(Try again)"
    
    var errorMessage = "Unknown error"
    if let error = error as? MRZError {
      switch error {
      case .invalidRawString:
        errorMessage = "Invalid MRZ String"
      }
    }
    
    fullNameLabel.text = errorMessage
    Logger.log(errorMessage, .error)
  }
  
  // MARK: - UIControl actions
  @objc func presetsButtonTouched(_ buttonItem: UIBarButtonItem) {
    let alert = UIAlertController(title: "Presets", message: "Select a preset. This will fill your textfield with the MRZ String you select", preferredStyle: .actionSheet)
    
    // Preset actions
    var actions = Constants.Presets.mrzStrings.map {
      UIAlertAction(title: $0, style: .default) {
        self.textField.text = $0.title
        
        if let text = $0.title {
          self.search(text)
        }
      }
    }
    
    // Cancel action
    actions.append(UIAlertAction(title: "Cancel", style: .cancel))
    
    // Add to alert
    actions.forEach { alert.addAction($0) }
    
    present(alert, animated: true, completion: nil)
  }
  
  @objc func searchButtonTouched(_ button: UIButton) {
    view.endEditing(true)
    
    guard let text = textField.text else { return }
    search(text)
  }
  
  private func search(_ text: String) {
    do {
      // Parse the text as an MRZString
      let mrz = try MRZString(text)
      let mrzViewModel = MRZDetailsViewModel(mrz)
      
      let fullName = mrzViewModel.fullName
      
      self.mrzDetailsViewModel = mrzViewModel
      
      // Fetch from Github
      searchItemsViewModel.searchUsers(fullName) { [weak self] viewModel in
        self?.update()
      }
    } catch {
      // There was an issue with parsing MRZString
      self.mrzDetailsViewModel = nil
      searchItemsViewModel.clear()
      searchItemsViewModel.setError(error)
      update()
    }
  }
  
  @objc func seeAllButtonTouched(_ button: UIButton) {
    let searchItemsViewController = GithubSearchItemsViewController(searchItemsViewModel)
    navigationController?.pushViewController(searchItemsViewController, animated: true)
  }
  
  @objc func userViewTouched(_ userView: GithubUserView) {
    guard let topSearchItem = searchItemsViewModel.topSearchItem else { return }
    ApplicationController.shared.openGithubProfile(fromGithubSearchItem: topSearchItem)
  }
}

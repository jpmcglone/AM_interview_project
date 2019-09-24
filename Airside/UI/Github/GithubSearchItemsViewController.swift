import SnapKit
import Kingfisher

class GithubSearchItemsViewController: UITableViewController {
	let searchItemsViewModel: GithubSearchItemsViewModel
	
	private let cellReuseIdentifier = "cell"
	
	init(_ searchItemsViewModel: GithubSearchItemsViewModel) {
		self.searchItemsViewModel = searchItemsViewModel
		
		super.init(style: .plain)
		title = searchItemsViewModel.query
		tableView.rowHeight = 84
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = searchItemsViewModel.items[indexPath.row]
		
		var cell: GithubUserCell! = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? GithubUserCell
		if cell == nil {
			cell = GithubUserCell(style: .default, reuseIdentifier: cellReuseIdentifier)
		}
		
		let viewModel = GithubUserViewModel(item)
		cell.avatarImageView.kf.setImage(with: viewModel.avatarUrl)
		cell.usernameLabel.text = viewModel.username
		
		// Pagination
		if indexPath.row == searchItemsViewModel.items.count - 1 {
			searchItemsViewModel.fetchNextPage { [weak self] _ in
				self?.tableView.reloadData()
			}
    }
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchItemsViewModel.items.count
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let item = searchItemsViewModel.items[indexPath.row]
		ApplicationController.shared.openGithubProfile(fromGithubSearchItem: item)
	}
}

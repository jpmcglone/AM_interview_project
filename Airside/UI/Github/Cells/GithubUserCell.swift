import SnapKit

class GithubUserCell: UITableViewCell {
	let avatarImageView = UIImageView()
	let usernameLabel = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		accessoryType = .disclosureIndicator
		setupViews()
	}
	
	private func setupViews() {
		let avatarHeight: CGFloat = 44
		
		contentView.addSubview(avatarImageView)
		contentView.addSubview(usernameLabel)
		
		avatarImageView.layer.cornerRadius = avatarHeight / 2.0
		avatarImageView.layer.borderWidth = 0.5
		avatarImageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
		avatarImageView.layer.masksToBounds = true
		
		avatarImageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
		avatarImageView.snp.makeConstraints { make in
			make.width.height.equalTo(avatarHeight)
			make.width.equalTo(avatarImageView.snp.height)
			make.top.bottom.left.equalToSuperview().inset(Constants.Layout.defaultMargin)
		}
		
		usernameLabel.textColor = .black
		usernameLabel.font = UIFont.systemFont(ofSize: 16)
		usernameLabel.snp.makeConstraints { make in
			make.left.equalTo(avatarImageView.snp.right).offset(10)
			make.centerY.equalTo(avatarImageView)
			make.right.equalToSuperview().inset(Constants.Layout.defaultMargin)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

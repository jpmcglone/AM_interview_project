import SnapKit

class GithubUserView: UIControl {
	let contentView = UIView()
	let avatarImageView = UIImageView()
	let usernameLabel = UILabel()
	
	override var isHighlighted: Bool {
		didSet {
			let scale: CGFloat = isHighlighted ? 1.1 : 1.0

			UIView.animate(withDuration: 0.2) {
				self.contentView.backgroundColor = self.isHighlighted ? UIColor.lightGray.withAlphaComponent(0.1) : .clear
				self.contentView.transform = CGAffineTransform(scaleX: scale, y: scale)
			}
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(contentView)
		contentView.addSubview(avatarImageView)
		contentView.addSubview(usernameLabel)
		
		contentView.isUserInteractionEnabled = false
		
		contentView.layer.cornerRadius = 5
		contentView.layer.masksToBounds = true
		contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
		contentView.layer.borderWidth = 0.5
		
		let avatarHeight: CGFloat = 100
		avatarImageView.layer.cornerRadius = avatarHeight/2
		avatarImageView.layer.masksToBounds = true
		avatarImageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
		
		contentView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		avatarImageView.snp.makeConstraints { make in
			make.height.width.equalTo(100)
			make.top.left.right.equalToSuperview().inset(Constants.Layout.defaultMargin)
		}
		
		usernameLabel.textAlignment = .center
		usernameLabel.font = UIFont.systemFont(ofSize: 16)
		usernameLabel.snp.makeConstraints { make in
			make.top.equalTo(avatarImageView.snp.bottom).offset(10)
			make.left.right.bottom.equalToSuperview().inset(Constants.Layout.defaultMargin)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

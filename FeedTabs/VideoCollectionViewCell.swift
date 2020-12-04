//
//  VideoCollectionViewCell.swift
//  Feed
//
//  Created by John Zulewski on 11/14/20.
//

import UIKit
import AVFoundation

protocol VideoCollectionViewCellDelegate: AnyObject {
    func didTapLikeButton(with model: VideoModel)
    
    func didTapProfileButton(with model: VideoModel)
    
    func didTapSbareButton(with model: VideoModel)
    
    func didTapCommentButton(with model: VideoModel)
}

class VideoCollectionViewCell: UICollectionViewCell {
    
    
    static let identifer = "VideoCollectionViewCell"
    
    // Labels
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Light", size: 24)
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let hashtagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    // Buttons
    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "colorPedal"), for: .normal)
        button.tintColor = UIColor(named: "Color")
        return button
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor(named: "Color")
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "text.bubble"), for: .normal)
        button.tintColor = UIColor(named: "Color")
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        button.tintColor = UIColor(named: "Color")
        return button
    }()
    
    // Delegate
    
    private let videoContainer: UIView = UIView()
    
    weak var delegate: VideoCollectionViewCellDelegate?
    
    // Subviews
    var player: AVPlayer?
    
    private var model: VideoModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        addSubviews()
    }
    
    private func addSubviews() {
        
        contentView.addSubview(videoContainer)
        
        contentView.addSubview(usernameLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(hashtagLabel)
        
        contentView.addSubview(profileButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        
        // Add actions
        profileButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchDown)
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchDown)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchDown)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchDown)
        
        videoContainer.clipsToBounds = true
        
        contentView.sendSubviewToBack(videoContainer)
    }
    
    @objc private func didTapProfileButton() {
        guard let model = model else { return }
        delegate?.didTapProfileButton(with: model)
    }
    
    @objc private func didTapLikeButton() {
        guard let model = model else { return }
            delegate?.didTapLikeButton(with: model)
    }
    
    @objc private func didTapCommentButton() {
        guard let model = model else { return }
        delegate?.didTapCommentButton(with: model)
        
    }
    
    @objc private func didTapShareButton() {
        guard let model = model else { return }
        delegate?.didTapSbareButton(with: model)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        videoContainer.frame = contentView.bounds
        
        let size = contentView.frame.size.width/7
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height - 100
        
        // Buttons
        shareButton.frame = CGRect(x: width-size, y: height-size, width: size, height: size)
        commentButton.frame = CGRect(x: width-size, y: height-(size*2)-10, width: size, height: size)
        likeButton.frame = CGRect(x: width-size, y: height-(size*3)-10, width: size, height: size)
        profileButton.frame = CGRect(x: width-size, y: height-(size*4)-10, width: size, height: size)
        
        // Labels
        hashtagLabel.frame = CGRect(x: 5, y: height-(size*4)+90, width: width-size-10, height: 50)
        captionLabel.frame = CGRect(x: 5, y: height-(size*4)+40, width: width-size-10, height: 50)
        usernameLabel.frame = CGRect(x: 5, y: height-(size*4)-10, width: width-size-10, height: 50)
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        captionLabel.text =  nil
        usernameLabel.text = nil
        usernameLabel.text = nil
        
    }
    
    public func configure(with model: VideoModel) {
        self.model = model
        configureVideo()
        
        // labels
        captionLabel.text =  model.caption
        hashtagLabel.text = model.hashtags
        usernameLabel.text = model.username
        
    }
    
    private func configureVideo() {
        guard let model = model else {
            return
        }
        
        
        guard let path = Bundle.main.path(forResource: model.videoFileName, ofType: model.videoFileFormat) else {
            return
        }
        
        
        player = AVPlayer(url: URL(fileURLWithPath: path))
        
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
        videoContainer.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  MagneticDetectionViewController.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 09/04/2024.
//

import UIKit
import Lottie
import Combine

final class MagneticDetectionViewController: UIViewController {

    // MARK: - Properties
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .magneticDetection
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .magneticSearch
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .searchArrow
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let searchLabel = UILabel()
    
    private let mainButton = PrimaryButton()
    private let titleLabel = UILabel()
    
    // MARK: - Lifecycle
    
    private let viewModel: MagneticDetectionViewModel
    private var disposeBag: Set<AnyCancellable> = []
    
    private var arrowOriginX: CGFloat = 0
    
    // MARK: - Lifecycle
    
    init(viewModel: MagneticDetectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.titleView = titleLabel

        bind()
        setupUI()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let originX = view.frame.size.width / 2 - CGFloat(Constant.arrowSize)
        let originY = arrowImageView.frame.origin.y
        let width = arrowImageView.frame.width
        let height = arrowImageView.frame.height
        arrowImageView.frame = .init(x: originX, y: originY, width: width, height: height)
    }
 
    // MARK: - Actions
    
    private func bind() {
        viewModel.statePublisher
            .sink { [weak self] state in
                self?.updateUI(with: state)
            }
            .store(in: &disposeBag)
    }
    
    private func startAnimation() {
        arrowImageView.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
        let rotationAnimation = CABasicAnimation(keyPath: Constant.transformAnimation)
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi
        rotationAnimation.duration = 2
        rotationAnimation.autoreverses = true
        rotationAnimation.repeatCount = .infinity
        arrowImageView.layer.add(rotationAnimation, forKey: Constant.rotationAnimation)
    }
    
    private func updateUI(with state: MagneticDetectionState) {
        switch state {

        case .searching:
            mainButton.setupTitle(Constant.stop)
            mainButton.didPress = { [weak self] in
                guard let self else { return }
                
                self.stopAnimation()
                self.viewModel.stopSearching()
            }
            
        case .inactive:
            mainButton.setupTitle(Constant.search)
            mainButton.didPress = { [weak self] in
                guard let self else { return }
                
                self.startAnimation()
                self.viewModel.search()
            }
        }
    }
    
    private func stopAnimation() {
        arrowImageView.layer.removeAllAnimations()
    }
    
    private func setupUI() {
        view.backgroundColor = .appBackground
        
        titleLabel.setText(
            Constant.title,
            font: .robotoSemibold(ofSize: Constant.textSize),
            color: .appWhite
        )
        
        searchLabel.setText(
            Constant.searchChecking,
            font: .robotoSemibold(ofSize: Constant.textSize),
            color: .appWhite
        )
    }
    
    private func setupConstraints() {
        view.addSubviews([headerImageView, searchImageView, arrowImageView, searchLabel, mainButton])

        headerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Constant.imageHeight)
        }
        
        searchImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constant.standardInset)
            make.centerX.equalToSuperview()
            make.top.equalTo(headerImageView.snp.bottom).offset(62)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.centerX).inset(16)
            make.bottom.equalTo(searchImageView.snp.bottom).offset(16)
            make.width.equalTo(Constant.arrowSize)
        }
        
        searchLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constant.standardInset)
            make.top.equalTo(searchImageView.snp.bottom).offset(47)
        }
        
        mainButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(Constant.standardInset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(36)
        }
        
        arrowOriginX = arrowImageView.frame.origin.x
    }
}

private extension MagneticDetectionViewController {
    enum Constant {
        // Adopt image size depending on device
        static let imageHeight = UIDevice.current.screenSize == .small ? 230 : 329 // 329 * 0.7
        static let arrowSize = UIDevice.current.screenSize == .small ? 80 : 100 // 100 * 0.8
        // Text
        static let searchChecking = "Search checking"
        static let title = "Magnetic Detection"
        static let stop = "Stop"
        static let search = "Search"
        // Text size
        static let textSize: CGFloat = 17
        // Inset
        static let standardInset = 20
        // Animation keys
        static let rotationAnimation = "rotationAnimation"
        static let transformAnimation = "transform.rotation"
    }
}

//
//  DescriptionViewController.swift
//  SignsForCorpus
//
//  Created by IlyaCool on 25.07.22.
//

import Foundation
import UIKit

protocol DescriptionViewProtocol {
    var presenter: DescriptionPresenterProtocol! { get set }
    func set(sign: Sign)
}

class DescriptionViewController: UIViewController {
    var presenter: DescriptionPresenterProtocol!
    
    private var picturesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: Config.Constants.picturesCollectionHeight)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    private var currentCollectionState: Sign! {
        didSet {
            self.signDescription.text = String(htmlEncodedString: self.currentCollectionState.description)
        }
    }
    private var pictures = [UIImage]()
    
    private var signDescription: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        title = currentCollectionState.name
        setupUI()
        setupConstraints()
        downloadPictures()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(picturesCollectionView)
        view.addSubview(signDescription)
        setupCollection()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            picturesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            picturesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            picturesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            picturesCollectionView.heightAnchor.constraint(equalToConstant: Config.Constants.picturesCollectionHeight),
            signDescription.topAnchor.constraint(equalTo: picturesCollectionView.bottomAnchor, constant: Config.Constants.normalSpacing),
            signDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Config.Constants.normalSpacing),
            signDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Config.Constants.normalSpacing)
        ])
    }
    
    func downloadPictures() {
        currentCollectionState.picturesUrl.forEach { pictureUrl in
            presenter.fetchImage(inUrl: pictureUrl) { imageData, error in
                if let _ = error { return }
                guard let imageData = imageData else { return }
                self.pictures.append(UIImage(data: imageData) ?? UIImage())
                self.picturesCollectionView.reloadData()
            }
        }
    }
    
    func setupCollection() {
        picturesCollectionView.dataSource = self
        picturesCollectionView.delegate = self
        picturesCollectionView.register(PictureCollectionCell.self, forCellWithReuseIdentifier: PictureCollectionCell.identifier)
        picturesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        picturesCollectionView.showsVerticalScrollIndicator = false
        picturesCollectionView.showsHorizontalScrollIndicator = false
        picturesCollectionView.allowsSelection = false
        picturesCollectionView.isPagingEnabled = true
    }
}

extension DescriptionViewController: DescriptionViewProtocol {
    func set(sign: Sign) {
        currentCollectionState = sign
    }
    
}

extension DescriptionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = picturesCollectionView.dequeueReusableCell(withReuseIdentifier: PictureCollectionCell.identifier, for: indexPath) as? PictureCollectionCell
        
        cell?.imageView.image = pictures[indexPath.row]
        
        return cell!
    }
    
}

class PictureCollectionCell: UICollectionViewCell {
    static let identifier = "PictureCollectionCell"
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

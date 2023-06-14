//
//  ImageSearchViewController.swift
//  Programmatic-UI
//
//  Created by deepak-pt6306 on 17/05/23.
//

import UIKit

class ImageSearchViewController: UIViewController {
    
    private let reuseIdentifier = "ImageCell"
    private let searchURL = "https://api.unsplash.com/search/photos?query="
    private let accessKey = "WZ3zmr7KXhXD76M1nTpcO1p3zqkw6vzWZ3DhFE_a1Pk"
    private var images: [UIImage] = []
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Images"
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchImages(for query: String) {
        guard let url = URL(string: searchURL + query + "&client_id=" + accessKey) else {
                print("Invalid URL")
                return
            }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                // Assuming the response is in JSON format and contains an array of image URLs
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let imageURLs = json?["imageURLs"] as? [String] ?? []

                DispatchQueue.global().async {
                    let imageDownloadGroup = DispatchGroup()

                    for imageURLString in imageURLs {
                        guard let imageURL = URL(string: imageURLString) else { continue }
                        imageDownloadGroup.enter()

                        URLSession.shared.dataTask(with: imageURL) { (imageData, _, _) in
                            defer { imageDownloadGroup.leave() }

                            if let imageData = imageData, let image = UIImage(data: imageData) {
                                print("images Appended")
                                self?.images.append(image)
                            }
                        }.resume()
                    }

                    imageDownloadGroup.wait()

                    DispatchQueue.main.async {
                        print("CView reloaded")
                        self?.collectionView.reloadData()
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }

}

extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            images.removeAll()
            collectionView.reloadData()
            fetchImages(for: query)
        }
        
        searchBar.resignFirstResponder()
    }
}

extension ImageSearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        
        cell.imageView.image = images[indexPath.item]
        return cell
    }
}

class ImageCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


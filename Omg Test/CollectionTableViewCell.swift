//
//  CollectionTableViewCell.swift
//  Omg Test
//
//  Created by Fanil_Jr on 29.02.2024.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    var timer: Timer?
    var numbers = [0,1,2,3,4,5,6,7,8,9,10,11,12]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.bounds.width / 12, height: self.bounds.width / 12)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(randomNumberForItem), userInfo: nil, repeats: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func randomNumberForItem() {
        let randomIndex = Int.random(in: 0..<numbers.count)
        numbers[randomIndex] = Int.random(in: 0...12)
        DispatchQueue.main.async {
            self.collectionView.reloadItems(at: [IndexPath(item: randomIndex, section: 0)])
        }
    }

    
    private func layout() {
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.label.text = "\(numbers[indexPath.item])"
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.7
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 7
        return cell
    }
}

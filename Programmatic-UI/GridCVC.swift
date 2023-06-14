//
//  GridCVC.swift
//  Programmatic-UI
//
//  Created by deepak-pt6306 on 22/02/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class GridCVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .green
        collectionView!.register(TeamCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.removeFromSuperview()
        setBackground()
        collectionView.backgroundColor = UIColor.clear
        
        self.view.addSubview(collectionView)
    }
    
    func setBackground(){
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
    
        view.addSubview(imageView)
        
        let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurEffect.frame = imageView.bounds
        view.addSubview(blurEffect)
    }

    


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 30
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TeamCell
        cell.imageView.image = UIImage(named: "Image")
        cell.backgroundColor = .green
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let nc = UINavigationController(rootViewController: collectionView)
//        UINavigationController.pushViewController(nc)
        print(indexPath.row)
    }
    
//     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)->CGSize{
//        return CGSize(width: <#T##Double#>, height: <#T##Double#>)
//    }
    

}


class TeamCell : UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(label)
        imageView.frame = bounds
        label.frame = bounds
        setCellShadow()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let label = UILabel()
   
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setCellShadow(){
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 3
        layer.shadowRadius = 3
        label.text = "Hello"
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|",metrics: nil, views: ["v0":label]))
    }
}

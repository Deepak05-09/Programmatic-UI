//
//  ViewController.swift
//  Programmatic-UI
//
//  Created by deepak-pt6306 on 22/02/23.
//

import UIKit

class ViewController: UIViewController {

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
//        view.backgroundColor = .red
    }
    
    func setUP(){
        
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.center = view.center
        button.setTitle("Enter", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action:#selector(click), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func click(){
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-3, height: (view.frame.size.width/3)-3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let vc = GridCVC(collectionViewLayout: layout)
       vc.title = "House"
        
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
        
    }


}

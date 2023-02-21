//
//  UiswitchVC.swift
//  Programmatic-UI
//
//  Created by deepak-pt6306 on 21/02/23.
//

import UIKit

class UiswitchVC: UIViewController {
    
    let swiTch = UISwitch()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupLabel()
        setupSwitch()
    }
    
    func setupLabel(){
        label.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        label.backgroundColor = .white
        label.textColor = .purple
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir next", size: 100)
        
        view.addSubview(label)
    }
        
    func setupSwitch(){
        view.addSubview(swiTch)
        swiTch.frame = CGRect(x: 40, y: 500, width: 100, height: 100)
        swiTch.center = view.center
        swiTch.backgroundColor = .green
    }

}

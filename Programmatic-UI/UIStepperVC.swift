//
//  UIStepperVC.swift
//  Programmatic-UI
//
//  Created by deepak-pt6306 on 21/02/23.
//

import UIKit

class UIStepperVC: UIViewController {
    
    let stepper = UIStepper()
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStepper()
        setupLabel()
    }
    
    func setUpStepper(){
        stepper.center = view.center
        
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        
        stepper.backgroundColor = .red
        stepper.autorepeat = true
        stepper.stepValue = 2
        
        stepper.addTarget(self, action: #selector(action), for: .valueChanged)
        view.addSubview(stepper)
        
    }
    
    func setupLabel(){
        label.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        label.backgroundColor = .white
        label.textColor = .purple
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir next", size: 100)
        
        view.addSubview(label)
    }
    
    @objc func action(){
        label.text = "\(stepper.value)"
    }
    

}

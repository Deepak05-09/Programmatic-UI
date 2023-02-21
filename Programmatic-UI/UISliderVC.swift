//
//  UISliderVC.swift
//  Programmatic-UI
//
//  Created by deepak-pt6306 on 21/02/23.
//

import UIKit

class UISliderVC: UIViewController {

    let redSlider = UISlider()
    let greenSlider = UISlider()
    let blueSlider = UISlider()
    
    let label = UILabel()
    let labelForvalue = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupSliders()
        setUpLabels()
    }
    
    func setUpLabels(){
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        label.center = view.center
        label.backgroundColor = .white
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
    }
    
    func setupSliders(){
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        blueSlider.tintColor = .blue
        
        redSlider.maximumValue = 255
        greenSlider.maximumValue = 255
        blueSlider.maximumValue = 255
        
        redSlider.minimumValue = 0
        greenSlider.minimumValue = 0
        blueSlider.minimumValue = 0
        
        redSlider.maximumValueImage = UIImage(systemName: "sun.max")
        greenSlider.maximumValueImage = UIImage(systemName: "sun.max")
        blueSlider.maximumValueImage = UIImage(systemName: "sun.max")
        
        redSlider.minimumValueImage = UIImage(systemName: "sun.min")
        greenSlider.minimumValueImage = UIImage(systemName: "sun.min")
        blueSlider.minimumValueImage = UIImage(systemName: "sun.min")
        
        redSlider.frame = CGRect(x: 10, y: 180, width: 300, height: 20)
        greenSlider.frame = CGRect(x: 10, y: 100, width: 300, height: 20)
        blueSlider.frame = CGRect(x: 10, y: 140, width: 300, height: 20)
        
        redSlider.addTarget(self, action: #selector(slider), for: .valueChanged)
        greenSlider.addTarget(self, action: #selector(slider), for: .valueChanged)
        blueSlider.addTarget(self, action: #selector(slider), for: .valueChanged)
        
        view.addSubview(redSlider)
        view.addSubview(blueSlider)
        view.addSubview(greenSlider)
        
    }
    
    @objc func slider(){
        label.text = "RED : \(redSlider.value)\nGREEN : \(greenSlider.value)\nBLUE : \(blueSlider.value)"
    }
   

}

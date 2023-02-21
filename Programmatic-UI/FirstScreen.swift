//
//  FirstScreen.swift
//  Programmatic-UI
//
//  Created by sysadmin on 14/02/23.
//

import UIKit

class FirstScreen: UIViewController {
    
    let topLabel = UILabel()
    let enterButton = UIButton()
    let flipButton = UIButton()
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTopLabel()
        setUpEnterButton()
        setUpFlipButton()
        //setupTextField()
        title="First Screen"
        
    }
    
    func setupTextField(){
        view.addSubview(textField)
        textField.backgroundColor = .gray
        textField.placeholder = "Username or Email"
        textField.textAlignment = .left
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
   
    func setUpTopLabel(){
        
        view.addSubview(topLabel)
       topLabel.text = "Welcome...!\nThis is the first screen Select enter to go next screen  "
        topLabel.numberOfLines = 0
        topLabel.font = UIFont(name: "Avenir Next", size: 25)
        topLabel.textColor = .red
        topLabel.lineBreakMode = .byWordWrapping
        
       
        let size = topLabel.sizeThatFits(CGSize(width: view.bounds.size.width, height: CGFLOAT_MAX))
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topLabel.widthAnchor.constraint(equalToConstant: view.bounds.size.width),
            topLabel.heightAnchor.constraint(equalToConstant: size.height),
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            topLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10)
        ])
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                timer.fire()
        
    }
    
    @objc func updateTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        flipButton.setTitle(formatter.string(from: Date()), for: .normal)
    }
    
    func date(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        flipButton.setTitle(formatter.string(from: Date()), for: .selected)
    }
    
    func setUpEnterButton(){
        view.addSubview(enterButton)
        
        enterButton.configuration = .filled()
        enterButton.configuration?.baseBackgroundColor = .green
        enterButton.configuration?.title="Enter"
        
        enterButton.addTarget(self, action: #selector(goToNextScreen(sender:)), for: .touchUpInside)
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            enterButton.widthAnchor.constraint(equalToConstant: 200),
            enterButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func goToNextScreen(sender : UIButton){
        sender.isSelected = !sender.isSelected
//        let nextScreen = SecondScreen()
//        nextScreen.title="Second Screen"
//        navigationController?.pushViewController(nextScreen, animated: true)
        animateButton(sender)
        sender.configuration?.baseBackgroundColor = {
            sender.isSelected ? .red : .green
        }()
        
        sender.configuration?.subtitle = {
            !sender.isSelected ? "click to see date" : "click to see time"
        }()
        
    }
    
    func animateButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.15,
                       animations: {
            button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                       },
                       completion: { _ in
            UIView.animate(withDuration: 0.15) {
                               button.transform = CGAffineTransform.identity
                           }
                       })
    }
    
    
    func setUpFlipButton(){
        view.addSubview(flipButton)
        flipButton.configuration = .filled()
        flipButton.configuration?.baseBackgroundColor = .green
        flipButton.configuration?.baseForegroundColor = .black
        flipButton.addTarget(self, action: #selector(goToNextScreen(sender:)), for: .touchUpInside
        )
        //skipButton.setTitle("YES", for: .normal)
        //flipButton.setTitle("NO", for: .selected)
        date()
        flipButton.configuration?.subtitle = "click to see date"
        flipButton.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            flipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flipButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            flipButton.widthAnchor.constraint(equalToConstant: 150),
            flipButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        flipButton.setImage(UIImage(systemName: "clock"), for: .normal)
        flipButton.setImage(UIImage(systemName: "calendar"), for: .selected)
       
    }
    

}


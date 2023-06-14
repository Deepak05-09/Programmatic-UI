//
//  Networking.swift
//  Programmatic-UI
//
//  Created by deepak-pt6306 on 11/05/23.
//

import UIKit

class Networking: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGray
        setStack()
    }
    

    let getButton : UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.setTitle("GET", for: .normal)
        button.configuration?.baseForegroundColor = .green
        button.configuration?.baseBackgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let postButton : UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.setTitle("POST", for: .normal)
        button.configuration?.baseForegroundColor = .green
        button.configuration?.baseBackgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    func setStack(){
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(getButton)
        stackView.addArrangedSubview(postButton)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.widthAnchor.constraint(equalToConstant: 100),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        getButton.addTarget(self, action: #selector(getTapped), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(postTapped), for: .touchUpInside)
    }
    
    @objc func getTapped(){
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/users") else { return }
        let session = URLSession.shared
        session.dataTask(with: url){ (data,response,error) in
            if let response = response {
                print("Response = \(response)")
            }
            if let data = data {
                print("data =\(data)")
                
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data)
                    print (jsonData)
                } catch {
                    print(error)
                }
            }
            
            if let error = error {
                print("error = \(error)")
            }
            
        }.resume()
        
    }
    
    @objc func postTapped(){
        
        let parameters = ["one" : 1 , "two" : 2,"Three" : 3]
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters) else { return }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        let session = URLSession.shared
        
        session.dataTask(with: request){(data,response, error) in
            if let response = response {
                print("Response ---------- \(response)")
            }
            if let data = data{
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    print("Data --------- \(json)")
                }
                catch {
                    print("data Error -------- \(error)")
                }
            }
            if let error = error{
                print("error --------- \(error)")
            }
        }.resume()
    
    }

}

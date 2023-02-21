//
//  DatePickerVC.swift
//  Programmatic-UI
//
//  Created by sysadmin on 17/02/23.
//

import UIKit

class DatePickerVC: UIViewController {

    let textfield = UITextField()
    let datepicker = UIDatePicker()
    let barButton = UIBarButtonItem()
    let tool = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTextField()
        setUpDatePicker()
        setupToolBar()
       
    }
    
    func setUpDatePicker(){
        datepicker.preferredDatePickerStyle = .wheels
        datepicker.datePickerMode = .date
    }
    
    func setUpTextField(){
        view.addSubview(textfield)
        textfield.placeholder = "enter your date of birth"
        textfield.backgroundColor = .lightGray
        textfield.borderStyle = .roundedRect
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = UIColor.black.cgColor
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        textfield.inputView = datepicker
        
        
        NSLayoutConstraint.activate([
            textfield.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textfield.widthAnchor.constraint(equalToConstant: 400),
            textfield.heightAnchor.constraint(equalToConstant:50)

        ])
    }
    
    func setupToolBar(){
        textfield.inputAccessoryView = tool
        tool.sizeToFit()
        tool.backgroundColor = .purple
        
        let btn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(clicked))
        tool.setItems([btn], animated: true)
    }
    
    @objc func clicked(){
        let Dformat = DateFormatter()
        Dformat.dateFormat = "dd/MM/yyyy"
        textfield.text = Dformat.string(from: datepicker.date)
        view.endEditing(true)
    }
    
}

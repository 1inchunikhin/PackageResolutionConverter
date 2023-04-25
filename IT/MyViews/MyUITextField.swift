//
//  MyUITextField.swift
//  IT
//
//  Created by Николай Чунихин on 29.01.2023.
//

import UIKit

final class MyUITextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private Methods
extension MyUITextField {
    func setupTextField() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 30
        textColor = .gray
        textAlignment = .center
        backgroundColor = .lightGray
        font = .systemFont(ofSize: 25, weight: .medium)
    }
    
    
}

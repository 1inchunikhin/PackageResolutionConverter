//
//  MyUIButton.swift
//  IT
//
//  Created by Николай Чунихин on 29.01.2023.
//

import UIKit

final class MyUIButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private Methods
extension MyUIButton {
    func setupButton() {
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 30
        tintColor = .black
    }
    
    func setFontAndTitle(title: String){
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
    }
}

//
//  MainView.swift
//  IT
//
//  Created by Николай Чунихин on 29.01.2023.
//

import UIKit

final class MainView: UIView {
    
    //MARK: - Private Properties
    
    weak var delegate: ButtonLogicDelegate?
    
    private let heightTextField: MyUITextField = {
        let textField = MyUITextField()
        textField.setupTextField()
        textField.placeholder = "height"
        return textField
    }()
    
    private let widthTextField: MyUITextField = {
        let textField = MyUITextField()
        textField.setupTextField()
        textField.placeholder = "width"
        return textField
    }()
    
    private let textFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var pickPhotoButton: MyUIButton = {
        let button = MyUIButton(type: .system)
        button.setFontAndTitle(title: "Выбрать фото")
        button.addTarget(self, action: #selector(showPhotoLibrary), for: .touchUpInside)
        return button
    }()
    
    private lazy var downloadButton: MyUIButton = {
        let button = MyUIButton(type: .system)
        button.setFontAndTitle(title: "Скачать фото")
        button.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
        return button
    }()
    
    private let commonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func saveButton() {
        
        downloadButton.pushAnimate { [weak self] in
            self?.delegate?.savePhoto(textHeight: self?.heightTextField.text, textWidth: self?.widthTextField.text)
        }
    }
    
    @objc func showPhotoLibrary() {
        pickPhotoButton.pushAnimate { [weak self] in
            self?.delegate?.takePhoto()
        }
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        addSubview()
        setupConstraints()
    }
    
    private func addSubview() {
        addSubviews(pickPhotoButton,
                         downloadButton,
                         textFieldStackView,
                         commonStackView)
        
        textFieldStackView.addArrangedSubviews(heightTextField,
                                               widthTextField)
        
        commonStackView.addArrangedSubviews(textFieldStackView,
                                            downloadButton,
                                            pickPhotoButton)
    }
    
    private func setupConstraints() {
        let buttonHeight: CGFloat = 64
        NSLayoutConstraint.activate([
            pickPhotoButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            downloadButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            textFieldStackView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            commonStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            commonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            commonStackView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor, constant: -64)
        ])
    }
}

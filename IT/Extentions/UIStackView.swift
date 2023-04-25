//
//  UIStackView.swift
//  IT
//
//  Created by Николай Чунихин on 29.01.2023.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}

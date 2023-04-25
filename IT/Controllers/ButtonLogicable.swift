//
//  ButtonLogicable.swift
//  IT
//
//  Created by Николай Чунихин on 29.01.2023.
//

import UIKit

protocol ButtonLogicDelegate: AnyObject {
    
    func savePhoto(textHeight: String?, textWidth: String?)
    
    func takePhoto()
}

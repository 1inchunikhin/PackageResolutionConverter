//
//  ViewController.swift
//  IT
//
//  Created by Николай Чунихин on 25.01.2023.
//

import UIKit
import PhotosUI

final class ViewController: UIViewController {

    //MARK: - Private Properties
    
    private var photos: [UIImage] = []
    private var widthPhoto: CGFloat = 0
    private var heightPhoto: CGFloat = 0
    
    let mainView: MainView = {
        let view = MainView()
        return view
    }()
    
    //MARK: - life cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    
}

    //MARK: - extension

extension ViewController {
    
    private func savePhotos(textHeight: String, textWidth: String) {
        
        if (textWidth != "" && textHeight != "") {
            if let heightInt = Int(textHeight){
                heightPhoto = CGFloat(heightInt)
            }
            if let widthInt = Int(textWidth){
                widthPhoto = CGFloat(widthInt)
            }
        }

        if photos.count != 0 {
            let num = photos.count
            for _ in 0...num{
                if photos.isEmpty{

                } else {
                    photos[0] = resizeImage(image: photos.first!, targetSize: CGSize(width: widthPhoto, height: heightPhoto))
                    UIImageWriteToSavedPhotosAlbum(photos.first!, self, nil, nil)
                    photos.removeFirst()
                }
            }

            let alert = UIAlertController(title: "Сохранено",
                                          message: "Ваши фото были сохранены",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }

    //MARK: - Algoritm
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
       let size = image.size

       let widthRatio  = targetSize.width  / size.width
       let heightRatio = targetSize.height / size.height

       var newSize: CGSize
       if(widthRatio > heightRatio) {
           newSize = CGSize(width: size.width * heightRatio,
                            height: size.height * heightRatio)
       } else {
           newSize = CGSize(width: size.width * widthRatio,
                            height: size.height * widthRatio)
       }

       let rect = CGRect(x: 0,
                         y: 0,
                         width: newSize.width,
                         height: newSize.height)

       UIGraphicsBeginImageContextWithOptions(newSize,
                                              false,
                                              1.0)
       image.draw(in: rect)
       let newImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       return newImage!
   }
    
    func pickPhoto() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 20
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        
        present(picker, animated: true)
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage{
                    self.photos.append(image)
                }
            }
        }
    }
}

extension ViewController: ButtonLogicDelegate {
    func savePhoto(textHeight: String?, textWidth: String?) {
        guard let height = textHeight,
              let width = textWidth else { return }
        savePhotos(textHeight: height, textWidth: width)
    }
    
    func takePhoto() {
        pickPhoto()
    }
    
}

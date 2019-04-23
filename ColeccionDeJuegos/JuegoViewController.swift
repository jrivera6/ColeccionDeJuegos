//
//  JuegoViewController.swift
//  ColeccionDeJuegos
//
//  Created by Jhonny Rivera on 4/23/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit

class JuegoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var JuegoImageView: UIImageView!
    
    
    @IBOutlet weak var tituloTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }
    
    
    
    @IBAction func fotosStapped(_ sender: Any) {
    
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    //Swift 4.2
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let imgSeleccionado = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        JuegoImageView.image = imgSeleccionado
//        imagePicker.dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imgSeleccionado = info[UIImagePickerControllerOriginalImage] as! UIImage
        JuegoImageView.image = imgSeleccionado
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camaraStapped(_ sender: Any) {
    }
    
    @IBAction func agregarStapped(_ sender: Any) {
        
        let delegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = delegate.persistentContainer.viewContext
        
        let juego = Juego(context: context)
        juego.titulo = tituloTextField.text
        juego.imagen = UIImagePNGRepresentation(JuegoImageView.image!) as Data?
        
        delegate.saveContext()
        navigationController!.popViewController(animated: true)
        
        
    }
    
}

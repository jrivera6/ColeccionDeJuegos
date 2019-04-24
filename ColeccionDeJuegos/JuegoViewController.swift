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
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    var juego : Juego? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if juego != nil{
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden = true
        }
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
        
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func agregarStapped(_ sender: Any) {
        
        let delegate = (UIApplication.shared.delegate as! AppDelegate)
        
        if juego != nil{
            juego!.titulo = tituloTextField.text
            juego!.imagen = UIImagePNGRepresentation(JuegoImageView.image!) as Data?
        }else{
            let context = delegate.persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = UIImagePNGRepresentation(JuegoImageView.image!) as Data?
        }
        
        delegate.saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
    
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    
    
}

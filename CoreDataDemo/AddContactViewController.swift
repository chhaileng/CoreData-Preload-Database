//
//  AddContactViewController.swift
//  CoreDataDemo
//
//  Created by Chhaileng Peng on 8/12/18.
//  Copyright © 2018 Chhaileng Peng. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var isUpdate: Bool = false
    var contactIndex: Int = 0
    
    var name: String?
    var phone: String?
    var image: UIImage?
    
    @IBAction func save(_ sender: UIButton) {
        
        if isUpdate {
            let contacts: [Contact] = try! self.context.fetch(Contact.fetchRequest())
            contacts[contactIndex].name = nameTextField.text
            contacts[contactIndex].phone = phoneTextField.text
            contacts[contactIndex].profile = UIImagePNGRepresentation(profileImageView.image!)
             appDelegate.saveContext()
            
        } else {
            let contact = Contact(context: context)
            contact.name = nameTextField.text
            contact.phone = phoneTextField.text
            contact.profile = UIImagePNGRepresentation(profileImageView.image!)
            
            appDelegate.saveContext()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isUpdate {
            self.title = "Update Contact"
            nameTextField.text = name!
            phoneTextField.text = phone!
            profileImageView.image = image!
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(browseImage))
        profileImageView.addGestureRecognizer(tapGesture)
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary;
        imagePicker.allowsEditing = false
        
    }
    
    @objc func browseImage() {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }

    

}







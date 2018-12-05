//
//  CreateUserViewController.swift
//  PolarityTE_Project
//
//  Created by Luis Puentes on 12/4/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var tenantTextField: UITextField!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleProfileImage))
        userImageView.addGestureRecognizer(tapGesture)
        
        userImageView.layer.cornerRadius = 50
    }
    
    @objc func handleProfileImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    func presentAlert() {
        
        let alertController = UIAlertController(title: "Success", message: "You have successfully created a user!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func clear() {
        userImageView.image = #imageLiteral(resourceName: "placeholderImg")
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        emailTextField.text = ""
        phoneNumberTextField.text = ""
        zipCodeTextField.text = ""
        tenantTextField.text = ""
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let phoneNumber = phoneNumberTextField.text,
            let email = emailTextField.text,
            let zipCode = zipCodeTextField.text,
            let tenant = tenantTextField.text,
            let imageData = selectedImage?.jpegData(compressionQuality: 0.1) else { return }
        
        _ = User(firstName: firstName, lastName: lastName, name: "\(firstName) \(lastName)", phoneNumber: phoneNumber, email: email, zipCode: zipCode, tenant: tenant, profilePhoto: imageData)
        
        clear()
        
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
            presentAlert()
        } catch {
            print("Error saving the user, error: \(error.localizedDescription)")
        }
    }
}

extension CreateUserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            userImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

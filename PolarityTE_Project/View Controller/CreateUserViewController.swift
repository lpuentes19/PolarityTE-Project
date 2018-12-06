//
//  CreateUserViewController.swift
//  PolarityTE_Project
//
//  Created by Luis Puentes on 12/4/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var tenantTextField: UITextField!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    var userController: UserController?
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let tbc = self.tabBarController as? UserTabBarController {
            userController = tbc.userController
        }
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
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty,
            let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let zipCode = zipCodeTextField.text, !zipCode.isEmpty,
            let tenant = tenantTextField.text, !tenant.isEmpty,
            let imageData = selectedImage?.jpegData(compressionQuality: 0.1)?.base64EncodedString() else { return }
        
        let user = User(firstName: firstName, lastName: lastName, name: "\(firstName) \(lastName)", phoneNumber: phoneNumber, email: email, zipCode: zipCode, tenant: tenant, profilePhoto: imageData.data(using: .utf8), guid: nil)
        userController?.post(user: user)
        
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

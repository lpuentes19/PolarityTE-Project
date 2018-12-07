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
    
    @IBOutlet weak var createButton: UIButton!
    
    var userController: UserController?
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let tbc = self.tabBarController as? UserTabBarController {
            userController = tbc.userController
        }
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupUI() {
        // Create tapGesture for the UIImage & UI Setup
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleProfileImage))
        userImageView.addGestureRecognizer(tapGesture)
        userImageView.layer.cornerRadius = 50
        
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = UIColor.black.cgColor
        
        // First Name
        firstNameTextField.backgroundColor = .clear
        firstNameTextField.textColor = .white
        firstNameTextField.tintColor = .white
        firstNameTextField.borderStyle = .none
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        // Last Name
        lastNameTextField.backgroundColor = .clear
        lastNameTextField.textColor = .white
        lastNameTextField.tintColor = .white
        lastNameTextField.borderStyle = .none
        lastNameTextField.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        // Email
        emailTextField.backgroundColor = .clear
        emailTextField.textColor = .white
        emailTextField.tintColor = .white
        emailTextField.borderStyle = .none
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        // Phone Number
        phoneNumberTextField.backgroundColor = .clear
        phoneNumberTextField.textColor = .white
        phoneNumberTextField.tintColor = .white
        phoneNumberTextField.borderStyle = .none
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        // ZipCode
        zipCodeTextField.backgroundColor = .clear
        zipCodeTextField.textColor = .white
        zipCodeTextField.tintColor = .white
        zipCodeTextField.borderStyle = .none
        zipCodeTextField.attributedPlaceholder = NSAttributedString(string: "Zip Code", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        // Tenant
        tenantTextField.backgroundColor = .clear
        tenantTextField.textColor = .white
        tenantTextField.tintColor = .white
        tenantTextField.borderStyle = .none
        tenantTextField.attributedPlaceholder = NSAttributedString(string: "Tenant", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        // Create CALayer for each textField that will be
        // The bottom border of the textField
        
        // First Name
        let firstNameTextLayer = CALayer()
        firstNameTextLayer.frame = CGRect(x: 0, y: firstNameTextField.bounds.maxY, width: firstNameTextField.bounds.size.width, height: 0.8)
        
        firstNameTextLayer.backgroundColor = UIColor.black.cgColor
        firstNameTextField.layer.addSublayer(firstNameTextLayer)
        
        // Last Name
        let lastNameTextLayer = CALayer()
        lastNameTextLayer.frame = CGRect(x: 0, y: lastNameTextField.bounds.maxY, width: lastNameTextField.bounds.size.width, height: 0.8)
        
        lastNameTextLayer.backgroundColor = UIColor.black.cgColor
        lastNameTextField.layer.addSublayer(lastNameTextLayer)
        
        // Email
        let emailTextLayer = CALayer()
        emailTextLayer.frame = CGRect(x: 0, y: emailTextField.bounds.maxY, width: emailTextField.bounds.size.width, height: 0.8)
        
        emailTextLayer.backgroundColor = UIColor.black.cgColor
        emailTextField.layer.addSublayer(emailTextLayer)
        
        // PhoneNumber
        let phoneNumberTextLayer = CALayer()
        phoneNumberTextLayer.frame = CGRect(x: 0, y: phoneNumberTextField.bounds.maxY, width: phoneNumberTextField.bounds.size.width, height: 0.8)
        
        phoneNumberTextLayer.backgroundColor = UIColor.black.cgColor
        phoneNumberTextField.layer.addSublayer(phoneNumberTextLayer)
        
        // ZipCode
        let zipCodeTextLayer = CALayer()
        zipCodeTextLayer.frame = CGRect(x: 0, y: zipCodeTextField.bounds.maxY, width: zipCodeTextField.bounds.size.width, height: 0.8)
        
        zipCodeTextLayer.backgroundColor = UIColor.black.cgColor
        zipCodeTextField.layer.addSublayer(zipCodeTextLayer)
        
        // Tenant
        let tenantTextLayer = CALayer()
        tenantTextLayer.frame = CGRect(x: 0, y: tenantTextField.bounds.maxY, width: tenantTextField.bounds.size.width, height: 0.8)
        
        tenantTextLayer.backgroundColor = UIColor.black.cgColor
        tenantTextField.layer.addSublayer(tenantTextLayer)
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

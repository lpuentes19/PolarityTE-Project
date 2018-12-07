//
//  UserDetailViewController.swift
//  PolarityTE_Project
//
//  Created by Luis Puentes on 12/4/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var tenantTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    
    var user: User? {
        didSet {
            self.updateViews()
        }
    }
    
    var userController: UserController?
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupUI() {
        // UI Setup
        editButton.layer.borderWidth = 1
        editButton.layer.borderColor = UIColor.black.cgColor
        
        // First Name
        firstNameTextField.backgroundColor = .clear
        firstNameTextField.textColor = .white
        firstNameTextField.tintColor = .white
        firstNameTextField.borderStyle = .none
        
        // Last Name
        lastNameTextField.backgroundColor = .clear
        lastNameTextField.textColor = .white
        lastNameTextField.tintColor = .white
        lastNameTextField.borderStyle = .none
        
        // Email
        emailTextField.backgroundColor = .clear
        emailTextField.textColor = .white
        emailTextField.tintColor = .white
        emailTextField.borderStyle = .none
        
        // Phone Number
        phoneNumberTextField.backgroundColor = .clear
        phoneNumberTextField.textColor = .white
        phoneNumberTextField.tintColor = .white
        phoneNumberTextField.borderStyle = .none
        
        // ZipCode
        zipCodeTextField.backgroundColor = .clear
        zipCodeTextField.textColor = .white
        zipCodeTextField.tintColor = .white
        zipCodeTextField.borderStyle = .none
        
        // Tenant
        tenantTextField.backgroundColor = .clear
        tenantTextField.textColor = .white
        tenantTextField.tintColor = .white
        tenantTextField.borderStyle = .none
        
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
    
    func updateViews() {
        guard let user = user,
            isViewLoaded else { return }
        
        title = user.name
        if let imageData = user.profilePhoto {
            userImageView.image = UIImage(data: imageData) ?? #imageLiteral(resourceName: "placeholderImg")
        }
        userImageView.layer.cornerRadius = 50
        firstNameTextField.text = user.firstName
        lastNameTextField.text = user.lastName
        phoneNumberTextField.text = user.phoneNumber
        emailTextField.text = user.email
        zipCodeTextField.text = user.zipCode
        tenantTextField.text = user.tenant
    }
    
    func handleProfileImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    func presentAlert() {
        
        let alertController = UIAlertController(title: "Success", message: "Saved successfully", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editPhotoButtonTapped(_ sender: Any) {
        handleProfileImage()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let phoneNumber = phoneNumberTextField.text,
            let email = emailTextField.text,
            let zipCode = zipCodeTextField.text,
            let tenant = tenantTextField.text else { return }
        
        if let user = user {
            user.firstName = firstName
            user.lastName = lastName
            user.name = "\(firstName) \(lastName)"
            user.phoneNumber = phoneNumber
            user.email = email
            user.zipCode = zipCode
            user.tenant = tenant
            if let imageData = selectedImage?.jpegData(compressionQuality: 0.1)?.base64EncodedString() {
                user.profilePhoto = imageData.data(using: .utf8)
            }            
            userController?.patch(user: user)
            
            do {
                let moc = CoreDataStack.shared.mainContext
                try moc.save()
                presentAlert()
            } catch {
                print("Error saving changes to user, error: \(error.localizedDescription)")
            }
        }
    }
}

extension UserDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            userImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

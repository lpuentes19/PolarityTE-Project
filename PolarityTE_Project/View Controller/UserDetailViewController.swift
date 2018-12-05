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
    
    var user: User? {
        didSet {
            self.updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    func updateViews() {
        guard let user = user,
            isViewLoaded else { return }
        
        title = user.name
        firstNameTextField.text = user.firstName
        lastNameTextField.text = user.lastName
        userImageView.layer.cornerRadius = 50
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
            userImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

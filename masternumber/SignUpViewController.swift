//
//  SignUpViewController.swift
//  deneme
//
//  Created by Öykü Hazer Ekinci on 2.07.2023.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class SignUpViewController: UIViewController , UITextFieldDelegate  {
    
    private var bottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let sideMargin: CGFloat = 20
        let bottomMargin: CGFloat = 400
        let viewWidth = view.bounds.width - 2 * sideMargin
        let viewHeight: CGFloat = 300
        
        // Adding gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.yellow.cgColor]
        view.layer.addSublayer(gradientLayer)

        bottomView = UIView(frame: CGRect(x: sideMargin, y: view.bounds.height - bottomMargin - 10, width: viewWidth, height: viewHeight))
        let darkPurpleColor = UIColor(red: 0.4, green: 0.0, blue: 0.6, alpha: 1.0)
        bottomView.backgroundColor = darkPurpleColor
        bottomView.layer.cornerRadius = 20
        view.addSubview(bottomView)

        let textFieldHeight: CGFloat = 50
        let textFieldMargin: CGFloat = 20
        
        // Adding email text field
        let emailTextField = UITextField(frame: CGRect(x: textFieldMargin, y: textFieldMargin + 20, width: viewWidth - 2 * textFieldMargin, height: textFieldHeight))
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 2.5
        emailTextField.layer.borderColor = UIColor.orange.cgColor
        emailTextField.layer.shadowColor = UIColor.black.cgColor
        emailTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
        emailTextField.layer.shadowOpacity = 0.4
        emailTextField.layer.shadowRadius = 5
        emailTextField.placeholder = "Email address"
        emailTextField.delegate = self
        
        textFieldDidBeginEditing(emailTextField)
        bottomView.addSubview(emailTextField)
        

        for i in 0..<2 {
            
            // Adding password text field
            let  passwordTextField = UITextField(frame: CGRect(x: textFieldMargin, y: emailTextField.frame.origin.y + (CGFloat(i) + 1) * (textFieldHeight + textFieldMargin), width: viewWidth - 2 * textFieldMargin, height: textFieldHeight))

            passwordTextField.backgroundColor = .white
            passwordTextField.layer.cornerRadius = 10
            passwordTextField.layer.borderWidth = 2.5
            passwordTextField.layer.borderColor = UIColor.orange.cgColor
            passwordTextField.layer.shadowColor = UIColor.black.cgColor
            passwordTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
            passwordTextField.layer.shadowOpacity = 0.4
            passwordTextField.layer.shadowRadius = 5
            passwordTextField.placeholder = "Password"
            passwordTextField.delegate = self
            textFieldDidBeginEditing( passwordTextField)
            bottomView.addSubview( passwordTextField)
            
            // Adding eye button to toggle password visibility
            let eyeButton = UIButton(type: .system)
                eyeButton.frame = CGRect(x:  passwordTextField.frame.origin.x +  passwordTextField.frame.width - 40, y:  passwordTextField.frame.origin.y + 10, width: 30, height: 30)
                eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .normal)
                eyeButton.tintColor = .orange
            eyeButton.addTarget(self, action: #selector(eyeButtonTapped(_:)), for: .touchUpInside)
                bottomView.addSubview(eyeButton)
            
        }

        // Adding signUp button
        let signUpButton = UIButton(type: .system)
        signUpButton.frame = CGRect(x: textFieldMargin, y: emailTextField.frame.origin.y + 2 * (textFieldHeight + textFieldMargin), width: viewWidth - 2 * textFieldMargin, height: textFieldHeight)

        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        let gradientLayer2 = CAGradientLayer()
        gradientLayer2.frame = signUpButton.bounds
        gradientLayer2.colors = [UIColor.orange.cgColor, UIColor.yellow.cgColor]
        signUpButton.layer.insertSublayer(gradientLayer2, at: 0)

        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.masksToBounds = true
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

        bottomView.addSubview(signUpButton)
        
        // Adding logIn button
        let logInButton = UIButton(type: .system)
        logInButton.frame = CGRect(x: viewWidth - textFieldMargin - 250, y: bottomView.bounds.height - textFieldMargin - 30, width: 250, height: 30)
               
        logInButton.setTitle("Do you already have an account?", for: .normal)
        logInButton.setTitleColor(.orange, for: .normal)
        logInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        logInButton.contentHorizontalAlignment = .right
        logInButton.layer.shadowColor = UIColor.black.cgColor
        logInButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        logInButton.layer.shadowOpacity = 0.4
        logInButton.layer.shadowRadius = 4
        
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        bottomView.addSubview(logInButton)
        
        // Adding profile image view
        let profileImageView = UIImageView(frame: CGRect(x: (view.bounds.width - 200) / 2, y: 140, width: 200, height: 200))
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.image = UIImage(named: "mw13")
        profileImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        
        profileImageView.layer.shadowColor = UIColor.black.cgColor
        profileImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        profileImageView.layer.shadowOpacity = 0.4
        profileImageView.layer.shadowRadius = 5
        profileImageView.addGestureRecognizer(tapGesture)
        view.addSubview(profileImageView)
         }

    // Presents the gallery view controller for selecting an image
    @objc private func profileImageTapped() {
        let galleryVC = GalleryViewController()
        galleryVC.delegate = self
        present(galleryVC, animated: true, completion: nil)
    }
    
    @objc func eyeButtonTapped(_ sender: UIButton) {
        // Toggles the visibility of the password in the corresponding text field
        if let textField = sender.superview?.subviews.compactMap({ $0 as? UITextField }).filter({ $0.placeholder == "Password" }).first {
            textField.isSecureTextEntry.toggle()
            let imageName = textField.isSecureTextEntry ? "eye.slash.circle" : "eye.circle.fill"
            sender.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @objc private func logInButtonTapped() {
        performSegue(withIdentifier: "logIn", sender: nil)
    }
    
    // Adds left padding to the text field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return true
    }

    // Adds left padding to the text field if it is empty
     func textFieldDidBeginEditing(_ textField: UITextField) {
         if textField.text?.isEmpty ?? true {
             let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
             textField.leftView = paddingView
             textField.leftViewMode = .always
         }
     }
    
    // Handles the tap gesture on the sign-up button
    @objc private func signUpButtonTapped() {
        // Retrieves the email and password text fields from the bottom view
        guard let emailTextField = bottomView.subviews.compactMap({ $0 as? UITextField }).first(where: { $0.placeholder == "Email address" }),
              let passwordTextField = bottomView.subviews.compactMap({ $0 as? UITextField }).first(where: { $0.placeholder == "Password" }) else {
            return
        }
        // Trims and retrieves the email and password values
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        // Checks if the email or password is empty and displays a warning alert
        if email?.isEmpty ?? true || password?.isEmpty ?? true {
            showAlert(with: "Warning", message: "Please fill in the required fields.")
            return
        }
        
        // Checks if the email is valid and displays a warning alert if not
        if isValidEmail(email) == false {
            showAlert(with: "Warning", message: "Please enter a valid email address.")
            return
        }
        
        // Checks if the password is at least 10 characters long and displays a warning alert if not
        if password?.count ?? 0 < 10 {
            showAlert(with: "Warning", message: "Password must be at least 10 characters long.")
            return
        }
        
        // Creates a user account using Firebase Auth and handles the result
        Auth.auth().createUser(withEmail: email!, password: password!) { authResult, error in
            if let error = error {
                // Displays an error alert if there's an error during account creation
                self.showAlert(with: "Error", message: error.localizedDescription)
            } else {
                // Retrieves user information and prepares data for saving to Firestore
                let user = Auth.auth().currentUser
                let uid = user?.uid
                let username = email!.prefix(5)
                let userData: [String: Any] = ["uid": uid!, "email": email!, "username": String(username)]
                // Saves user data to Firestore
                let db = Firestore.firestore()
                db.collection("users").document(uid!).setData(userData) { error in
                    if let error = error {
                // Displays an error alert if there's an error during data saving
                        self.showAlert(with: "Error", message: error.localizedDescription)
                    } else {
                        // Displays a success alert if the registration is successful
                        self.showAlert(with: "Success", message: "Registration successful!")
                        
                        // Uploads the profile image to Firebase Storage if available
                        let profileImageView = self.view.subviews.compactMap({ $0 as? UIImageView }).first
                        if let image = profileImageView?.image {
                            let imageData = image.jpegData(compressionQuality: 0.8)
                            let storageRef = Storage.storage().reference().child("profileImages").child(uid!)
                            
                            storageRef.putData(imageData!, metadata: nil) { (metadata, error) in
                                if let error = error {
                                    self.showAlert(with: "Error", message: error.localizedDescription)
                                } else {
                                
                                }
                            }
                        }
                    }
                }
            }
        }
    }


    private func showAlert(with title: String, message: String) {
        // Displays an alert with the given title and message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func isValidEmail(_ email: String?) -> Bool {
        // Checks if the given email is valid using a regular expression
        guard let email = email else {
            return false
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
   }
   
extension SignUpViewController: GalleryViewControllerDelegate {
    func didSelectImage(_ image: UIImage) {
        // Sets the selected image as the profile image if a UIImageView is found
        if let profileImageView = view.subviews.compactMap({ $0 as? UIImageView }).first {
            profileImageView.image = image
        }
    }
}

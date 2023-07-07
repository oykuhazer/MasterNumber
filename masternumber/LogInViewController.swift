//
//  LogInViewController.swift
//  deneme
//
//  Created by Öykü Hazer Ekinci on 2.07.2023.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class LogInViewController: UIViewController , UITextFieldDelegate  {
    
    var profileImage: UIImage?
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
            let passwordTextField = UITextField(frame: CGRect(x: textFieldMargin, y: emailTextField.frame.origin.y + (CGFloat(i) + 1) * (textFieldHeight + textFieldMargin), width: viewWidth - 2 * textFieldMargin, height: textFieldHeight))

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
            textFieldDidBeginEditing(passwordTextField)
            bottomView.addSubview(passwordTextField)
            
            // Adding eye button to toggle password visibility
            let eyeButton = UIButton(type: .system)
                eyeButton.frame = CGRect(x: passwordTextField.frame.origin.x + passwordTextField.frame.width - 40, y: passwordTextField.frame.origin.y + 10, width: 30, height: 30)
                eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .normal)
                eyeButton.tintColor = .orange
            
            eyeButton.addTarget(self, action: #selector(eyeButtonTapped(_:)), for: .touchUpInside)
                bottomView.addSubview(eyeButton)
            
        }
        
        // Adding logIn button
        let logInButton = UIButton(type: .system)
        logInButton.frame = CGRect(x: textFieldMargin, y: emailTextField.frame.origin.y + 2 * (textFieldHeight + textFieldMargin), width: viewWidth - 2 * textFieldMargin, height: textFieldHeight)

        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        let gradientLayer2 = CAGradientLayer()
        gradientLayer2.frame = logInButton.bounds
        gradientLayer2.colors = [UIColor.orange.cgColor, UIColor.yellow.cgColor]
        
        logInButton.layer.insertSublayer(gradientLayer2, at: 0)
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        logInButton.layer.cornerRadius = 10
        logInButton.layer.masksToBounds = true
    
        bottomView.addSubview(logInButton)
        
        // Adding sign up button
        let signUpButton = UIButton(type: .system)
        signUpButton.frame = CGRect(x: viewWidth - textFieldMargin - 200, y: bottomView.bounds.height - textFieldMargin - 30, width: 200, height: 30)
               
        signUpButton.setTitle("Don't have an account?", for: .normal)
        signUpButton.setTitleColor(.orange, for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        signUpButton.contentHorizontalAlignment = .right
        signUpButton.layer.shadowColor = UIColor.black.cgColor
        signUpButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        signUpButton.layer.shadowOpacity = 0.4
        signUpButton.layer.shadowRadius = 4
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        bottomView.addSubview(signUpButton)
        
        let imageSizeMultiplier: CGFloat = 1.0
        let imageWidth = viewWidth - 2 * textFieldMargin
        let imageHeight = viewHeight - 2 * textFieldMargin - 2 * (textFieldHeight + textFieldMargin)
        
        // Adding logo image view
        let logoImageView = UIImageView(frame: CGRect(x: (viewWidth - imageWidth * imageSizeMultiplier) / 2, y: textFieldMargin - 330, width: imageWidth * imageSizeMultiplier, height: imageHeight * imageSizeMultiplier))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "number")

        logoImageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 8)
        logoImageView.layer.shadowColor = UIColor.black.cgColor
        logoImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        logoImageView.layer.shadowOpacity = 0.4
        logoImageView.layer.shadowRadius = 5
        bottomView.addSubview(logoImageView)
        
        // Adding label for "MASTER NUMBER"
        let labelMN = UILabel(frame: CGRect(x: sideMargin, y: logoImageView.frame.origin.y + logoImageView.frame.height - 15, width: viewWidth - 2 * sideMargin, height: 50))
        labelMN.text = "MASTER NUMBER"
        labelMN.textColor = darkPurpleColor
        labelMN.textAlignment = .center
        labelMN.font = UIFont(name: "GillSans-Bold", size: 35)
        labelMN.adjustsFontSizeToFitWidth = true
        bottomView.addSubview(labelMN)
        
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
        // Retrieve email and password from text fields
         guard let emailTextField = bottomView.subviews.compactMap({ $0 as? UITextField }).first(where: { $0.placeholder == "Email address" }),
               let passwordTextField = bottomView.subviews.compactMap({ $0 as? UITextField }).first(where: { $0.placeholder == "Password" }) else {
             return
         }

         let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
         let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        // Check if email and password are empty
         if email?.isEmpty ?? true || password?.isEmpty ?? true {
             showAlert(with: "Warning", message: "Please fill in the required fields.")
             return
         }
        // Check if the email is valid
         if isValidEmail(email) == false {
             showAlert(with: "Warning", message: "Please enter a valid email address.")
             return
         }
        // Check if the password meets the requirements
         if password?.count ?? 0 < 10 {
             showAlert(with: "Warning", message: "Password must be at least 10 characters long.")
             return
         }
        // Authenticate user with Firebase Auth
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] (authResult, error) in
            if let error = error {
                self?.showAlert(with: "Error", message: error.localizedDescription)
                return
            }
            
            guard let user = authResult?.user else {
                self?.showAlert(with: "Error", message: "User information not available.")
                return
            }
            // Extracting a username from the user's email address
            let username = user.email?.prefix(5) ?? ""
            // Retrieving the user's profile image from Firebase Storage
               let profileImageRef = Storage.storage().reference().child("profileImages/\(authResult?.user.uid ?? "")")
               profileImageRef.getData(maxSize: 1 * 1024 * 1024) { [weak self] (data, error) in
                   if let error = error {
                       print("Error getting profile image: \(error.localizedDescription)")
                       // Use a default profile image in case of an error
                       self?.profileImage = UIImage(named: "default_profile_image")
                   } else {
                       if let data = data {
                           self?.profileImage = UIImage(data: data)
                       }
                   }
                   // Creating a new view controller and setting its properties
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                   viewController.username = String(username)
                   viewController.profileImage = self?.profileImage
                   // Pushing the new view controller onto the navigation stack
                   self?.navigationController?.pushViewController(viewController, animated: true)
               }
            }
        }
    // Displays an alert dialog with the given title and message
    private func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    // Checks if the provided email string is valid according to a regular expression pattern
    private func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else {
            return false
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    @objc private func signUpButtonTapped() {
        performSegue(withIdentifier: "signUp", sender: nil)
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
}

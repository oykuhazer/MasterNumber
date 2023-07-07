//
//  ViewController.swift
//  deneme
//
//  Created by Öykü Hazer Ekinci on 24.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var username: String?
    var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creates a gradient layer and sets it as the background of the view
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        // Removes any existing gradient layers from the view's sublayers
        if let sublayers = view.layer.sublayers {
            for layer in sublayers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        // Inserts the gradient layer at index 0 to be the bottom-most layer
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Creates three buttons with custom colors
        let hwtpbutton = createButton(withColor: UIColor(red: 0.3, green: 0.2, blue: 0.4, alpha: 1.0))
        let playbutton = createButton(withColor: UIColor(red: 0.3, green: 0.2, blue: 0.4, alpha: 1.0))
        let exitbutton = createButton(withColor: UIColor(red: 0.3, green: 0.2, blue: 0.4, alpha: 1.0))
        
        // Sets the size and position of the buttons
        let buttonSize: CGFloat = 120
        let buttonSpacing: CGFloat = 10
        
        let centerX = view.bounds.width / 2
        let centerY = view.bounds.height / 2
          
        hwtpbutton.frame = CGRect(x: centerX - buttonSize - buttonSpacing - 10, y: centerY - buttonSize - buttonSpacing * 2 + 160, width: buttonSize, height: buttonSize)
        playbutton.frame = CGRect(x: centerX + buttonSpacing, y: centerY - buttonSize - buttonSpacing * 2 + 160, width: buttonSize, height: buttonSize)
        exitbutton.frame = CGRect(x: centerX - (buttonSize / 2), y: centerY + buttonSpacing + 160, width: buttonSize, height: buttonSize)
        
        // Applies corner radius to the buttons for a rounded appearance
        let cornerRadius: CGFloat = 10
        hwtpbutton.layer.cornerRadius = cornerRadius
        hwtpbutton.clipsToBounds = true
        playbutton.layer.cornerRadius = cornerRadius
        playbutton.clipsToBounds = true
        exitbutton.layer.cornerRadius = cornerRadius
        exitbutton.clipsToBounds = true
        
        // Sets target actions for button taps
        hwtpbutton.addTarget(self, action: #selector(hwtpbuttonTapped), for: .touchUpInside)
        playbutton.addTarget(self, action: #selector(playbuttonTapped), for: .touchUpInside)
        exitbutton.addTarget(self, action: #selector(exitbuttonTapped), for: .touchUpInside)
        
        view.addSubview(hwtpbutton)
        view.addSubview(playbutton)
        view.addSubview(exitbutton)
        
        // Creates a label to display a greeting message with the username
        let labelHi = UILabel()
        labelHi.text = "Hi! \(username ?? "")"
        labelHi.font = UIFont.boldSystemFont(ofSize: 20)
        labelHi.textAlignment = .center
        labelHi.textColor = .white
        labelHi.backgroundColor = UIColor(red: 0.2, green: 0.1, blue: 0.3, alpha: 0.8)
        labelHi.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelHi)
        
        // Creates an image view for displaying the profile image
        let profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 45
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        
        // Sets the profile image if available
        if let profileImage = profileImage {
            profileImageView.image = profileImage
                }
       
        // Creates a circular view as a background for the profile image
        let circleSize: CGFloat = 90
        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: circleSize, height: circleSize))
        circleView.layer.cornerRadius = circleSize / 2
        circleView.clipsToBounds = true
        profileImageView.addSubview(circleView)
      
        
        // Sets up constraints for the label, profile image, and circular view
              NSLayoutConstraint.activate([
                labelHi.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                labelHi.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                labelHi.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -180),
                labelHi.heightAnchor.constraint(equalToConstant: 50),
                  
                  circleView.centerYAnchor.constraint(equalTo: labelHi.centerYAnchor),
                      circleView.leadingAnchor.constraint(equalTo: labelHi.trailingAnchor, constant: 50),
                      circleView.widthAnchor.constraint(equalToConstant: circleSize),
    
                profileImageView.widthAnchor.constraint(equalToConstant: circleSize),
                profileImageView.heightAnchor.constraint(equalToConstant: circleSize),
                profileImageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
                profileImageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor)
                  ])
        
        labelHi.layer.cornerRadius = 20
        labelHi.layer.masksToBounds = true
        
        // Creates a container view for the game menu
        let gameMenuContainerView = UIView()
        gameMenuContainerView.backgroundColor = .white
        gameMenuContainerView.layer.cornerRadius = 20
        gameMenuContainerView.clipsToBounds = true
        gameMenuContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameMenuContainerView)

        // Creates a label for the game menu title
        let gameMenuLabel = UILabel()
        gameMenuLabel.text = "Game Menu"
        gameMenuLabel.font = UIFont.boldSystemFont(ofSize: 23)
        gameMenuLabel.textAlignment = .center
        gameMenuLabel.textColor = UIColor(red: 0.3, green: 0.2, blue: 0.4, alpha: 1.0)
        gameMenuLabel.translatesAutoresizingMaskIntoConstraints = false
        gameMenuContainerView.addSubview(gameMenuLabel)

        // Sets up constraints for the game menu container view and label
        NSLayoutConstraint.activate([
            gameMenuContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameMenuContainerView.bottomAnchor.constraint(equalTo: hwtpbutton.topAnchor, constant: -50),
            gameMenuContainerView.widthAnchor.constraint(equalToConstant: 200),
            gameMenuContainerView.heightAnchor.constraint(equalToConstant: 50),
            gameMenuLabel.centerXAnchor.constraint(equalTo: gameMenuContainerView.centerXAnchor),
            gameMenuLabel.centerYAnchor.constraint(equalTo: gameMenuContainerView.centerYAnchor)
        ])
        
        // Creates a label for the "How to Play" button
        let hwtplabel = UILabel()
        hwtplabel.text = "How to Play"
        hwtplabel.font = UIFont.boldSystemFont(ofSize: 16)
        hwtplabel.textAlignment = .center
        hwtplabel.textColor = .white
        hwtplabel.translatesAutoresizingMaskIntoConstraints = false
        hwtpbutton.addSubview(hwtplabel)

        // Sets up constraints for the "How to Play" label
        hwtplabel.centerXAnchor.constraint(equalTo: hwtpbutton.centerXAnchor).isActive = true
        hwtplabel.centerYAnchor.constraint(equalTo: hwtpbutton.centerYAnchor, constant: 30).isActive = true

        // Creates an image view for the description icon
        let descriptionImageView = UIImageView()
        descriptionImageView.image = UIImage(named: "description")
        descriptionImageView.contentMode = .scaleAspectFit
        descriptionImageView.translatesAutoresizingMaskIntoConstraints = false
             view.addSubview(descriptionImageView)

        // Sets up constraints for the description icon
        NSLayoutConstraint.activate([
            descriptionImageView.centerXAnchor.constraint(equalTo: hwtplabel.centerXAnchor),
            descriptionImageView.bottomAnchor.constraint(equalTo: hwtplabel.topAnchor, constant: -15),
            descriptionImageView.widthAnchor.constraint(equalToConstant: 40),
            descriptionImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Creates a label for the "Play Game" button
        let playlabel = UILabel()
        playlabel.text = "Play Game"
        playlabel.font = UIFont.boldSystemFont(ofSize: 16)
        playlabel.textAlignment = .center
        playlabel.textColor = .white
        playlabel.translatesAutoresizingMaskIntoConstraints = false
        playbutton.addSubview(playlabel)

        // Sets up constraints for the "Play Game" label
        playlabel.centerXAnchor.constraint(equalTo: playbutton.centerXAnchor).isActive = true
        playlabel.centerYAnchor.constraint(equalTo: playbutton.centerYAnchor, constant: 30).isActive = true

        // Creates an image view for the play icon
        let playImageView = UIImageView()
        playImageView.image = UIImage(named: "play")
        playImageView.contentMode = .scaleAspectFit
        playImageView.translatesAutoresizingMaskIntoConstraints = false
             view.addSubview(playImageView)

        // Sets up constraints for the play icon
        NSLayoutConstraint.activate([
            playImageView.centerXAnchor.constraint(equalTo: playlabel.centerXAnchor),
            playImageView.bottomAnchor.constraint(equalTo: playlabel.topAnchor, constant: -15),
            playImageView.widthAnchor.constraint(equalToConstant: 40),
            playImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Creates a label for the "Exit Game" button
        let exitlabel = UILabel()
        exitlabel.text = "Exit Game"
        exitlabel.font = UIFont.boldSystemFont(ofSize: 16)
        exitlabel.textAlignment = .center
        exitlabel.textColor = .white
        exitlabel.translatesAutoresizingMaskIntoConstraints = false
        exitbutton.addSubview(exitlabel)

        exitlabel.centerXAnchor.constraint(equalTo: exitbutton.centerXAnchor).isActive = true
        exitlabel.centerYAnchor.constraint(equalTo: exitbutton.centerYAnchor, constant: 30).isActive = true
        
        // Sets up constraints for the "Exit Game" label
        let exitImageView = UIImageView()
        exitImageView.image = UIImage(named: "exit")
        exitImageView.contentMode = .scaleAspectFit
        exitImageView.translatesAutoresizingMaskIntoConstraints = false
             view.addSubview(exitImageView)

        NSLayoutConstraint.activate([
            exitImageView.centerXAnchor.constraint(equalTo: exitlabel.centerXAnchor),
            exitImageView.bottomAnchor.constraint(equalTo: exitlabel.topAnchor, constant: -15),
            exitImageView.widthAnchor.constraint(equalToConstant: 40),
            exitImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
      
    // Helper method to create a button with a specified background color
      func createButton(withColor color: UIColor) -> UIButton {
          let buttonSize: CGFloat = 100
          let button = UIButton(type: .system)
          button.backgroundColor = color
          button.setTitleColor(.white, for: .normal)
          button.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
          return button
      }
    
    // Button tap actions
    @objc func hwtpbuttonTapped() {
        performSegue(withIdentifier: "hwtpSegue", sender: nil)
      }
      
      @objc func playbuttonTapped() {
          performSegue(withIdentifier: "pgSegue", sender: nil)
      }
    @objc func exitbuttonTapped() {
        exit(0)
    }
  }



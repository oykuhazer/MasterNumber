//
//  PGVC.swift
//  deneme
//
//  Created by Öykü Hazer Ekinci on 24.06.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

class PGVC: UIViewController {
    
     @IBOutlet weak var H1Label: UILabel!
     @IBOutlet weak var H2Label: UILabel!
    
    private var requirementLabel: UILabel!
    private var digitTextField: UITextField!
    private var enterButton: UIButton!
    var secretNumber: String = ""
    
    private var guessTextField: UITextField!
    private var guessButton: UIButton!
    private var requirementLabel2: UILabel!
    private var requirementLabel3: UILabel!
    private var resultLabel: UILabel!
    var guessCount: Int = 0
    var remainingAttempts: Int = 10
    
     override func viewDidLoad() {
     super.viewDidLoad()
      
         // Set the positions and sizes of H1Label and H2Label
         let labelWidth = view.bounds.width - 300
         H1Label.frame = CGRect(x: 70, y: 500, width: labelWidth, height: 100)
         H2Label.frame = CGRect(x: view.bounds.width - labelWidth - 90, y: 500, width: labelWidth, height: 100)
         H1Label.textColor = UIColor.purple
         H2Label.textColor = UIColor.purple
         
         // Create a gradient layer and set it as the background
         let topColor = UIColor.purple.cgColor
         let middleColor = UIColor.systemPurple.cgColor
         let bottomColor = UIColor.systemPurple.withAlphaComponent(0.5).cgColor
         
         let gradientLayer = CAGradientLayer()
         gradientLayer.frame = view.bounds
         gradientLayer.colors = [topColor, middleColor, bottomColor]
         gradientLayer.locations = [0.0, 0.5, 1.0]
         view.layer.insertSublayer(gradientLayer, at: 0)
         
         // Set up requirementLabel properties
         requirementLabel = UILabel(frame: CGRect(x: 0, y: 300, width: view.bounds.width, height: 100))
         requirementLabel.textAlignment = .center
         requirementLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
         requirementLabel.font = UIFont.boldSystemFont(ofSize: 17)
         requirementLabel.text = "Please enter a number of digits "
         requirementLabel.layer.shadowColor = UIColor.black.cgColor
         requirementLabel.layer.shadowOffset = CGSize(width: 0, height: 5)
         requirementLabel.layer.shadowRadius = 7
         requirementLabel.layer.shadowOpacity = 2
         requirementLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
         
         // Set up digitTextField properties.
         digitTextField = UITextField(frame: CGRect(x: (view.bounds.width - 300) / 2, y: 400, width: 200, height: 55))
         digitTextField.textAlignment = .center
         digitTextField.textColor = .systemPurple
         digitTextField.font = UIFont.boldSystemFont(ofSize: 20)
               
               let textFieldGradientLayer = CAGradientLayer()
               textFieldGradientLayer.frame = digitTextField.bounds
               textFieldGradientLayer.colors = [UIColor.orange.cgColor, UIColor.yellow.cgColor]
               textFieldGradientLayer.cornerRadius = digitTextField.bounds.height / 2
         digitTextField.layer.insertSublayer(textFieldGradientLayer, at: 0)
               
         digitTextField.layer.cornerRadius = digitTextField.bounds.height / 2
         digitTextField.layer.borderWidth = 2
         digitTextField.layer.borderColor = UIColor.orange.withAlphaComponent(0.8).cgColor
               
         // Set up enterButton properties
         enterButton = UIButton(type: .system)
         enterButton.frame = CGRect(x: digitTextField.frame.maxX + 10, y: digitTextField.frame.origin.y, width: 90, height: digitTextField.bounds.height)
         enterButton.backgroundColor = .orange
         enterButton.setTitle("Enter", for: .normal)
         enterButton.setTitleColor(.white, for: .normal)
         enterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
         enterButton.layer.cornerRadius = enterButton.bounds.height / 2
         
         enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
           
         // Set up requirementLabel2 properties
         requirementLabel2 = UILabel(frame: CGRect(x: (view.bounds.width - 350) / 2, y: digitTextField.frame.maxY + 20, width: 350, height: 30))
         requirementLabel2.textAlignment = .center
         requirementLabel2.textAlignment = .center
         requirementLabel2.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
         requirementLabel2.font = UIFont.boldSystemFont(ofSize: 17)
         requirementLabel2.text = ""
         requirementLabel2.layer.shadowColor = UIColor.black.cgColor
         requirementLabel2.layer.shadowOffset = CGSize(width: 0, height: 2)
         requirementLabel2.layer.shadowRadius = 5
         requirementLabel2.layer.shadowOpacity = 0.5
         
         // Hide unnecessary UI elements initially
         digitTextField.isHidden = true
         enterButton.isHidden = true
         requirementLabel2.isHidden = true
         H1Label.isHidden = true
         H2Label.isHidden = true
         
         // Animate the appearance of UI elements
      UIView.animate(withDuration: 2, delay: 0.5, options: .curveEaseInOut, animations: {
             self.requirementLabel.transform = .identity
         }, completion: { _ in
             UIView.animate(withDuration: 1, animations: {
                 self.digitTextField.isHidden = false
                 self.enterButton.isHidden = false
                 self.requirementLabel2.isHidden = false
             })
         })
         
         // Add UI elements to the view
         view.addSubview(requirementLabel)
         view.addSubview(digitTextField)
         view.addSubview(enterButton)
         view.addSubview(requirementLabel2)
         
         // Set up H1Label and H2Label properties
         let labelSize = CGSize(width: 100, height: 100)
         H1Label.frame.size = labelSize
         H2Label.frame.size = labelSize
         H1Label.layer.cornerRadius = 10
         H1Label.clipsToBounds = true
         H2Label.layer.cornerRadius = 10
         H2Label.clipsToBounds = true
         H1Label.backgroundColor = UIColor.systemOrange
         H2Label.backgroundColor = UIColor.systemOrange
         
         // Add hint labels to H1Label and H2Label
         let H1Hint = UILabel(frame: CGRect(x: 0, y: H1Label.bounds.height/2, width: H1Label.bounds.width, height: H1Label.bounds.height/2))
         H1Hint.text = "First Hint"
         H1Hint.textColor = UIColor.purple
         H1Hint.font = UIFont.boldSystemFont(ofSize: 14)
         H1Hint.textAlignment = .center
         H1Label.addSubview( H1Hint)
         
         let H2Hint = UILabel(frame: CGRect(x: 0, y: H2Label.bounds.height/2, width: H2Label.bounds.width, height: H2Label.bounds.height/2))
         H2Hint.text = "Second Hint"
         H2Hint.textColor = UIColor.purple
         H2Hint.font = UIFont.boldSystemFont(ofSize: 14)
         H2Hint.textAlignment = .center
         H2Label.addSubview(H2Hint)

     }
    
    // Generates a secret number with the specified number of digits
    func generateSecretNumber(numberOfDigits: Int) -> String {
        var secretNumber = ""
        var availableDigits = Array(0...9)
        let randomIndex = Int.random(in: 1..<availableDigits.count)
        secretNumber += String(availableDigits[randomIndex])
        availableDigits.remove(at: randomIndex)
        for _ in 1..<numberOfDigits {
            let randomIndex = Int.random(in: 0..<availableDigits.count)
            secretNumber += String(availableDigits[randomIndex])
            availableDigits.remove(at: randomIndex)
        }
        return secretNumber
    }
    
    // Checks if a given number is valid, i.e., all digits are different
      func isValidNumber(_ number: String) -> Bool {
          let digitSet = Set(number)
          return digitSet.count == number.count
      }
    
    // Calculates the number of same digits and different digits between the guess and the secret number
        func calculateHints(_ guess: String) -> (Int, Int) {
            var sameDigits = 0
            var differentDigits = 0
            var guessDigits = Array(guess)
            var secretDigits = Array(secretNumber)
            
            // Count the number of same digits in the same position
            for i in 0..<guessDigits.count {
                if guessDigits[i] == secretDigits[i] {
                    sameDigits += 1
                    guessDigits[i] = "x" // Mark the guessed digit as 'x' to avoid counting it again
                    secretDigits[i] = "y" // Mark the secret digit as 'y' to avoid counting it again
                }
            }
            
            // Count the number of different digits
            for guessDigit in guessDigits {
                if guessDigit != "x" {
                    if secretDigits.contains(guessDigit) {
                        differentDigits += 1
                        if let index = secretDigits.firstIndex(of: guessDigit) {
                            secretDigits[index] = "y" // Mark the secret digit as 'y' to avoid counting it again
                        }
                    }
                }
            }
            
            return (sameDigits, differentDigits)
        }
    
    // Action method triggered when the "Enter" button is tapped
        @objc func enterButtonTapped() {
            // Check if the entered number of digits is valid
            guard let numberOfDigits = Int(digitTextField.text!), (1...9).contains(numberOfDigits) else {
                requirementLabel2.text = "Please enter a digit value between 1 and 9."
                return
            }
            
            // Generate the secret number with the specified number of digits
            secretNumber = generateSecretNumber(numberOfDigits: numberOfDigits)
            print("Secret number: \(secretNumber)")
            
            // Animate the disappearance of UI elements and start the countdown
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.digitTextField.alpha = 0
                self.enterButton.alpha = 0
                self.requirementLabel2.alpha = 0
                self.requirementLabel.alpha = 0
            }) { _ in
                self.startCountdown(from: 3, to: 1)
            }
        }
 
    // Starts the countdown from the startValue to the endValue
    func startCountdown(from startValue: Int, to endValue: Int) {
        var value = startValue
        
        // Create and configure the countdownLabel
        let countdownLabel = UILabel(frame: CGRect(x: (view.bounds.width - 100) / 2, y: (view.bounds.height - 100) / 2, width: 100, height: 100))
        countdownLabel.textAlignment = .center
        countdownLabel.textColor = .orange
        countdownLabel.font = UIFont.boldSystemFont(ofSize: 70)
        countdownLabel.text = "\(value)"
        countdownLabel.alpha = 0
        countdownLabel.layer.cornerRadius = countdownLabel.frame.width / 2
        countdownLabel.layer.borderWidth = 2
        countdownLabel.layer.borderColor = UIColor.purple.cgColor
        countdownLabel.backgroundColor = .purple
        countdownLabel.clipsToBounds = true
        countdownLabel.layer.shadowColor = UIColor.black.cgColor
        countdownLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        countdownLabel.layer.shadowRadius = 5
        countdownLabel.layer.shadowOpacity = 0.5

        view.addSubview(countdownLabel)
        
        // Animate the appearance of the countdownLabel
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            countdownLabel.alpha = 1
        }) { _ in
            
            // Start the countdown timer
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                value -= 1
                countdownLabel.text = "\(value)"
                
                // Check if the countdown reached the endValue
                if value == endValue {
                    timer.invalidate()
                    
                    // Animate the disappearance of the countdownLabel
                    UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                        countdownLabel.alpha = 0
                    }, completion: { _ in
                        countdownLabel.removeFromSuperview()
                       
                        // Hide certain UI elements
                        self.digitTextField.isHidden = true
                        self.enterButton.isHidden = true
                        self.requirementLabel2.isHidden = true
                        self.requirementLabel.isHidden = true
                        
                        // Display the game start label
                        let gameStartLabel = UILabel(frame: CGRect(x: (self.view.bounds.width - 300) / 2, y: (self.view.bounds.height - 100) / 2, width: 300, height: 100))
                        gameStartLabel.textAlignment = .center
                        gameStartLabel.textColor = .orange
                        gameStartLabel.font = UIFont.boldSystemFont(ofSize: 32)
                        gameStartLabel.text = "GAME IS STARTING!"
                        gameStartLabel.layer.shadowColor = UIColor.black.cgColor
                        gameStartLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
                        gameStartLabel.layer.shadowRadius = 5
                        gameStartLabel.layer.shadowOpacity = 0.5
                        self.view.addSubview(gameStartLabel)
                        
                        // Animate the disappearance of the game start label
                        UIView.animate(withDuration: 1, delay: 2, options: .curveEaseInOut, animations: {
                            gameStartLabel.alpha = 0
                        }, completion: { _ in
                            gameStartLabel.removeFromSuperview()
                            
                    // Show the guess text field, requirement label, and guess button
                            self.guessTextField = UITextField(frame: CGRect(x: (self.view.bounds.width - 300) / 2, y: 300, width: 200, height: 55))
                            self.guessTextField.textAlignment = .center
                            self.guessTextField.textColor = .systemPurple
                            self.guessTextField.font = UIFont.boldSystemFont(ofSize: 20)
                              
                            // Apply gradient to the guess text field
                              let guessTextFieldGradientLayer = CAGradientLayer()
                            guessTextFieldGradientLayer.frame = self.guessTextField.bounds
                            guessTextFieldGradientLayer.colors = [UIColor.orange.cgColor, UIColor.yellow.cgColor]
                            guessTextFieldGradientLayer.cornerRadius = self.guessTextField.bounds.height / 2
                            self.guessTextField.layer.insertSublayer(guessTextFieldGradientLayer, at: 0)
                            self.guessTextField.layer.cornerRadius = self.guessTextField.bounds.height / 2
                            self.guessTextField.layer.borderWidth = 2
                            self.guessTextField.layer.borderColor = UIColor.orange.withAlphaComponent(0.8).cgColor
                           
                            // Configure the requirement label for guess input
                            self.requirementLabel3 = UILabel(frame: CGRect(x: (self.view.bounds.width - 350) / 2, y: 250, width: 350, height: 30))
                            self.requirementLabel3.textAlignment = .center
                            self.requirementLabel3.textAlignment = .center
                            self.requirementLabel3.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
                            self.requirementLabel3.font = UIFont.boldSystemFont(ofSize: 17)
                            self.requirementLabel3.text = "Please enter your guess."
                            self.requirementLabel3.layer.shadowColor = UIColor.black.cgColor
                            self.requirementLabel3.layer.shadowOffset = CGSize(width: 0, height: 2)
                            self.requirementLabel3.layer.shadowRadius = 5
                            self.requirementLabel3.layer.shadowOpacity = 0.5
                            
                            // Create and configure the guess button
                            self.guessButton = UIButton(type: .system)
                            self.guessButton.frame = CGRect(x: self.guessTextField.frame.maxX + 10, y: self.guessTextField.frame.origin.y, width: 90, height: self.guessTextField.bounds.height)
                            self.guessButton.backgroundColor = .orange
                            self.guessButton.setTitle("Guess", for: .normal)
                            self.guessButton.setTitleColor(.white, for: .normal)
                            self.guessButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                            self.guessButton.layer.cornerRadius = self.guessButton.bounds.height / 2
                            self.guessButton.addTarget(self, action: #selector(self.guessButtonTapped), for: .touchUpInside)
                            
                            self.H1Label.isHidden = false
                            self.H2Label.isHidden = false
            
                            // Add the guess text field, requirement label, guess button, and labels to the view
                            self.view.addSubview(self.guessTextField)
                            self.view.addSubview(self.requirementLabel3)
                            self.view.addSubview(self.guessButton)
                            self.view.addSubview(self.H1Label)
                            self.view.addSubview(self.H2Label)
                        })
                    })
                }
            }
            // Start the countdown timer immediately
            timer.fire()
        }
    }

    @objc func guessButtonTapped() {
        // Validate the user's guess
        guard let guess = Int(guessTextField.text!) else {
            requirementLabel3.text = "Please enter a valid guess."
            return
        }
        // Validate the number of digits entered by the user
        guard let numberOfDigits = Int(digitTextField.text!), numberOfDigits > 0 else {
            requirementLabel3.text = "Please enter a valid number of digits."
            return
        }
        // Check if the guess has the correct number of digits
        if String(guess).count != numberOfDigits {
            requirementLabel3.text = "Please enter a guess with \(numberOfDigits) digits."
            return
        }
        // Check if the numbers in the guess are different
        if !isValidNumber(String(guess)) {
            requirementLabel3.text = "The numbers should be different"
            return
        }
        // Calculate the number of same and different digits
        let (sameDigits, differentDigits) = calculateHints(String(guess))
        H1Label.text = "\(sameDigits)"
        H2Label.text = "\(differentDigits)"

        // Display the result label
        resultLabel = UILabel(frame: CGRect(x: (view.bounds.width - 350) / 2, y: requirementLabel3.frame.maxY + 100, width: 350, height: 30))
        resultLabel.textAlignment = .center
        resultLabel.textColor = .orange
        resultLabel.font = UIFont.boldSystemFont(ofSize: 20)
        resultLabel.layer.shadowColor = UIColor.black.cgColor
        resultLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        resultLabel.layer.shadowRadius = 5
        resultLabel.layer.shadowOpacity = 0.5
        view.addSubview(resultLabel)

        // Set up button sizes and spacing
        let buttonSize: CGFloat = 90
        let cornerRadius: CGFloat = 10
        let spacing: CGFloat = 30
        
        // Check if the guess is correct
        if guess == Int(secretNumber) {
            // Hide unnecessary UI elements and show winning image
            guessTextField.isHidden = true
            guessButton.isHidden = true
            H1Label.isHidden = true
            H2Label.isHidden = true
            requirementLabel3.isHidden = true
            showWinningImage()
            
            // Create and configure the "House" button
            let buttonHouse = UIButton(frame: CGRect(x: (view.bounds.width - buttonSize*2 - spacing) / 2, y: resultLabel.frame.maxY + 130, width: buttonSize, height: buttonSize))
            buttonHouse.backgroundColor = .purple
            buttonHouse.tintColor = .white
            
            if let houseImage = UIImage(systemName: "house.circle") {
                let scaledImage =  houseImage.withTintColor(.white).withRenderingMode(.alwaysOriginal)
                let resizedImage = resizeImage(scaledImage, targetSize: CGSize(width: buttonSize * 0.7, height: buttonSize * 0.7))
                
                buttonHouse.setImage(resizedImage, for: .normal)
            }
            
            buttonHouse.layer.cornerRadius = cornerRadius
            buttonHouse.addTarget(self, action: #selector(buttonHouseTapped), for: .touchUpInside)
            view.addSubview(buttonHouse)

            // Create and configure the "Exit" button
            let buttonExit = UIButton(frame: CGRect(x: buttonHouse.frame.maxX + spacing, y: resultLabel.frame.maxY + 130, width: buttonSize, height: buttonSize))
            buttonExit.backgroundColor = .purple
            buttonExit.tintColor = .white
            
            // Configure the "Exit" button and handle remaining attempts
            if let image = UIImage(systemName: "multiply.circle") {
                // Resize and set the image for the "Exit" button
                let scaledImage = image.withTintColor(.white).withRenderingMode(.alwaysOriginal)
                let resizedImage = resizeImage(scaledImage, targetSize: CGSize(width: buttonSize * 0.7, height: buttonSize * 0.7))
                
                buttonExit.setImage(resizedImage, for: .normal)
            }
            
            buttonExit.layer.cornerRadius = cornerRadius
            buttonExit.addTarget(self, action: #selector(buttonExitTapped), for: .touchUpInside)
            view.addSubview(buttonExit)
            
            // Handle remaining attempts
           } else {
               remainingAttempts -= 1
               if remainingAttempts > 0 {
                   // Show the remaining attempts and update the label color
                   resultLabel.text = "Try again! Remaining attemps: \(remainingAttempts)"
                   resultLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
               } else {
                   // Show the losing image and hide unnecessary UI elements
                   showLosingImage()
                   guessTextField.isHidden = true
                   guessButton.isHidden = true
                   H1Label.isHidden = true
                   H2Label.isHidden = true
                   requirementLabel3.isHidden = true
                   
                   // Create and configure the "House" button
                   let buttonHouse = UIButton(frame: CGRect(x: (view.bounds.width - buttonSize*2 - spacing) / 2, y: resultLabel.frame.maxY + 130, width: buttonSize, height: buttonSize))
                   buttonHouse.backgroundColor = .purple
                   buttonHouse.tintColor = .white
                   
                   if let image = UIImage(systemName: "house.circle") {
                       let scaledImage = image.withTintColor(.white).withRenderingMode(.alwaysOriginal)
                       let resizedImage = resizeImage(scaledImage, targetSize: CGSize(width: buttonSize * 0.7, height: buttonSize * 0.7))
                       
                       buttonHouse.setImage(resizedImage, for: .normal)
                   }
                   
                   buttonHouse.layer.cornerRadius = cornerRadius
                   buttonHouse.addTarget(self, action: #selector(buttonHouseTapped), for: .touchUpInside)
                   view.addSubview(buttonHouse)

                   // Create and configure the "Exit" button
                   let buttonExit = UIButton(frame: CGRect(x: buttonHouse.frame.maxX + spacing, y: resultLabel.frame.maxY + 130, width: buttonSize, height: buttonSize))
                   buttonExit.backgroundColor = .purple
                   buttonExit.tintColor = .white
                   
                   if let exitImage = UIImage(systemName: "multiply.circle") {
                       let scaledImage = exitImage.withTintColor(.white).withRenderingMode(.alwaysOriginal)
                       let resizedImage = resizeImage(scaledImage, targetSize: CGSize(width: buttonSize * 0.7, height: buttonSize * 0.7))
                       
                       buttonExit.setImage(resizedImage, for: .normal)
                   }
                   
                   buttonExit.layer.cornerRadius = cornerRadius
                   buttonExit.addTarget(self, action: #selector(buttonExitTapped), for: .touchUpInside)
                   view.addSubview(buttonExit)
               }
           }
        
        // Remove the result label after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
             self.resultLabel.removeFromSuperview()
         }
     }
    
    // Show the winning image and label
    func showWinningImage() {
        // Configure the winning image view
        let winImageView = UIImageView(frame: CGRect(x: (view.bounds.width - 200) / 2, y: (view.bounds.height - 600) / 2, width: 200, height: 200))
        winImageView.image = UIImage(named: "win")
        winImageView.layer.shadowColor = UIColor.black.cgColor
        winImageView.layer.shadowOpacity = 0.8
        winImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        winImageView.layer.shadowRadius = 4
        view.addSubview(winImageView)
        
        // Configure the congratulations label
        let congratsLabel = UILabel(frame: CGRect(x: 0, y: winImageView.frame.maxY + 60, width: view.bounds.width, height: 30))
        congratsLabel.textAlignment = .center
        congratsLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        congratsLabel.font = UIFont.boldSystemFont(ofSize: 22)
        congratsLabel.text = "CONGRATULATIONS! YOU WON!"
        congratsLabel.layer.shadowColor = UIColor.black.cgColor
        congratsLabel.layer.shadowOpacity = 0.8
        congratsLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        congratsLabel.layer.shadowRadius = 4
        view.addSubview(congratsLabel)
    }
    
    // Show the losing image and label
    func showLosingImage() {
        // Configure the losing image view
        let losingImageView = UIImageView(frame: CGRect(x: (view.bounds.width - 200) / 2, y: (view.bounds.height - 600) / 2, width: 200, height: 200))
        losingImageView.image = UIImage(named: "losing")
        losingImageView.layer.shadowColor = UIColor.black.cgColor
        losingImageView.layer.shadowOpacity = 0.8
        losingImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        losingImageView.layer.shadowRadius = 4
        view.addSubview(losingImageView)
        
        // Configure the lost label
        let lostLabel = UILabel(frame: CGRect(x: 0, y: losingImageView.frame.maxY + 60, width: view.bounds.width, height: 30))
        lostLabel.textAlignment = .center
        lostLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        lostLabel.font = UIFont.boldSystemFont(ofSize: 20)
        lostLabel.text = "YOU LOST! CORRECT ANSWER: \(secretNumber)"
        lostLabel.numberOfLines = 0
        lostLabel.layer.shadowColor = UIColor.black.cgColor
        lostLabel.layer.shadowOpacity = 0.8
        lostLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        lostLabel.layer.shadowRadius = 4
        view.addSubview(lostLabel)
    }
    
    // Resize an images to a target size
    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let scaledImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return scaledImage
    }
    
    @objc func buttonHouseTapped() {
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func buttonExitTapped() {
        exit(0)
    }
  }


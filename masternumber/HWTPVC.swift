//
//  HWTPVC.swift
//  deneme
//
//  Created by Öykü Hazer Ekinci on 24.06.2023.
//

import UIKit

class HWTPVC: UIViewController {
    
    private let pageControl = UIPageControl()
       private let labelContents = ["The user is asked to enter a single-digit number between 1 and 9 at the beginning of the game.", "According to the entered digit by the user, a secret number is generated with distinct digits.", "The user has 10 chances to make a guess.", "After each guess, as the first hint, the number of matching digits in the user's guess and the secret number, which are in the same position, is shown to the user.", "As the second hint, the number of matching digits in the user's guess and the secret number, which are in different positions, is shown to the user.", "For example, if the user enters a digit count of 5 and the generated number by the program is assumed to be 34590. When the user enters the guess 34950, the first hint value would be 3 and the second hint value would be 2."]
    
       private var textViews: [UITextView] = []
       private var currentPage: Int = 0
       private var timer: Timer?
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           // Calculate the height and position of the text views
           let textViewHeight: CGFloat = 150
           let scrollViewY = view.bounds.height / 2 - textViewHeight / 2
           
           // Create text views for each label content
           for (index, content) in labelContents.enumerated() {
               let textView = UITextView(frame: CGRect(x: 20, y: scrollViewY, width: view.bounds.width - 40, height: textViewHeight))
               textView.textAlignment = .justified
               textView.font = UIFont.systemFont(ofSize: 20, weight: .bold)
               textView.isEditable = false
               textView.isScrollEnabled = false
               textView.alpha = index == 0 ? 1 : 0
               
               // Create gradient layer for text view background
               let gradientLayer = CAGradientLayer()
               gradientLayer.frame = textView.bounds
               gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemOrange.cgColor]
               gradientLayer.startPoint = CGPoint(x: 0, y: 0)
               gradientLayer.endPoint = CGPoint(x: 1, y: 0)
               textView.layer.addSublayer(gradientLayer)
               
               // Create text layer with gradient as mask for text color
               let textGradient = gradientLayer.mask as? CATextLayer ?? CATextLayer()
               textGradient.frame = textView.bounds
               textGradient.string = content
               textGradient.alignmentMode = .justified
               textGradient.fontSize = 18
               textGradient.font = UIFont.boldSystemFont(ofSize: 20).fontName as CFTypeRef
               textGradient.foregroundColor = UIColor.black.cgColor
               textGradient.isWrapped = true
               textGradient.truncationMode = .end
                         textGradient.contentsScale = UIScreen.main.scale
                         gradientLayer.mask = textGradient

                         view.addSubview(textView)
                         textViews.append(textView)
                     }

           // Configure and add the page control
           let pageControlY = scrollViewY + 100
              pageControl.frame = CGRect(x: 0, y: pageControlY, width: view.bounds.width, height: 50)
                     pageControl.numberOfPages = labelContents.count
                     pageControl.currentPage = 0
                     pageControl.pageIndicatorTintColor = UIColor.lightGray
                     pageControl.currentPageIndicatorTintColor = UIColor.systemBlue
                     pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
                     view.addSubview(pageControl)

           pageControl.pageIndicatorTintColor = UIColor(red: 0.2, green: 0.1, blue: 0.3, alpha: 0.8)
             pageControl.currentPageIndicatorTintColor = UIColor.orange

           // Create and configure the wave layers for the background
                     let waveLayer = CAShapeLayer()
                     waveLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2 - 200)
                     waveLayer.fillColor = UIColor(red: 0.2, green: 0.1, blue: 0.3, alpha: 0.8).cgColor

               
                     waveLayer.shadowColor = UIColor.black.cgColor
                     waveLayer.shadowOpacity = 0.5
                     waveLayer.shadowOffset = CGSize(width: 0, height: 2)
                     waveLayer.shadowRadius = 4

                     let path = UIBezierPath()
                     path.move(to: CGPoint(x: 0, y: waveLayer.frame.height))
                     path.addCurve(to: CGPoint(x: view.bounds.width, y: waveLayer.frame.height),
                                   controlPoint1: CGPoint(x: view.bounds.width / 4, y: waveLayer.frame.height + 50),
                                   controlPoint2: CGPoint(x: view.bounds.width / 4 * 3, y: waveLayer.frame.height - 50))
                     path.addLine(to: CGPoint(x: view.bounds.width, y: 0))
                     path.addLine(to: CGPoint(x: 0, y: 0))
                     path.close()

                     waveLayer.path = path.cgPath
                     view.layer.insertSublayer(waveLayer, at: 0)

                     let waveLayer2 = CAShapeLayer()
                     waveLayer2.frame = CGRect(x: 0, y: view.bounds.height / 2 + 200, width: view.bounds.width, height: view.bounds.height / 2 - 200)
                     waveLayer2.fillColor = UIColor.orange.cgColor

                   
                     waveLayer2.shadowColor = UIColor.black.cgColor
                     waveLayer2.shadowOpacity = 0.5
                     waveLayer2.shadowOffset = CGSize(width: 0, height: 2)
                     waveLayer2.shadowRadius = 4

                     let path2 = UIBezierPath()
                     path2.move(to: CGPoint(x: 0, y: 0))
                     path2.addCurve(to: CGPoint(x: view.bounds.width, y: 0),
                                   controlPoint1: CGPoint(x: view.bounds.width / 4, y: -50),
                                   controlPoint2: CGPoint(x: view.bounds.width / 4 * 3, y: 50))
                     path2.addLine(to: CGPoint(x: view.bounds.width, y: waveLayer2.frame.height))
                     path2.addLine(to: CGPoint(x: 0, y: waveLayer2.frame.height))
                     path2.close()

                     waveLayer2.path = path2.cgPath
                     view.layer.insertSublayer(waveLayer2, at: 0)
           
           // Start the timer to automatically scroll to the next page
           let startButton = UIButton(frame: CGRect(x: view.bounds.width / 2 - 100, y: pageControlY + 60, width: 200, height: 50))
           startButton.setTitle("Play Game", for: .normal)
           startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
           startButton.backgroundColor = UIColor(red: 0.2, green: 0.1, blue: 0.3, alpha: 0.8)
           startButton.layer.cornerRadius = 25
           startButton.layer.shadowColor = UIColor.black.cgColor
           startButton.layer.shadowOpacity = 0.5
           startButton.layer.shadowOffset = CGSize(width: 0, height: 2)
           startButton.layer.shadowRadius = 4
           startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
           view.addSubview(startButton)
           startTimer()
           
                 }
          // Create a timer that fires every 5 seconds
             private func startTimer() {
                     timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
                
                     }
    // Calculate the index of the next page to scroll to
    @objc private func scrollToNextPage() {
            let nextPage = (pageControl.currentPage + 1) % labelContents.count
            scrollToPage(nextPage)
        }
    // Check if the page index is within the valid range
        private func scrollToPage(_ page: Int) {
            guard page >= 0 && page < labelContents.count else {
                return
            }

            let selectedLabelIndex = page
            pageControl.currentPage = selectedLabelIndex

            // Show the selected text view and hide the others
            for (index, textView) in textViews.enumerated() {
                textView.alpha = index == selectedLabelIndex ? 1 : 0
            }
        }

        @objc private func pageControlValueChanged(_ sender: UIPageControl) {
            // Handle the event when the page control value changes
            let selectedLabelIndex = sender.currentPage
            scrollToPage(selectedLabelIndex)
            // Reset the timer when the page control value changes
            timer?.invalidate()
            startTimer()
        }
    
    @objc private func startButtonTapped() {
        // Perform the segue to start the game
        performSegue(withIdentifier: "pgSegue2", sender: nil)
    }
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            // Invalidate the timer when the view disappears
            timer?.invalidate()
        }
    }

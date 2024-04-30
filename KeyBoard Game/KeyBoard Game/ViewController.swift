//
//  ViewController.swift
//  KeyBoard Game
//
//  Created by Chelsea Bhuiyan on 4/22/24.
//

import UIKit
import Foundation

class Flashcard {
    let frontText: String
    let backText: String
    
    init(frontText: String, backText: String) {
        self.frontText = frontText
        self.backText = backText
    }
}
class ViewController: UIViewController {
    

    @IBOutlet weak var userInputFrontTextField: UITextField!
    
    @IBOutlet weak var userInputBackTextField: UITextField!
    
    
    @IBOutlet weak var createFlashCardButton: UIButton!
    
    
    @IBOutlet weak var flashcardView: UIView!
    
    
    @IBOutlet weak var flipButton: UIButton!
    
    
    @IBOutlet weak var previousButton: UIButton!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    var flashcards: [Flashcard] = []
        var currentFlashcardIndex = 0
        var isShowingFront = true


    override func viewDidLoad() {
        super.viewDidLoad()
        // Change the background color of the main view
            view.backgroundColor = UIColor(red: 0.529, green: 0.808, blue: 0.922, alpha: 0.5)
        // Do any additional setup after loading the view.
        
        
        
    }
    
    
    @IBAction func createFlashcardButtonTapped(_ sender: Any) {
        guard let frontText = userInputFrontTextField.text, !frontText.isEmpty,
                     let backText = userInputBackTextField.text, !backText.isEmpty else {
                   let alertController = UIAlertController(title: "Error", message: "Please enter text for both sides of the flashcard.", preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   alertController.addAction(okAction)
                   present(alertController, animated: true, completion: nil)
                   return
               }
               
               let flashcard = Flashcard(frontText: frontText, backText: backText)
               flashcards.append(flashcard)
               showFlashcard(flashcard)
               
               userInputFrontTextField.text = ""
               userInputBackTextField.text = ""
    }
    
    @IBAction func flipButtonTapped(_ sender: Any) {
        guard !flashcards.isEmpty else {
                    return
                }
                
                let flashcard = flashcards[currentFlashcardIndex]
                if isShowingFront {
                    flipButton.setTitle(flashcard.backText, for: .normal)
                } else {
                    flipButton.setTitle(flashcard.frontText, for: .normal)
                }
                isShowingFront = !isShowingFront
    }
    
    
    func configureFlashcardText(_ text: String) {
        // Set the text for the flip button
        flipButton.setTitle(text, for: .normal)
        
        // Set content alignment to center
        flipButton.contentHorizontalAlignment = .center
        flipButton.contentVerticalAlignment = .center
        
        // Set line break mode to wrap
        flipButton.titleLabel?.lineBreakMode = .byWordWrapping
        flipButton.titleLabel?.numberOfLines = 0
        
        // Set font size and style
        flipButton.titleLabel?.font = UIFont.systemFont(ofSize: 17) // Adjust the font size as needed
        
        // Optionally, adjust the title color
        flipButton.setTitleColor(UIColor.black, for: .normal)
        
    }
    
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        currentFlashcardIndex -= 1
                if currentFlashcardIndex < 0 {
                    currentFlashcardIndex = flashcards.count - 1
                }
                let flashcard = flashcards[currentFlashcardIndex]
                showFlashcard(flashcard)
                updateNavigationButtons()
    }
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        currentFlashcardIndex += 1
                if currentFlashcardIndex >= flashcards.count {
                    currentFlashcardIndex = 0
                }
                let flashcard = flashcards[currentFlashcardIndex]
                showFlashcard(flashcard)
                updateNavigationButtons()
    }
    func showFlashcard(_ flashcard: Flashcard) {
            flashcardView.isHidden = false
            flashcardView.backgroundColor = UIColor(red: 0.678, green: 0.937, blue: 0.796, alpha: 0.5)// Change the color as needed
            flipButton.isHidden = false
            flipButton.setTitle(flashcard.frontText, for: .normal)
            isShowingFront = true
        }
        
        func updateNavigationButtons() {
            if flashcards.isEmpty {
                nextButton.isEnabled = false
                previousButton.isEnabled = false
            } else {
                nextButton.isEnabled = true
                previousButton.isEnabled = true
            }
        }
    
}


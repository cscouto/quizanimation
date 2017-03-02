//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var questionCenterConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionCenterConstraint: NSLayoutConstraint!
    
    let questions: [String] = [
        "From what is cognac made?",
        "What is 7+7?",
        "What is the capital of Vermont?"
    ]
    let answers: [String] = [
        "Grapes",
        "14",
        "Montpelier"
    ]
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestionIndex]
        setOffSreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
    }
    
    @IBAction func showNextQuestion(_ sender: UIButton) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    
    @IBAction func showAnswer(_ sender: UIButton) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    func setOffSreen(){
        let width = view.frame.width
        nextQuestionCenterConstraint.constant = -width
    }
    
    func animateLabelTransitions(){
        
        view.layoutIfNeeded()
        
        let width = view.frame.width
        nextQuestionCenterConstraint.constant = 0
        questionCenterConstraint.constant += width
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear], animations: {
            self.questionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            self.view.layoutIfNeeded()
        }, completion: { _ in
            swap(&self.questionLabel, &self.nextQuestionLabel)
            swap(&self.questionCenterConstraint, &self.nextQuestionCenterConstraint)
            self.setOffSreen()
        })
    }

}


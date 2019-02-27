//
//  ViewController.swift
//  Learn This
//
//  Created by James Stacy on 2/5/19.
//  Copyright © 2019 James Stacy. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var item: MemryItem!
    var blankCounter = 0
    
    
    let visableText:[NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 28)!,
        .foregroundColor: UIColor.black
    ]
    
    let invisableText:[NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 28)!,
        .foregroundColor: UIColor.clear,
        .strikethroughStyle:1,
        .strikethroughColor: UIColor.black
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(item != nil, "No thang picked")
      showText()
        
        let tapReconizer = UITapGestureRecognizer(target: self, action: #selector (wordsTapped))
        textView.addGestureRecognizer(tapReconizer)
     
        
    }

    func showText() {
        let words = item.text.components(separatedBy: " ")
        var outPut = NSMutableAttributedString()
        let space = NSAttributedString(string: " ", attributes: visableText)
       
        for (index, word) in words.enumerated() {
            if index < blankCounter {
                let attributedWord = NSAttributedString(string: word, attributes: visableText)
                outPut.append(attributedWord)
            }else{
                var strippedWord = word
                var puncuation:String?
                if ".,".contains(word.last!) {
                    puncuation = String(strippedWord.removeLast())
                }
                 let attributedWord = NSAttributedString(string: strippedWord, attributes: invisableText)
                outPut.append(attributedWord)
                
                if let symbol = puncuation {
                    let attributedPuncuation = NSAttributedString(string: symbol, attributes: visableText)
                    outPut.append(attributedPuncuation)
                }
            }
             outPut.append(space)
            
        }
        
        
        textView.attributedText = outPut
        
    }
    
   @objc func wordsTapped() {
        blankCounter += 1
        showText()
    }
}


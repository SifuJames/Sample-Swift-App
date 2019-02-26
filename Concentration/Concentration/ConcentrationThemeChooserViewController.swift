//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by James Stacy on 2/26/19.
//  Copyright © 2019 James Stacy. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation
    let themes = [
        "Sports":"⚽️⚾️🎾🏓🏈🏐🏹🚴‍♀️🏄🏿‍♂️🤺🥊",
        "Animals":"🐶🐭🐱🐰🐻🦊🐷🐨🐼🐵🦄",
        "Faces":"😀😁😂🥶😱🤬😫😎🤪😇🧐",
        "Scary":"👻💀☠️👽🎃🤡👹💩🤠🤖😈👺"
    ]
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if segue.identifier == "choose theme" {
            if let themeName = (sender as? UIButton)?.currentTitle ,let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
              
            }}
        
    }
    

}

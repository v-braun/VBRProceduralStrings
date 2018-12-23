//
//  ViewController.swift
//  VBRProceduralStringsSample
//
//  Created by Viktor Braun on 23.12.2018.
//  Copyright © 2018 Viktor Braun - Software Development. All rights reserved.
//

import UIKit
import VBRProceduralStrings
class ViewController: UIViewController {

    
    
    @IBOutlet weak var _svgView: UIView!
    
    @IBAction func generateTouch(_ sender: Any) {
        let settings = ProcStringsSettings()
        
        settings.width = Float(_svgView.bounds.width)
        settings.height = Float(_svgView.bounds.height)
        settings.lines = 100
        settings.points = 8
        settings.gradients.append(GradientStep(offset: 0, color: "#03a9f4"))
        settings.gradients.append(GradientStep(offset: 70, color: "#e91e63"))
        
        let subView = ProceduralStringGenerator.generateSVGUIView(settings: settings)
        
        
        if _svgView.subviews.count > 0{
            _svgView.subviews.first!.removeFromSuperview()
        }
        _svgView.addSubview(subView)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.generateTouch(self)
    }


}


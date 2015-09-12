//
//  GameViewController.swift
//  Dots-Demo
//
//  Created by Russell Ladd on 9/12/15.
//  Copyright (c) 2015 GRL5. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get view
        let skView = self.view as! SKView
        
        // Flag set to improve performance
        skView.ignoresSiblingOrder = true
        
        // Create and configure scene
        let scene = GameScene()
        
        scene.backgroundColor = UIColor.whiteColor()
        scene.scaleMode = .ResizeFill
        
        // Present scene
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

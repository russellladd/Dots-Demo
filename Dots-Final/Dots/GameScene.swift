//
//  GameScene.swift
//  Dots
//
//  Created by Russell Ladd on 9/3/15.
//  Copyright (c) 2015 GRL5. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        updateBoundingEdgeLoop()
    }
    
    override func didChangeSize(oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        updateBoundingEdgeLoop()
    }
    
    func updateBoundingEdgeLoop() {
        
        let rect = CGRect(origin: CGPointZero, size: self.size)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: rect)
    }
    
    let colors = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.purpleColor(), UIColor.orangeColor(), UIColor.yellowColor()]
    
    func handleTap(tapGestureRecognizer: UITapGestureRecognizer) {
        
        if tapGestureRecognizer.state == .Ended {
            
            // Create node
            
            let dot = SKSpriteNode(imageNamed: "Dot")
            
            let randomIndex = Int(arc4random()) % 6
            
            dot.color = colors[randomIndex]
            dot.colorBlendFactor = 1.0
            
            // Find location
            
            let location = tapGestureRecognizer.locationInView(self.view!)
            let convertedLocation = self.convertPointFromView(location)
            
            dot.position = convertedLocation
            
            // Create physics body
            
            let body = SKPhysicsBody(circleOfRadius: dot.size.width / 2.0)
            
            dot.physicsBody = body
            
            // Add node to scene
            
            self.addChild(dot)
        }
    }
    
    var draggingDot: SKNode? {
        didSet {
            if let dot = oldValue {
                dot.physicsBody!.affectedByGravity = true
            }
            
            if let dot = draggingDot {
                dot.physicsBody!.affectedByGravity = false
            }
        }
    }
    
    func handlePan(panGestureRecognizer: UIPanGestureRecognizer) {
        
        let location = panGestureRecognizer.locationInView(self.view!)
        let convertedLocation = self.convertPointFromView(location)
        
        switch panGestureRecognizer.state {
            
        case .Began:
            let dot = self.nodeAtPoint(convertedLocation)
            
            if dot != self {
                draggingDot = dot
            }
            
        case .Changed:
            if let dot = draggingDot {
                dot.position = convertedLocation
            }
            
        case .Ended:
            draggingDot = nil
            
        default:
            break
        }
    }
}

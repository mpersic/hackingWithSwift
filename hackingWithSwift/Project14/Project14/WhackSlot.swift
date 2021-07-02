//
//  WhackSlot.swift
//  Project14
//
//  Created by COBE on 10/06/2021.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {
    var charNode: SKSpriteNode!
    var isVisible = false
    var isHit = false
    
    func configure(at position: CGPoint){
        self.position = position
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
    
    func show(hideTime: Double){
        if isVisible { return }
        charNode.xScale = 1
        charNode.yScale = 1
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        }
        else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime + 3.5)){ [weak self] in
            //self?.sprayMud()
            self?.hide()
        }
    }
    func hide(){
        if !isVisible { return }
        sprayMud()
        charNode.run(SKAction.moveBy(x: 0, y: 0, duration: 0.05))
        isVisible = false
        //sprayMud()
    }
    func hit(){
        isHit = true
        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        let notVisible = SKAction.run { [weak self] in
            self?.isVisible = false
        }
        let sequence = SKAction.sequence([delay, hide, notVisible])
        charNode.run(sequence)
    }
    func sprayMud() {
        if let mudParticle = SKEmitterNode(fileNamed: "mud") {
            switch isVisible {
                case true: mudParticle.position = CGPoint(x: 0, y: 0)
                case false: mudParticle.position = CGPoint(x: 0, y: charNode.position.y + 80)
            }
            
            let mudSequence = SKAction.sequence([
                SKAction.run { [weak self] in self?.addChild(mudParticle) },
                SKAction.wait(forDuration: 3.0),
                SKAction.run { mudParticle.removeFromParent() }
                ])
            
            run(mudSequence)
        }
    }
}

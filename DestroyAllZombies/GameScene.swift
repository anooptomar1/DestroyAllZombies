//
//  GameScene.swift
//  DestroyAllZombies
//
//  Created by Robert Anderson on 9/12/2014.
//  Copyright (c) 2014 Robert Anderson. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    var motionManager: CMMotionManager = CMMotionManager()
    
    var player: SKNode {
        get { return self.childNodeWithName("player")! }
    }
    
    var flame: SKEmitterNode {
        get { return self.childNodeWithName("player/flame") as SKEmitterNode }
    }
    
    override func didMoveToView(view: SKView) {
        motionManager.startDeviceMotionUpdates()
    }
    
    override func didChangeSize(oldSize: CGSize) {
        self.player.position = CGPoint(
            x: CGRectGetMidX(self.frame),
            y: CGRectGetMidY(self.frame)
        )
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.flame.particleBirthRate = 450
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.flame.particleBirthRate = 0
    }
   
    override func update(currentTime: CFTimeInterval) {
        if let yaw = self.motionManager.deviceMotion?.attitude.yaw {
            let angle = CGFloat(-yaw + M_PI / 2.0)
            self.player.zRotation = angle
            self.flame.emissionAngle = angle
        }
    }
}

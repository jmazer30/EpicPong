//
//  GameScene.swift
//  EpicPong
//
//  Created by  on 12/2/19.
//  Copyright © 2019 JordansEpicApps. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    
    var ball = SKSpriteNode()
    var paddle = SKSpriteNode()
    var aiPaddle = SKSpriteNode()
    
    override func didMove(to view: SKView)
    {
        let borderBody = SKPhysicsBody (edgeLoopFrom: self.frame)
        borderBody.friction = 0.0
        self.physicsBody = borderBody
        physicsWorld.gravity = CGVector (dx: 0, dy: 0)
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        paddle = self.childNode(withName: "paddle") as! SKSpriteNode
        createAIPaddle()
    }
    
    func createAIPaddle ()
    {
        // create the paddle at the top of the screen
        aiPaddle = SKSpriteNode(color: .magenta, size: CGSize(width: 200, height: 50))
        aiPaddle.position = CGPoint (x: frame.width * 0.5, y: frame.height * 0.8)
        addChild (aiPaddle)
        aiPaddle.name = "aiPaddle"
        // add physics to the paddle
        aiPaddle.physicsBody = SKPhysicsBody (rectangleOf: aiPaddle.frame.size)
        aiPaddle.physicsBody?.allowsRotation = false
        aiPaddle.physicsBody?.friction = 0
        aiPaddle.physicsBody?.affectedByGravity = false
        aiPaddle.physicsBody?.isDynamic = false
        // create an action that will follow the ball
       run (SKAction.repeatForever (
            SKAction.sequence([SKAction.run (followBall), SKAction.wait(forDuration: 0.25)])
        ))
    }
    
    func followBall()
    {
        let location2 = aiPaddle.position
        //if location2.y > frame.height / 2 + 25
        //{
        let move = SKAction.moveTo(x: ball.position.x, duration: 0.25)
        let move2 = SKAction.moveTo(y: ball.position.y, duration: 0.25)
        aiPaddle.run(move)
        aiPaddle.run(move2)
        //}
        
    }
    
    func makeNewBall(location: CGPoint)
    {
        var ball = SKSpriteNode(color: .brown, size: CGSize(width: 100, height: 100))
        ball.position = location
        addChild(ball)
        ball.physicsBody = SKPhysicsBody (circleOfRadius: 50)
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.friction = 0
        ball.physicsBody?.allowsRotation = true
        ball.physicsBody?.restitution = 1.0
        ball.physicsBody?.velocity = CGVector (dx: -500, dy: 500)
    }
  
    var isFingerOnPaddle = false
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let location = touches.first!.location(in: self)
       // makeNewBall(location: location)
        if paddle.frame.contains(location)
        {
            isFingerOnPaddle = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let location = touches.first!.location(in: self)
        if isFingerOnPaddle == true && location.y < frame.height / 2 - 25
        {
            paddle.position = location
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        isFingerOnPaddle = false
    }
    
   
}

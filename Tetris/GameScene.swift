//
//  GameScene.swift
//  Tetris
//
//  Created by Alb on 10/2/14.
//  Copyright (c) 2014 01Logic. All rights reserved.
//

import SpriteKit

//#1
let TickLengthLevelOne = NSTimeInterval(600)

class GameScene: SKScene
{
//#2
	var tick: ( () -> () )?
	var tickLengthMillis = TickLengthLevelOne
	var lastTick: NSDate?

	
	required init (coder aDecoder: NSCoder)
	{
		fatalError("NSCoder not supported")
	}
	
	override init(size: CGSize)
	{
		super.init(size: size)
		
		anchorPoint = CGPoint(x: 0, y: 1.0)
		
		let background = SKSpriteNode(imageNamed: "background")
		background.position = CGPoint(x: 0, y: 0)
		background.anchorPoint = CGPoint(x: 0, y: 0)
		addChild(background)
	}
	
	override func update(currentTime: CFTimeInterval)
	{
		/* Called before each frame is rendered */
//#3
		if lastTick == nil
		{
			return
		}
		
		var timePassed = lastTick!.timeIntervalSinceNow * -1000.0
		if timePassed > tickLengthMillis
		{
			lastTick = NSDate.date()
			tick?()
		}
	}
//#4
	func startTicking()
	{
		lastTick = NSDate.date()
	}
	
	func stopTicking()
	{
		lastTick = nil
	}
	
}


/******************************DOC******************************

#1
First, we define a new constant at #1, TickLengthLevelOne. This variable will represent the slowest speed at which our shapes will travel. We've set it to 600 milliseconds, which means that every 6/10ths of a second, our shape should descend by one row.

#2
At #2 you can see we've defined a few variables. tickLengthMillis and lastTick look similar to declarations we've seen before: one being the GameScene's current tick length – set to TickLengthLevelOne by default – and the other will track the last time we experienced a tick, an NSDate object.In defining tick, its type is (() -> ())? which means that it's a closure which takes no parameters and returns nothing. Its question mark indicates that it is optional and therefore may be nil.

#3
At #3 we'll put our new member variables to work. If lastTick is missing, we are in a paused state, not reporting elapsed ticks to anyone, therefore we simply return. However, if lastTick is present we recover the time passed since the last execution of update by invoking timeIntervalSinceNow on our lastTick object. We multiply the result by -1000 in order to get a positive millisecond value. We then check if the time passed has exceeded our tickLengthMillis variable. If enough time has elapsed, we must report a tick. We do so by first updating our last known tick time to the present and then invoking our closure. The syntax we use is conditioned on whether or not tick is present. By placing a ? after the variable name, we are asking Swift to first check if tick exists and if so, invoke it with no parameters. It is shorthand for the following statement:

if tick != nil { tick!() }

#4
Lastly, at #4 we provide accessor methods to let external classes stop and start the ticking process, something we'll make use of later in order to keep pieces from falling at key moments.

******************************DOC*******************************/
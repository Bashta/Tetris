//
//  GameViewController.swift
//  Tetris
//
//  Created by Alb on 10/2/14.
//  Copyright (c) 2014 01Logic. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController
{
	var scene: GameScene!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		//configure the view
		let skView = view as SKView
		skView.multipleTouchEnabled = false
		
		//Create and configure the scene
		
		scene = GameScene(size: skView.bounds.size)
		scene.scaleMode = .AspectFill
		
		//Present the scene
		skView.presentScene(scene)
		println("passed")

	}
	
	override func prefersStatusBarHidden() -> Bool
	{
		return true
	}
}

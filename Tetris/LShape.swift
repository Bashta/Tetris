//
//  LShape.swift
//  Tetris
//
//  Created by Alb on 10/7/14.
//  Copyright (c) 2014 01Logic. All rights reserved.
//

class LShape:Shape
{
	/*
	
	Orientation 0
	
	| 0•|
	| 1 |
	| 2 | 3 |
	
	Orientation 90
	
	•
	| 2 | 1 | 0 |
	| 3 |
	
	Orientation 180
	
	| 3 | 2•|
	| 1 |
	| 0 |
	
	Orientation 270
	
	• | 3 |
	| 0 | 1 | 2 |
	
	• marks the row/column indicator for the shape
	
	Pivots about `1`
	
	*/
	
	override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>]
	{
		return [
			Orientation.Zero:		   [ (0, 0), (0, 1),  (0, 2),  (1, 2)],
			Orientation.Ninety:		   [ (1, 1), (0, 1),  (-1,1), (-1, 2)],
			Orientation.OneHundredEighty:  [ (0, 2), (0, 1),  (0, 0),  (-1,0)],
			Orientation.TwoHunderdSeventy: [ (-1,1), (0, 1),  (1, 1),   (1,0)]
			]
	}
	
	override var bottomBlocksForOrientations: [Orientation: Array<Block>]
	{
		return [
			Orientation.Zero:		   [blocks[ThirdBlockIndex], blocks[FourthBlockIndex]],
			Orientation.Ninety:		   [blocks[FirstBlockIndex], blocks[SecondBlockIndex], blocks[FourthBlockIndex]],
			Orientation.OneHundredEighty:  [blocks[FirstBlockIndex], blocks[FourthBlockIndex]],
			Orientation.TwoHunderdSeventy: [blocks[FirstBlockIndex], blocks[SecondBlockIndex], blocks[ThirdBlockIndex]]
			]
	}
}

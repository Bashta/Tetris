//
//  JShape.swift
//  Tetris
//
//  Created by Alb on 10/7/14.
//  Copyright (c) 2014 01Logic. All rights reserved.
//

class JShape:Shape
{
	/*
	
	Orientation 0
	
     • | 0 |
	| 1 |
	| 3 | 2 |
	
	Orientation 90
	
	| 3•|
	| 2 | 1 | 0 |
	
	Orientation 180
	
	| 2•| 3 |
	| 1 |
	| 0 |
	
	Orientation 270
	
	| 0•| 1 | 2 |
	| 3 |
	
	• marks the row/column indicator for the shape
	
	Pivots about `1`
	
	*/
	
	override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>]
	{
		return [
			Orientation.Zero:       [(1, 0), (1, 1),  (1, 2),  (0, 2)],
			Orientation.Ninety:     [(2, 1), (1, 1),  (0, 1),  (0, 0)],
			Orientation.OneHundredEighty:  [(0, 2), (0, 1),  (0, 0),  (1, 0)],
			Orientation.TwoHunderdSeventy: [(0, 0), (1, 0),  (2, 0),  (2, 1)]
			]
	}
	
	override var bottomBlocksForOrientations: [Orientation: Array<Block>]
	{
		return [
			Orientation.Zero:		   [blocks[ThirdBlockIndex], blocks[FourthBlockIndex]],
			Orientation.Ninety:		   [blocks[FirstBlockIndex], blocks[SecondBlockIndex], blocks[ThirdBlockIndex]],
			Orientation.OneHundredEighty:  [blocks[FirstBlockIndex], blocks[FourthBlockIndex]],
			Orientation.TwoHunderdSeventy: [blocks[FirstBlockIndex], blocks[SecondBlockIndex], blocks[FourthBlockIndex]]
			]
	}
}
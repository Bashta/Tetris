//
//  LineShape.swift
//  Tetris
//
//  Created by Alb on 10/10/14.
//  Copyright (c) 2014 01Logic. All rights reserved.
//

class LineShape:Shape
{
	/*
	Orientations 0 and 180:
	
	| 0•|
	| 1 |
	| 2 |
	| 3 |
	
	Orientations 90 and 270:
	
	| 0 | 1•| 2 | 3 |
	
	• marks the row/column indicator for the shape
	
	*/
	
	// Hinges about the second block
	
	override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>]
	{
		return [
			Orientation.Zero:       [(0, 0), (0, 1), (0, 2), (0, 3)],
			Orientation.Ninety:     [(-1,0), (0, 0), (1, 0), (2, 0)],
			Orientation.OneHundredEighty:  [(0, 0), (0, 1), (0, 2), (0, 3)],
			Orientation.TwoHunderdSeventy: [(-1,0), (0, 0), (1, 0), (2, 0)]
			]
	}
	
	override var bottomBlocksForOrientations: [Orientation: Array<Block>]
	{
		return [
			Orientation.Zero:       [blocks[FourthBlockIndex]],
			Orientation.Ninety:     blocks,
			Orientation.OneHundredEighty:  [blocks[FourthBlockIndex]],
			Orientation.TwoHunderdSeventy: blocks
			]
	}
}
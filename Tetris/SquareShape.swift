//
//  SquareShape.swift
//  Tetris
//
//  Created by Alb on 10/6/14.
//  Copyright (c) 2014 01Logic. All rights reserved.
//

class SquareShape: Shape
{
	/*
// #1
	| 0•| 1 |
	| 2 | 3 |
	
	• marks the row/column indicator for the shape
	
	*/
	
	// The square shape will not rotate
	
// #2
	override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>]
	{
		return [
			Orientation.Zero:		   [(0, 0), (1, 0), (0, 1), (1, 1)],
			Orientation.OneHundredEighty:  [(0, 0), (1, 0), (0, 1), (1, 1)],
			Orientation.Ninety:		   [(0, 0), (1, 0), (0, 1), (1, 1)],
			Orientation.TwoHunderdSeventy: [(0, 0), (1, 0), (0, 1), (1, 1)]
			]
	}
	
// #3
	override var bottomBlocksForOrientations: [Orientation: Array<Block>]
		{
		return [
			Orientation.Zero:		   [blocks[ThirdBlockIndex], blocks[FourthBlockIndex]],
			Orientation.OneHundredEighty:  [blocks[ThirdBlockIndex], blocks[FourthBlockIndex]],
			Orientation.Ninety:            [blocks[ThirdBlockIndex], blocks[FourthBlockIndex]],
			Orientation.TwoHunderdSeventy: [blocks[ThirdBlockIndex], blocks[FourthBlockIndex]]
			]
	}
}

//
//  Tetris.swift
//  Tetris
//
//  Created by Alb on 10/10/14.
//  Copyright (c) 2014 01Logic. All rights reserved.
//

// #1
let NumColumns = 10
let NumRows = 20

let StartingColumn = 4
let StartingRow = 0

let PreviewColumn = 12
let PreviewRow = 1

class Swiftris
{
	var blockArray:Array2D<Block>
	var nextShape:Shape?
	var fallingShape:Shape?
	
	init()
	{
		fallingShape = nil
		nextShape = nil
		blockArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
		println("passed")
	}
	
	func beginGame()
	{
		if (nextShape == nil)
		{
			nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
		}
	}
	
	// #2
	func newShape() -> (fallingShape:Shape?, nextShape:Shape?)
	{
		fallingShape = nextShape
		nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
		fallingShape?.moveTo(StartingColumn, row: StartingRow)
		return (fallingShape, nextShape)
	}
}

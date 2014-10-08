//
//  Array2D.swift
//  Tetris
//
//  Created by Alb on 10/2/14.
//  Copyright (c) 2014 01Logic. All rights reserved.
//

//#1
class Array2D<T>
{
	let columns: Int
	let rows:   Int
	
//#2
	var array: Array<T?>
	
	init(columns: Int, rows: Int)
	{
		self.columns = columns
		self.rows = rows
//#3
		array = Array<T?>(count: rows * columns, repeatedValue:nil)
	}
//#4
	subscript(column: Int, row: Int) ->T?
	{
		get
		{
			return array[(row * columns) + column]
		}
		
		set(newValue)
		{
			array[(row * columns) + column] = newValue
		}
	}
	
	}




/******************************DOC******************************

#1
Generic arrays in Swift are actually of type struct, not class but we need a class in this case since class objects are passed by reference whereas structures are passed by value (copied). Our game logic will require a single copy of this data structure to persist across the entire game.

#2
We declare an actual Swift array; it will be the underlying data structure which maintains references to our objects. It's declared with type <T?>. A "?" in Swift symbolizes an optional value. An optional value is just that, optional. Optional variables may or may not contain data, and they may in fact be nil, or empty. nil locations found on our game board will represent empty spots where no block is present.

#3
During our initialization at #3, we instantiate our internal array structure with a size of rows * columns. This guarantees that Array2D can store as many objects as our game board requires, 200 in our case.

#4
Creates a custom subscript for Array2D. We wanted to have a subscript capable of supporting array[column, row] - this accomplishes just that. The getter is fairly self explanatory. To get the value at a given location we need to multiply the provided row by the class variable columns, then add the column number to reach the final destination.The setter is the reverse operation of that; newValue is assigned to the location determined by the same algorithm found in the custom getter.



******************************DOC*******************************/

import SpriteKit

let numberOfOrientations: UInt32 = 4

enum Orientation: Int, Printable
{
	case Zero = 0, Ninety, OneHundredEighty, TwoHunderdSeventy
	
	var description: String
		{
		switch self
			{
		case .Zero:
			return "0"
		case .Ninety:
			return "90"
		case .OneHundredEighty:
			return "180"
		case .TwoHunderdSeventy:
			return "270"
			}
	}
	
	static func random() -> Orientation
	{
		return Orientation.fromRaw(Int(arc4random_uniform(numberOfOrientations)))!
	}
//#1
	static func rotate(orentatiom:Orientation, clockwise: Bool) -> Orientation
	{
		var rotated = orentatiom.toRaw() + (clockwise ? 1: -1)
		
		if rotated > Orientation.TwoHunderdSeventy.toRaw()
		{
			rotated = Orientation.Zero.toRaw()
		} else if rotated < 0
		{
			rotated = Orientation.TwoHunderdSeventy.toRaw()
		}
		return Orientation.fromRaw(rotated)!
	}
	
}

//Number of the total shapes
let numberOfShapeTypes: UInt32 = 7

//Shape indexes
let FirstBlockIndex: Int = 0
let SecondBlockIndex: Int = 1
let ThirdBlockIndex: Int = 2
let FourthBlockIndex: Int = 3


class Shape: Hashable, Printable
{
	//The color of the shape
	let color: BlockColor
	
	//The blocks comprising the shape
	var blocks = Array<Block>()
	//The current orientation of the shape
	var orientation: Orientation
	//The column and row representing the shape's anchor point
	var column, row : Int
	
	//Required Overrides
	
//#1
	//Subclasses must override this property
	var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>]
	{
		return [:]
	}
//#2
	var bottomBlocksForOrientations: [Orientation: Array<Block>]
	{
		return [:]
	}
//#3
	var bottomBlocks: Array<Block>
	{
		if let bottomBlocks = bottomBlocksForOrientations[orientation]
		{
			return bottomBlocks
		}
			return []
	}
	
	//Hashtable
	var hashValue: Int
	{
//#4
		return reduce(blocks, 0) { $0.hashValue ^ $1.hashValue }
	}
	
	//Printable
	var description: String
	{
		return "\(color) block facing \(orientation): \(blocks[FirstBlockIndex]), \(blocks[SecondBlockIndex]), \(blocks[ThirdBlockIndex]), \(blocks[FourthBlockIndex])"
	}
	
	init(column: Int, row: Int, color: BlockColor, orientation: Orientation )
	{
		self.column      = column
		self.row         = row
		self.color	   = color
		self.orientation = orientation
		
		initializeBocks()
	}

//#5
	convenience init (column: Int, row: Int)
	{
		self.init(column: column, row: row, color: BlockColor.random(), orientation:Orientation.random())
	}
//6
	final func initializeBocks()
	{
//7
		if let blockRowColumnTranslations = blockRowColumnPositions[orientation]
		{
			for i in 0 ..< blockRowColumnTranslations.count
			{
				let blockRow = row + blockRowColumnTranslations[i].rowDiff
				let blockColumn = column + blockRowColumnTranslations[i].columnDiff
				let newBlock = Block(column: blockColumn, row: blockRow, color: color)
				blocks.append(newBlock)
			}
		}
	}
	
	final func rotateBlocks(orientation: Orientation)
	{
		if let blockRowColumnTranslation:Array<(columnDiff: Int, rowDiff: Int)> = blockRowColumnPositions[orientation]
		{
//8
			for (idx, (columnDiff:Int, rowDiff:Int)) in enumerate(blockRowColumnTranslation)
			{
				blocks[idx].column = column + columnDiff
				blocks[idx].row = row + rowDiff
			}
		}
	}
	

	final func lowerShapeByOneRow()
	{
		shiftBy(0, rows:1)
	}
	
//9
	final func shiftBy(columns: Int, rows: Int)
	{
		self.column += columns
		self.row += rows
		for block in blocks
		{
			block.column += columns
			block.row += rows
		}
	}

//10
	final func moveTo(column: Int, row: Int)
	{
		self.column = column
		self.row = row
		rotateBlocks(orientation)
	}

//11
	final class func random(startingColumn: Int, startingRow: Int) -> Shape
	{
		switch Int(arc4random_uniform(numberOfShapeTypes))
		{
		case 0:
			return SquareShape(column: startingColumn, row: startingRow)
		case 1:
			return LineShape(column:startingColumn, row:startingRow)
		case 2:
			return TShape(column:startingColumn, row:startingRow)
		case 3:
			return LShape(column:startingColumn, row:startingRow)
		case 4:
			return JShape(column:startingColumn, row:startingRow)
		case 5:
			return SShape(column:startingColumn, row:startingRow)
		default:
			return ZShape(column:startingColumn, row:startingRow)
		}
	}
	
}//class end



func ==(lhs: Shape, rhs: Shape) -> Bool
{
	return lhs.row == rhs.row && lhs.column == rhs.column
}




/******************************DOC******************************

#1
At #1, we provided a method capable of returning the next orientation when traveling either clockwise or counterclockwise.

******************************DOC*******************************/



/*****************************-----*Class DOC*-----******************************
#1
At #1 we have declared a computed propertie and left the result empty. This was done on purpose such that our actual shape classes will override them in its implementation.
#1, blockRowColumnPositions defines a computed Dictionary. A dictionary is defined with square braces – […] – and maps one type of object to another. The first object type listed defines the key and the second, a value. Keys map one-to-one with values and multiple copies of a single key may not exist. We access dictionary values similarly to those of an array by employing square braces. However, our subscripts are now keys, and therefore in the case of blockRowColumnPositions, they are Orientation objects. The values found in this dictionary are peculiar as well, Array<(columnDiff: Int, rowDiff: Int)>.

#2
At #2 we have declared a computed propertie and left the result empty. This was done on purpose such that our actual shape classes will override them in its implementation.

#3
At #3 we wrote a complete computed property which is designed to return the bottom blocks of the shape at its current orientation. This will be useful later when our blocks get physical and start contacting walls and each other.

#4
At #4 we use the reduce<S : Sequence, U>(sequence: S, initial: U, combine: (U, S.GeneratorType.Element) -> U) -> U method to iterate through our entire blocks array. We exclusively-or each block's hashValue together to create a single hashValue for the Shape they comprise.

#5
At #5 we introduce a special type of initializer. A convenience initializer must call down to a standard initializer or otherwise your class will fail to compile. We've placed this one here in order to simplify the initialization process for users of the Shape class. It assigns the given row and column values while generating a random color and a random orientation.

#6
At #6 we defined a final function which means it cannot be overridden by subclasses. This implementation of initializeBlocks() is the only one allowed by Shape and its subclasses.

#7
At #7 we introduced conditional assignments. This if conditional first attempts to assign an array into blockRowColumnTranslations after extracting it from the computed dictionary property. If one is not found, the if block is not executed.

#8
At #8 we introduce the enumerate operator. This allows us to iterate through an array object by defining an index variable - idx - as well as the contents at that index: (columnDiff:Int, rowDiff:Int). This saves us the added step of recovering it from the array, let tuple = blockRowColumnTranslation[idx]. We loop through the blocks and assign them their row and column based on the translations provided by the Tetromino subclass

#9
At #9, we've included a simple shiftBy(columns: Int, rows: Int) method which will adjust each row and column by rows and columns, respectively.

#10
At #10 we provide an absolute approach to position modification by setting the column and row properties before rotating the blocks to their current orientation which causes an accurate realignment of all blocks relative to the new row and column properties.

#11
At #11 we've created a method to generate a random Tetromino shape and you can see that subclasses naturally inherit initializers from their parent class.



******************************-----*Class DOC*-----******************************/































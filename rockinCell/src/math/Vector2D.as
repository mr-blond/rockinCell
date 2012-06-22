package  math
{
	/**
	 * ...
	 * @author shiu
	 */
	public class Vector2D 
	{
		//------------------------------------------------//
		//     				Propriétés					  //
		//------------------------------------------------//
		private var _x:Number;
		private var _y:Number;
		//------------------------------------------------//
		//       	     Constructeur					  //
		//------------------------------------------------//
		public function Vector2D(valueX:Number, valueY:Number) 
		{
			this._x = valueX;
			this._y = valueY;
		}
		//------------------------------------------------//
		//     			Fonctions publique				  //
		//------------------------------------------------//
		public function set vecX(valueX:Number):void
		{
			this._x = valueX;
		}
		
		public function get vecX():Number
		{
			return this._x
		}
		
		public function set vecY(valueY:Number):void
		{
			this._y = valueY;
		}
		
		public function get vecY():Number
		{
			return this._y
		}
		
		public function setVector(valueX:Number, valueY:Number):void
		{
			this._x = valueX;
			this._y = valueY;
		}
		
		public function reset():void
		{
			this._x = 0;
			this._y = 0;
		}
		
		public function getMagnitude():Number
		{
			var lengthX:Number = this._x;
			var lengthY:Number = this._y;
			
			return Math.sqrt(lengthX * lengthX +lengthY * lengthY);
		}
		
		public function getAngle():Number
		{
			var lengthX:Number = this._x;
			var lengthY:Number = this._y;
			
			return Math.atan2(lengthY, lengthX);
		}
		
		public function duplicate():Vector2D
		{
			var dup:Vector2D = new Vector2D(this._x, this._y);
			return dup;
		}
		
		public function getVectorDirection():Vector2D
		{
			var vectorDirection:Vector2D = new Vector2D(this._x / this.getMagnitude(), this._y / this.getMagnitude());
			return Vector2D(vectorDirection);
		}
		
		public function minusVector(vector2:Vector2D):void
		{
			
			this._x -= vector2.vecX;
			this._y -= vector2.vecY;
		}
		
		public function addVector(vector2:Vector2D):void
		{
			this._x += vector2.vecX;
			this._y += vector2.vecY;
		}
		
		public function multiply (scalar:Number):void
		{
			this._x *= scalar;
			this._y *= scalar;
		}
	}

}
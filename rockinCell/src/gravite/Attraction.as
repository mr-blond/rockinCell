//------------------------------------------------//
//       Classe qui genere la gravité 			  //
//------------------------------------------------//
package gravite
{
	
	import math.Math2;
	import math.Vector2D;
	
	public class Attraction
	{
		//------------------------------------------------//
		//      			 Propriété					  //
		//------------------------------------------------//
		private var _disp:Vector2D;
		private var _velo:Vector2D;
		private var _acc:Vector2D;
		private var _mass:Number;
		private const _attractive_coeff:Number = 50;
		
		
		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		
		private var _id:uint;//liaison avec l'individu
		private var _gPoint:Boolean;//si il s'agit du point vers quelle toute les celulles se dirigent
		//------------------------------------------------//
		//      			Constructeur				  //
		//------------------------------------------------//
		public function Attraction(id:uint , x:Number,y:Number,width:Number)
		{
			//affectation de valeur recuperer sur Individu
			this._x = x;
			this._y = y;
			this._width = width;
			this._id = id
			
			//initialisation des variables necessaire à la gravité
			this._disp = new Vector2D(_x, _y);
			this._velo = new Vector2D(0, 0);
			this._acc = new Vector2D(0, 0);
			this._mass = 20/*normalement radius/2*/;	
		}
		//------------------------------------------------//
		//      		Fontions privées				  //
		//------------------------------------------------//
		private function getForceAttract (m1:Number, m2:Number, vec2Center:Vector2D):Vector2D
		{
			
			//calculer la force attractive à partir de la formule suivante
			//F = K * m1 * m2 / r * r
			
			
			var numerator:Number = this._attractive_coeff * m1 * m2;
			var denominator:Number = vec2Center.getMagnitude() * vec2Center.getMagnitude();
			var forceMagnitude:Number = numerator / denominator;
			var forceDirection:Number = vec2Center.getAngle();
			
			//definir le cap
			if (forceMagnitude > 0) forceMagnitude = Math.min(forceMagnitude,5);
			
			
			var forceX:Number = forceMagnitude * Math.cos(forceDirection);
			var forceY:Number = forceMagnitude * Math.sin(forceDirection);
			var force:Vector2D = new Vector2D(forceX, forceY);
			
			return force;
		}
		//connaitre l'acceleration de a cellule
		private function getAcc(vecForce:Vector2D):Vector2D{
			
			vecForce.multiply(1 / this._mass);
			var vecAcc:Vector2D = vecForce.duplicate();
			return vecAcc;
		}
		//Definir la nouvelle position de la cellule
		private function getDispTo(ball:Attraction):Vector2D{
			
			var currentVector:Vector2D = new Vector2D(ball.x, ball.y);
			currentVector.minusVector(this._disp);
			return currentVector;
		}
		//Definir vers qui la cellule doit se diriger
		private function attractedTo(ball:Attraction) :void{
			var toCenter:Vector2D = this.getDispTo(ball);
			
			var currentForceAttract:Vector2D = this.getForceAttract(ball.mass, this._mass, toCenter);
			this._acc = this.getAcc(currentForceAttract);
			this._velo.addVector(this._acc);
			this._disp.addVector(this._velo);
		}
		
		
		//Gestion des colisions
		private function collisionInto (ball:Attraction):Boolean{
			var hit:Boolean = false;
			var minDist:Number = (ball.width + this._width) / 2;
			
			if (this.getDispTo(ball).getMagnitude() < minDist)
			{
				hit = true;
			}
			
			return hit;
		}
		//Savoir ou placer la celulle apres une colision
		private function getRepel (ball:Attraction): Vector2D{
			var minDist:Number = (ball.width + this._width) / 2 ;
			
			//calculer la distance necessaire à la separation des celulles
			var toBall:Vector2D = this.getDispTo(ball);
			var directToBall:Vector2D = toBall.getVectorDirection();
			directToBall.multiply(minDist);
			directToBall.minusVector(toBall);
			directToBall.multiply( -1);
			return directToBall;
		}
		//supprimer l'accelleration et la velocité car la cellule à été arreté par une autre cellule
		private function repelledBy(ball:Attraction):void{
			this._acc.reset();
			this._velo.reset();
			var repelDisp:Vector2D = getRepel(ball);
			this._disp.addVector(repelDisp);
		}
		// donner les nouvelles coordonées a la cellule
		private function setPosition(vecDisp:Vector2D):void{
			
			this._x  = Math.round(vecDisp.vecX);
			this._y  = Math.round(vecDisp.vecY);
		}
		//------------------------------------------------//
		//      		 Fonctions publique				  //
		//------------------------------------------------//
		//-- fonction appeler à chaque enterFrame elle utilise les fonctions privées afin de definir la nouvelle position
		public function animate(center:Attraction, all:Vector.<Attraction>):void{
			
			this.attractedTo(center);
			if (collisionInto(center))		this.repelledBy(center);
			for (var i:int = 0; i < all.length; i++)
			{
				var current_ball:Attraction = all[i];
				if (collisionInto(current_ball) && current_ball.id != this._id)		this.repelledBy(current_ball);
			}
			this.setPosition(this._disp);
			
		}
		
		
		//------------------------------------------------//
		//      			 accesseurs					  //
		//------------------------------------------------//
		//--setter
		public function set width(width:uint):void{
			this._width = width
		}
		public function set gPoint(isTrue:Boolean):void{
			this._gPoint = isTrue;
		}
		//--getter
		public function get mass():Number 
		{
			return _mass;
		}
		public function get x():Number{
			return this._x
		}
		public function get y():Number{
			return this._y
		}
		public function get width():uint{
			return this._width;
		}
		public function get id():uint{
			return this._id;
		}
		
		public function get gPoint():Boolean{
			return this._gPoint;
		}
		
	}
}
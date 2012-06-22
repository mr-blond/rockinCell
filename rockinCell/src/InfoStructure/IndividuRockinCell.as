//------------------------------------------------//
//       	Definition d'un individu avec ses 	  //
//coordonées son attraction et son masque	      //
//------------------------------------------------//
package InfoStructure
{
	import cellules.Cell;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	import common.Background;
	
	import flash.geom.Rectangle;
	
	import gravite.Attraction;
	import gravite.GestAttraction;
	
	import math.Math2;
	
	import pages.rockinCell;

	public class IndividuRockinCell extends IndividuBase
	{
		//------------------------------------------------//
		//     				 Propriété  		 		  //
		//------------------------------------------------//
		
		//Information necessaire au calcul des animations et à la disposition sur le stage
		private var _x             : Number   ;
		private var _y             : Number   ;
	    private var _attraction    : Attraction;
		//Variable utilisé pour afficher la cellule
	 	private var _cellule       :Cell;
		private var _onStage       : Boolean  ;
		private var _masque        : Rectangle;
		
		
		//------------------------------------------------//
		//       			Constructeur 				  //
		//------------------------------------------------//
		public function IndividuRockinCell(individu:XML)
		{
			//on relance le constructeur de la classe mére
			super(individu);
			this._masque        = new Rectangle(individu.masqueX ,individu.masqueY,140 ,140);
			//definir àleatoirement la position de la cellule
		
			this._x = Math2.randomiseBetween(-Background.BGWIDTH + RockInfo.NB_CELL*5,Background.BGWIDTH + RockInfo.NB_CELL*5);
			this._y = Math2.randomiseBetween(-Background.BGHEIGHT + RockInfo.NB_CELL*5,Background.BGHEIGHT + RockInfo.NB_CELL*5);
			
			// crée son attraction qui va permettre de l'annimer
			ifIsOnStage();
		}
		
		//------------------------------------------------//
		//      		Functions publiques	 			  //
		//------------------------------------------------//
		//---AFFICHAGE
		//Fonction lancé à chaque enterFrame
		public function ifIsOnStage():void{
			
			
			//donner la nouvelle position calculé par attraction à la cellule ca
			if(attraction!=null){
				this._x = _attraction.x;
				this._y = _attraction.y;
			}
				
			
			//-- savoir si la cellule est visible sur le navigateur ou non
			if( rockinCell.conteneurCell.x + _x <Background.BGWIDTH + 75 && rockinCell.conteneurCell.x +_x>-75 && _y<Background.BGHEIGHT +75 && _y >-75){
				//si la cellule est à l'interieur du navigateur
				
				if(_cellule != null){//si cell n'est pas egal à null
					//donner les valeurs détenu par individu à la cellule
					
						_cellule.x  = _x;
						_cellule.y  = _y;
						_cellule.id = _id;
						_attraction.width = _cellule.masque.width;
					
				}
				else montrerCell()//si cell n'existe pas , la creer
					
			}else if(_cellule != null) disparaitre()//si la cellule sort du navigateur, la supprimer
			
		}
		//supprime de la liste d'affichage la celulle
		public function disparaitre(anim:Boolean = false):void{
			
			if(_cellule){
				//Si anim est egale à true l'a faire apparaitre avec une animation
				//if(anim == true) this._cellule.disparaitre();
				/*else*/
				_cellule.supprimerCell();
				_cellule.vider();
				_cellule= null;
				
				trace('cellule destroyed');
				//supprimer la gravité lié à la cellule
				_attraction = null;
			}
			
		}
		//ajoute à la liste d'affichage la celulle
		public function montrerCell(anim:Boolean = false,radiusCell:uint=50):void{
			//crée une nouvelle celulle
			_cellule = new Cell(this,Math.random()*25 +40); 
			this._attraction = GestAttraction.getInstance().creerAttraction(this._id,this._x,this._y);
			
			//Si le param est à true l'ajouter avec une animation
			if(anim == true) this._cellule.apparaitre();
			else {
				rockinCell.conteneurCell.addChild(_cellule);//Sinon l'ajouter directement à la liste d'affichage
				//recré la gravité lié a cette celulle
				
			}
		}
		

		
		
		
		//----------------ACCESSEURS-------------------
		//getter necessaire lors de l'affichage de la fiche
		
		public function get masque():Rectangle{
			return this ._masque;
		}
		public function get x():int{
			return this._x;
		}
		public function get y():int{
			return this._y;
		}
		public function get cell():Cell{
			return this._cellule;
		}
		
		public function get attraction():Attraction{
			return this._attraction;
		}
		
		//Setter necessaire au mouvement des cellules
		public function set x(x:int):void{
			this._x = x;
		}
		public function set y(y:int):void{
			this._y = y; 
		}
		
		public function viderAttraction():void{
			this._attraction = null;
		}
	}
}
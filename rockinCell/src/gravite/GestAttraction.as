//------------------------------------------------//
//       Classe qui gere les instances 			  //
//		 de attraction et anime les cellules	  //
//------------------------------------------------//

package gravite
{
	

	
	import math.Math2;
	
	public class GestAttraction
	{
		//------------------------------------------------//
		//     				Propriétés					  //
		//------------------------------------------------//
		static private var instance:GestAttraction; //instance de la classe
		static private var _gPoint:Attraction;//defini l'instance d'attraction cible pour la gravité
		static public  var _attractions:Vector.<Attraction>;// tableau qui contient toute les instances trié
		static public  var _attractionComplete:Vector.<Attraction>;
		
		//------------------------------------------------//
		//       	       CONSTRUCTEUR     			  //
		//------------------------------------------------//
		public function GestAttraction()
		{
			//création du tableau
			_attractions = new Vector.<Attraction>;
		}
		
		//------------------------------------------------//
		//       	     Methode publique     			  //
		//------------------------------------------------//
		//--demande d'instance d'une classe,
		static public function getInstance():GestAttraction{
			if(GestAttraction.instance == null){//si elle n'existe pas, il faut la créer
				GestAttraction.instance = new GestAttraction();
			}//si elle existe deja retourner l'instance
			return GestAttraction.instance;
		}
		
	
		//--methode qui permet l'animation des cellules
		public function animerCell():void{
				
				if(_gPoint == null){//si aucun point de gravité , lui en  assigner celui par defaut
					_gPoint = _attractions[0];
					_gPoint.gPoint = true;
				}
				// demandé a animer toute les cellules vers le point de gravité
				for(var i:uint = 0 ;i< _attractions.length ; i++){
					if(_attractions[i].gPoint == false) _attractions[i].animate(_gPoint,_attractions);
				}
			
			 
		}
			//--methode apelé par individu pour créer son instance de attraction (quand elle apparait à l'ecran)
		public function creerAttraction(id:uint , x:Number,y:Number):Attraction{
			
				var currentAttraction:Attraction = new Attraction(id,x,y,50);
				_attractions.push(currentAttraction);
				
				return currentAttraction;
			
		}
			// methode appelé par individu pour supprimer son attraction (quand elle sort de l'ecran)
		public function supprimerAttraction (index:uint):void{
		
			_attractions.splice(index,1);
			
		}
		//------------------------------------------------//
		//       	     	ACCESSEURS     				  //
		//------------------------------------------------//
		public function set gPoint(gPoint:Attraction):void{
			_gPoint.gPoint = false;
			gPoint.gPoint = true;
			GestAttraction._gPoint = gPoint;
			
		}
		
		public function viderAttraction():void{
			_attractions.splice(0,_attractions.length);
		}
	}
	
}
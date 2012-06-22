//------------------------------------------------//
//       Classe qui gere les instance de		  //
//			  Individu							  //
//------------------------------------------------//
package InfoStructure
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import gravite.GestAttraction;
	
	

	
	public class DataStructure extends EventDispatcher
	{	
		//------------------------------------------------//
		//     				Propriétés					  //
		//------------------------------------------------//
		
		//tableau qui contient les tout les utilisateurs trié
		static public var _individus:Vector.<IndividuRockinCell>;
		//variable necessaire au chargement du xml
		private var _chargeurXML:URLLoader;
		private var _data:XML;
		//Instance de DataStructure (singleton)
		private static var instance:DataStructure;
	
		//------------------------------------------------//
		//     				SINGLETON					  //
		//------------------------------------------------//
		public static function getInstance():DataStructure{
			if(DataStructure.instance == null){
				DataStructure.instance = new DataStructure();
			}
			return DataStructure.instance;
		}
		//------------------------------------------------//
		//     			Fonctions publiques				  //
		//------------------------------------------------//
		public function chargerFichier(fichier:String):void{
			//mettre à zero le dataStructure
			
			trace('fichier demandé + '  +fichier);
			//--Chargement du XML
			_chargeurXML = new URLLoader;
			//listener qui ecoute quand le XML est chargé
			_chargeurXML.addEventListener(Event.COMPLETE, _chargementComplete);
			
			_chargeurXML.load(new URLRequest(fichier));
		}
		
		// demande a verifier si les cellules sont afficher
		public function gravite():void{
			
			for(var i:uint = 0 ; i< _individus.length ; i++){
				
				_individus[i].ifIsOnStage();
				
			}
			GestAttraction.getInstance().animerCell();
		}
	
		

	
		//------------------------------------------------//
		//     			Fonctions privées				  //
		//------------------------------------------------//
		
		//--fonction lancée à la fin du chargemen. Elle crée les individus
		//pour ensuite les mettre dans un tableau
		private function _chargementComplete(e:Event):void{
			//mettre à zero le dataStructure
			_chargeurXML.removeEventListener(Event.COMPLETE, _chargementComplete);
			this._data = new XML(e.target.data);
			remplirIndividu(_data);
			this._data = null;
			
			
		
			
		}
		//--a partir du xml crée les individus et les placer dans un vector
		public function remplirIndividu(xml:XML):void{
			//mettre à zero le dataStructure
			_data = xml;
			_individus = new Vector.<IndividuRockinCell>;
			RockInfo.NB_CELL =  _data.individu.length();
			for(var i:uint = 0 ; i< RockInfo.NB_CELL ; i++){
				var currentIndividu:IndividuRockinCell = new IndividuRockinCell(_data.individu[i]);
				_individus.push(currentIndividu);
			}
			
			// avertir la fin du chargement des cellules
			dispatchEvent(new Event(RockEvent.INDIVIDU_CREE));
		}
		public function enleverCellules():void{
			
			for(var i:uint = 0 ; i<_individus.length ; i++){
				_individus[i].disparaitre();
			}
			dispatchEvent(new Event('destructed'));
			GestAttraction.getInstance().viderAttraction();
			supprimerIndividu();
		}
		
		private function supprimerIndividu():void
		{
			_individus.splice(0,_individus.length);
		}	
		
		
	}
}
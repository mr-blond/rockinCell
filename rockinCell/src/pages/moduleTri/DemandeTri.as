//------------------------------------------------//
//     	demande de xml à partir de critére au	  //
//		serveur									  //
//------------------------------------------------//
package pages.moduleTri
{
	import flash.net.URLVariables;
	
	import formulaires.Formulaire;

	public class DemandeTri extends Formulaire
	{
		//------------------------------------------------//
		//       		     CONSTRUCTEUR				  //
		//------------------------------------------------//
		public function DemandeTri()
		{
			//realise les opération du constructeur de la classe mére
			super();
		}
		//------------------------------------------------//
		//     			Fonctions publiques				  //
		//------------------------------------------------//
		//--envois d'une requete
		public function request(info:Object,destination:String):void{
			//objet qui contient les variables qui vont etre interpreté par le php
			var variables:URLVariables = new URLVariables();
				variables.active = true;
				//recuperé dans l'objet info les critéres selectionné
				//et les ajouté à variables
				for(var i : uint; i < info.length ; i++){
					if(info[i].type == 'sexe' )		variables.sexe  = String(info[i].data);
					
					if(info[i].type == 'camping' )	variables.place = info[i].data;
					
					if(info[i].type == 'age' )		variables.age = info[i].data;
					
					if(info[i].type == 'musique' )	variables.musique = info[i].data;
					
				}
				
				//Envois au formulaire au serveur
				this.PHPrequest(variables,RockInfo.SERVEUR_URL+"leave/tri.php");
			
		}
		//--si aucun critére n'est selectionné, dans une autre page qui ne tri pas le xml
		// (eviter les problémes de caches)
		public function allXml():void{
			
			var variables:URLVariables = new URLVariables();
			variables.active = true;
			//demande de la totalité du xml
			this.PHPrequest(variables,RockInfo.SERVEUR_URL+"testXML.php");
		}
	}
}
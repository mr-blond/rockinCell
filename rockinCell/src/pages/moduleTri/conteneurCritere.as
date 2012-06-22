//------------------------------------------------//
//     	Objet qui permet le transit des 		  //
//		informations necessaires au tri			  //
//------------------------------------------------//
package pages.moduleTri
{
	
	public class conteneurCritere
	{
		private var _criteres:Vector.<Object>;
		//------------------------------------------------//
		//     				Constructeur				  //
		//------------------------------------------------//
		public function conteneurCritere()
		{	//Création d'un tableau qui contion tout les critéres selectionné par l'utilisateur
			_criteres = new Vector.<Object>;
		}
		//------------------------------------------------//
		//     			Fonctions publique				  //
		//------------------------------------------------//
		//ajout danss le tableau d'un critére seectionné
		public function ajouterCritere(nom:String,valeur:String,data:Array):void{
			var critere:Object = {
				type : nom,
				valeur : valeur,
				data : data
			};
			_criteres.push(critere);
		}
		//supprimer un critére du tableau
		public function supprimerCritere(nom:String):void{
			for(var i:uint = 0 ; i<_criteres.length ; i++){
				if(_criteres[i].type == nom){
					_criteres.splice(i,1);
					return;
				}
			}
		}
		//------------------------------------------------//
		//     				ACCESSEUR					  //
		//------------------------------------------------//
		public function get criteres():Vector.<Object>{
			return this._criteres;
		}
		
	}
}
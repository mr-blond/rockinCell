//------------------------------------------------//
//       Créaton du module de tri et de ses 	  //
//		 critéres								  //
//------------------------------------------------//
package pages.moduleTri 
{
	import InfoStructure.DataStructure;
	
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	
	import formulaires.FormulaireEvent;
	
	import gravite.GestAttraction;

	public class ModuleTri extends Sprite
	{
		//------------------------------------------------//
		//     				Propriétés					  //
		//------------------------------------------------//
		public var centre:MovieClip;
		
		private var _XML:XML;//dans l'idéal les critére serat present dans un XML editable par un administrateur
		private var _chargeur:URLLoader;
		
		
		private var _objetTri:conteneurCritere;
		private var _criteres:Vector.<Object>;
		
		
		//------------------------------------------------//
		//       	     Constructeur					  //
		//------------------------------------------------//
		public function ModuleTri()
		{
			//Tabeau qui contient tout les critéres
			_criteres = new Vector.<Object>();
			
			var age:Object = {
				name : 'age',
				label : ["< 18","16-18","18-20","20-25","25-30","30 <"],
 				data : ["0-18","16-18","18-20","20-25","25-30","30-100"]
			};
			_criteres.push(age);
			var musiquePref:Object = {
				name : 'musique',
				label : ["rock","rock alternatif","electro","raggae","house","métal","rap"],
				data : ["rock","rock alternatif","electro","raggae","house","métal","rap"]
			};
			_criteres.push(musiquePref);
			//Création d'un critére
			var genre:Object = {
				name : 'sexe',
				label : ['garcon','fille'],
				data : ['male','female']
			};
			//Ajout du critére dans le tableau
			_criteres.push(genre);
			//création de toute les valeurs possibles pour les place de camping
			var place:Array = new Array();
			for(var j:uint = 0; j<25 ; j++){
				place.push(String (j));
			};
			//création du critére pour la place de camping
			var camping : Object = {
				name : 'camping',
				label : place,
				data : place
			}
				//Ajout dans le tableau du critére
			_criteres.push(camping);
			
			
			//demander au cercle de se mettre à son statut initial
			centre.gotoAndStop(0);
			//objet qui va contenir les critére de tri
			_objetTri = new conteneurCritere();
			
			
			//Quand la sourie survol le modul
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver)
		}
		//------------------------------------------------//
		//     			Fonctions publique				  //
		//------------------------------------------------//
		public function remiseAZero():void{
			//_objetTri = null;
			for(var i:uint=0 ; i<_criteres.length ; i++){
				var currentDisplayObject:DisplayObject = getChildAt(i) ;
				if (currentDisplayObject is Critere){
					var currentCritere:Critere = currentDisplayObject as Critere;
					currentCritere.x = currentCritere.xInit;
					currentCritere.y = currentCritere.yInit;
				}
				
			}
		}
		//------------------------------------------------//
		//     			Fonctions privées				  //
		//------------------------------------------------//
		//animation à réalisé lorsque la sourie survol le modul
		private function onMouseOver(e:MouseEvent) : void {
			this.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver)
			centre.gotoAndStop(6);
			creationCriteres(_criteres);
			
		}
		private function genererTableau(min:int,max:int):Array{
			var array:Array = new Array();
			for(var j:uint = min; j<25 ; j++){
				array.push(String (j));
			}
			return array;
		}
		private function creationCriteres(criteres:Vector.<Object>) : void {
			
			var angle:Number=360/criteres.length;
			
			var rayon:uint = (centre.width / 3) * 2 + 15;//30 fait reference à la moitié de la taille d'un critere, 
			//rayon calculé une fois ici et non pas chaque fois qu'il y a un nouveau critére
			var rayonMini:uint = 35;
			var lesCriteres:Array = new Array();
			var i:uint = 0;
			for(var b:uint = 0; b<360 ;b += angle){
				//Variables qui vont definir la position des critéres
				var posX:Number;
				var posY:Number;
				//Variables qui vont definir la position des critéres une fois selectionné
				var posXmini:Number;
				var posYmini:Number;
				//Crée les critéres à partir des éléments present dans le tableau criteres
				
				var critere:Critere = new Critere(criteres[i]);
				critere.buttonMode = true;
				//trouver les positions des cercles de sorte a ce qu'ils entourent _cercleCentre
				
					//position initial
				posX = rayon * Math.cos(b * Math.PI / 180);
				posY = rayon * Math.sin(b * Math.PI / 180);
					//donner au critére sa position initial
				critere.yInit = posY;
				critere.xInit = posX;
					//position lorsque la valeur du tri à été choisi
				posXmini = rayonMini * Math.cos(b * Math.PI / 180);
				posYmini =  rayonMini * Math.sin(b * Math.PI / 180);
					//sa postion quand il est à l'interieur du cercle
				critere.yInitMini = posYmini;
				critere.xInitMini = posXmini;
				//listener
				critere.addEventListener(MouseEvent.MOUSE_UP, isInCircle);
				critere.addEventListener('selectionDone', onSelectionDone);
				
					//mettre le critére à sa place
				critere.x = posX;
				critere.y = posY
					//afficher le critére
				lesCriteres.push(critere);
				addChild(critere);
					//incrementer pour avoir le prochain élement du tableau
				i++;
			}
			TweenMax.allFrom(lesCriteres,1,{x:0,y:0},0.4);
			
		}
		//Quand une valeur est ajouté dans le cercle
		private function onSelectionDone(e:Event) : void {
			
			var currentCritere:Critere = e.currentTarget as Critere;
			var nom:String = currentCritere.nom;
			var valeur:String = currentCritere.selection;
			var data:Array = currentCritere.data;
			
			_objetTri.ajouterCritere(nom,valeur,data);
			envoiRequete()
		}
		//---------demande de tri au serveur
	  	private function envoiRequete():void{
			DataStructure.getInstance().enleverCellules();
			GestAttraction.getInstance().viderAttraction();
			var demandeTri:DemandeTri = new DemandeTri();
			demandeTri.addEventListener(FormulaireEvent.FIN_REQUETE,newData);
			//verifier qu'il y a des informations à envoyer
			if(_objetTri.criteres.length!=0) demandeTri.request(_objetTri.criteres,RockInfo.SERVEUR_URL+"leave/tri.php");
			else demandeTri.allXml();
			
		}
		//-----vider et ajouter les celulles crées a partir du nouveau xml qui contient les individus trié
		private function newData(e:Event):void{
			
			var dataStructure:DataStructure = DataStructure.getInstance();
			
			trace('TARTE');
			dataStructure.remplirIndividu(e.currentTarget.infoRequest);
		}
		//------Savoir un critére à été deposé dans le receptacle ou si il en est sorti
		private function isInCircle(e:MouseEvent) : void {
			var currentCritere:Critere = e.currentTarget as Critere;
			//si il est deposé à l'interieur
			if(centre.hitTestObject(currentCritere)){
				
				centre.gotoAndStop(14);
				//afficher la liste du critére
				currentCritere.afficherListe();
				//positionner correctement le critére dans le cercle du centre
				if(currentCritere.selection != null) currentCritere.retourInitMini();
			}else{
				//si on sort le critére du receptacle
				//remettre le critére à sa place initial
				currentCritere.retourInitial();
				//enlever la liste de valeur possible
				currentCritere.cacherList();
				
				if(currentCritere.selection != null){
					_objetTri.supprimerCritere(currentCritere.nom);
				}
				//demander a refaire le fichier xl en ajoutantles individu ancienement concerné par le critére
				envoiRequete()
			}
		}

	
		
		//------------------------------------------------//
		//     				ACCESSEUR					  //
		//------------------------------------------------//
		public function get selection():conteneurCritere{
			return this._objetTri;
		}
		
		
		
	}
}

package formulaires.part
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.facebook.graph.Facebook;
	import com.greensock.TweenLite;
	
	import common.FicheCentre;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.sampler.NewObjectSample;
	
	import formulaires.FormulaireEvent;
	
	import images.PhotoBig;
	import images.Vignette;
	
	public class FichePhoto extends FicheCentre
	{
		public var boiteVignette:BoiteVignette;
		
		public var photo:Sprite;
		public var btnCreate:Sprite;
		
		private var _photoBig:PhotoBig;
		private var _photoUrl:String;
		private var _masqueX:uint;
		private var _masqueY:uint;
		
		public function FichePhoto()
		{
			super();
			btnCreate.addEventListener(MouseEvent.CLICK,_onBtnClick);
			var fql:String = "select aid from album where owner = me() AND name = 'Profile Pictures'";
			//je lance la fonction et une fois la requete terminé je lance reponseAid
			Facebook.fqlQuery(fql,reponseAid);
			
			

			boiteVignette.addEventListener(MouseEvent.CLICK,afficherBigPhoto);
		}
		//--recuperation de toute les photos de l'utilisateur
		// reponse et fail son fournie par fqlQuery


		protected function  reponseAid(reponse:Object, fail:Object):void{
			//si il y a une une reponse
			if (reponse != null)
				var aid:Number = reponse[0].aid;
			//je selectionne uniquement les photos de profile spécifique à lutilisateur
			var fql:String =  "select images, src_small, src_big from photo where aid = '"+reponse[0].aid+"'";
			//je demande l'album photo
			Facebook.fqlQuery(fql,chercherAlbum);
		}
		//---affichage des photos recupéré sur facebook
		// reponse et fail sont fourni par fqlQuery
		private function chercherAlbum(reponse:Object,fail:Object):void{
			
			
			//je recupére les informations et je les met dans un tableau
			var photoArray:Array =  reponse as Array;
			var colonne:uint = 0;// savoir ou placer l'image
			for(var i:uint=0;i < photoArray.length ; i++){
				//verrifier que la photo recuperer est pas trop grande ni trop petite
				var photo = photoArray[i].images[3]; // un et trois precise les tailles des fauto reclamé (voir fb api)
				var photoMiniature = photoArray[i].images[7];
				
					//crée une vignette cliquable et l'afficher
					var currentVignette:Vignette = new Vignette(photo.source);
					//donner à l'instance de vignette l'image qu'elle doit afficher
					currentVignette.affiche(photoMiniature.source);
					currentVignette.x = colonne*75;//placer correctement la vignette
					boiteVignette.photoEmplacement.addChild(currentVignette);//afficher la vignette
					colonne++;// incrementer pour demaander a mettre la prochaine photo à coté
				
				
			}
			
		}
		//---afficher une plus grosse photo apres la selection de la vignette
		private function afficherBigPhoto(e:MouseEvent):void{
			if(e.target is Vignette){//verifier que la cible est une vignette
				//recuperer la vignette
				var currentVignette:Vignette = e.target as Vignette;
				if(photo.numChildren!=0){//si une instance est deja existante l'a supprimer
				   photo.removeChildAt(0);
				}
				// sinon crée une nouvelle instance et l'afficher
				_photoBig = new PhotoBig();
				_photoBig.affiche(currentVignette.url); 
			     photo.addChild(_photoBig);
				
			}
			
		}
		
		
		private function _onBtnClick(e:MouseEvent):void{
			this._photoUrl= _photoBig.url;
			this._masqueX = _photoBig.masqueX ;
			this._masqueY = _photoBig.masqueY ;
			dispatchEvent(new Event(FormulaireEvent.FIN_SELECT_PHOTO));
		}
		
		public function get photoUrl():String
		{
			return _photoUrl;
		}
		
		public function get masqueX():uint
		{
			return _masqueX;
		}
		
		public function get masqueY():uint
		{
			return _masqueY;
		}
	}
	
	
}
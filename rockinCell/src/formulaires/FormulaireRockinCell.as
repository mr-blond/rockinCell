package formulaires
{
	import InfoStructure.IndividuBase;
	import InfoStructure.OutilUtilisateur;
	
	import com.facebook.graph.Facebook;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLVariables;
	
	import formulaires.Formulaire;
	import formulaires.part.Connect;
	import formulaires.part.FicheInfo;
	import formulaires.part.FichePhoto;
	import formulaires.part.FinFormulaire;
	import formulaires.part.PhotoQuestion;

	public class FormulaireRockinCell extends Formulaire
	{
		public var connect:Connect;
		public var ficheInfo:FicheInfo;
		
		private var _partieDemande:String;
		private var _isOnModif : Boolean;
		private var _outilUtilisateur:OutilUtilisateur = OutilUtilisateur.getInstance();
		private var _currentUtilisateur :IndividuBase;
		
		//etapes du formulaires
		protected var _ficheInfo     : FicheInfo;
		protected var _photoQuestion : PhotoQuestion;
		protected var _fichePhoto 	 : FichePhoto;
		protected var _finFormulaire : FinFormulaire;
		public function FormulaireRockinCell()
		{
			_listeners();
		}
		public function inscription():void{
			_isOnModif = false;
			//recuperer les infos via facebook	
			_outilUtilisateur.addEventListener(RockEvent.CREATION_INDIVIDU_FB,_onIndividuFBCree);
			_outilUtilisateur.creerIndividu();
		}
		
		private function _onIndividuFBCree(event:Event):void
		{
			this._currentUtilisateur = _outilUtilisateur.individu;
			etapeInfo();
		}
		public function modification():void{
		
			_isOnModif = true;
			if(_outilUtilisateur.individu){
				_currentUtilisateur = _outilUtilisateur.individu;
			}
			etapeInfo();
		}

		
		private function _listeners():void
		{
		}
		
		private function _handleFBLoginClick(event:Event):void
		{
			trace('------------------clicksurFB')
			OutilUtilisateur.getInstance().connectFacebook();
		}
		public function etapeInfo():void{
			_ficheInfo = new FicheInfo();
			_ficheInfo.addEventListener(FormulaireEvent.FIN_INFO,_recupInfo);
			addChild(_ficheInfo);
			_ficheInfo.shown();
		}
		//recupération des infos du formulaire
		private function _recupInfo(e:Event):void{
			_currentUtilisateur.pseudo 			= _ficheInfo.pseudo;
			_currentUtilisateur.description		= _ficheInfo.description;
			_currentUtilisateur.musiquePref		= _ficheInfo.musique;
			//_currentUtilisateur.artiste 		= _ficheInfo.artiste;
			_currentUtilisateur.genrePref		= _ficheInfo.genrePref;
			if(!_ficheInfo.isOkForFB){
				_currentUtilisateur.lienFB ='';
			}else{
				var outilUtilisateur:OutilUtilisateur = OutilUtilisateur.getInstance();
				_currentUtilisateur.lienFB = outilUtilisateur.infoFB.link;
			}
//			trace('---------------resultat du formulaire :  ' + this._pseudo); 
//			trace('---------------resultat du formulaire :  ' + this._description); 
//			trace('---------------resultat du formulaire :  ' + this._musiquePrefere); 
//			trace('---------------resultat du formulaire :  ' + this._artiste); 
//			trace('---------------resultat du formulaire :  ' + this._genrePref); 
//			trace('---------------resultat du formulaire :  ' + _ficheInfo.isOkForFB); 
			//MonsterDebugger.inspect(_ficheInfo);
			
			//enlever de la liste d'affichage cette etape
			_ficheInfo.hide();
			trace("fiche info is on stage ? : " + _ficheInfo);
			_ficheInfo = null;
			//créer et afficher la nouvelle etape
			if(_isOnModif){
				_launchPhotoQuestion();
			}else{
				_choisirPhoto();
			}
			
		}
		//demander à l'utilisateur si il veut ou non conserver sa photo
		private function _launchPhotoQuestion():void{
			//affichage du formulaire
			_photoQuestion = new PhotoQuestion();
			//montrer la photo actuel
			_photoQuestion.activer(_currentUtilisateur.urlPhoto,_currentUtilisateur.masqueX,_currentUtilisateur.masqueY);
			addChild(_photoQuestion);
			//animation
			_photoQuestion.shown();
			//ecouteurs
			_photoQuestion.addEventListener(FormulaireEvent.CHANGE_PHOTO,_onChangePhoto);
			_photoQuestion.addEventListener(FormulaireEvent.NO_CHANGE_PHOTO,_onNotChangePhoto);	
		}
		
		//---------fonctions liés à launchPhotoQuestion
		private function _onChangePhoto(e:Event):void{
			
			_choisirPhoto();	
		}
		private function _onNotChangePhoto(e:Event):void{
			_onFinFormulaire();
		}
		//--------Choix d'une photo
		private function _choisirPhoto():void{
			if(_photoQuestion){
				_photoQuestion.hide();
				_photoQuestion = null;
			}
			_fichePhoto = new FichePhoto();
			_fichePhoto.addEventListener(FormulaireEvent.FIN_SELECT_PHOTO,_onFinPhoto);
			addChild(_fichePhoto);
			_fichePhoto.shown();
		}
		
		private function _onFinPhoto(event:Event):void
		{
			_currentUtilisateur.urlPhoto = _fichePhoto.photoUrl;
			_currentUtilisateur.masqueX = _fichePhoto.masqueX;
			_currentUtilisateur.masqueY = _fichePhoto.masqueY;
			if(_fichePhoto.stage){
				_fichePhoto.hide();
				_fichePhoto = null;
			}
			_onFinFormulaire();
		}
		
		private function _onFinFormulaire():void{
			//enlever l'instance precedente de la liste d'affichage
			if(_photoQuestion){
				_photoQuestion.hide();
				_photoQuestion = null;
			}
			
			//envoyer les infos au serveurs
		
			
			_envoisBDD()
			//afficher un message qui confirme l'envois au serveur des infos
			_finFormulaire = new FinFormulaire();
			addChild(_finFormulaire);
			_finFormulaire.addEventListener(FormulaireEvent.ETAPE_COMFIRMATION_FIN,_quitterForm);
			_finFormulaire.shown();
		}
		private function _envoisBDD():void{
			var variables:URLVariables = new URLVariables();
			
			variables.submit = true;
			variables.id           = _currentUtilisateur.id;
			//***
			variables.anniv        = _currentUtilisateur.anniv;
			variables.mail         = _currentUtilisateur.mail;
			variables.lienFB       = _currentUtilisateur.lienFB;
			//***
			variables.pseudo       = _currentUtilisateur.pseudo;
			variables.description  = _currentUtilisateur.description;		
			variables.placeCamping = _currentUtilisateur.placeCamping;
			variables.musiquePref  = _currentUtilisateur.musiquePref;
			//***
			variables.photoUrl     = _currentUtilisateur.urlPhoto;
			variables.masqueX      = _currentUtilisateur.masqueX;
			variables.masqueY      = _currentUtilisateur.masqueY;
			variables.genrePref    = _currentUtilisateur.genrePref;
			//*********************
			variables.prenom 	   = _currentUtilisateur.prenom;
			variables.nom          = _currentUtilisateur.nom;
			variables.sexe         = _currentUtilisateur.sexe;
			variables.pays         = _currentUtilisateur.pays;
				
			//envois à la base de donnée des informations
			if(_isOnModif)this.exportBDD(variables,RockInfo.SERVEUR_URL+"leave/modification.php");
			else this.exportBDD(variables,RockInfo.SERVEUR_URL+"leave/inscription.php");
		}
		
		public function _quitterForm(e:Event):void{
			_finFormulaire.hide();
			_finFormulaire = null;
			dispatchEvent(new Event(FormulaireEvent.FIN_FORMULAIRE));
		}
		
	
	}
}
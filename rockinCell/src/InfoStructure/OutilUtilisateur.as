package InfoStructure
{
	import com.facebook.graph.Facebook;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	

	public class OutilUtilisateur extends EventDispatcher
	{
		static private var instance:OutilUtilisateur; //instance de la classe
		private var _utilisateurExiste:Boolean;
		
		private var _utilisateur:IndividuBase;
		private var _infoFB:Object;
		
		public function OutilUtilisateur()
		{
		}
		
		//--demande d'instance d'une classe,

	

		static public function getInstance():OutilUtilisateur{
			if(OutilUtilisateur.instance == null){//si elle n'existe pas, il faut la créer
				OutilUtilisateur.instance = new OutilUtilisateur();
			}//si elle existe deja retourner l'instance
			return OutilUtilisateur.instance;
		}
		
		//-----------------------------FACEBOOK
		public function connectFacebook():void{
			Facebook.init(RockInfo.ID_APP);	//se connecter via un facebook connect
			Facebook.login(_handleFBLogin,{scope:'user_photos,user_birthday,email'});
		}
		private function _handleFBLogin(session:Object, fail:Object):void {
			if (session != null) {
				trace('----------------------handlelogin')
				
				
				Facebook.api("/me",_recupInfoFB);	 // recuperer les infos sur le profil de l'utilisateur
			}else{
				//TODO gérer l'affichage en cas d'erreur
			}
		}
		private function _recupInfoFB(result:Object,fail:Object):void
		{
			trace('--------------------------recupInfo');
			_infoFB = result;

			dispatchEvent(new Event(RockEvent.FB_INFO_READY));
		}
		
		//---------------------------appli
		//savoir si l'utilisateur est déja inscrit
		public function existe(id:uint):void{
			//------Création d'un objet URLVariables qui contient les variables à envoyé
			var variables:URLVariables = new URLVariables();
			variables.id            = id;
			//------Création de l'objet URLRequest
			
			var requete:URLRequest = new URLRequest(RockInfo.SERVEUR_URL+'leave/existe.php');
			requete.method = URLRequestMethod.POST;//lui demander de l'envoyer via la methode POST (et non pas GET)
			requete.data = variables;
			
			var url:URLLoader = new URLLoader();
			//listener
			url.addEventListener(Event.COMPLETE,onRequestComplete);
			//url.addEventListener(IOErrorEvent.IO_ERROR,onError);
			url.load(requete); 
			
		}
		//-- un fois la requette terminé
		private function onRequestComplete(e:Event):void{
			// si l'on recoit des information
			if(e.currentTarget.data != ''){
				// l'utilisateur existe
				_utilisateurExiste = true;
				//on recupére ses informations
				var xml:XML = XML(e.currentTarget.data)
				//on crée un individu
				_utilisateur = new IndividuBase(xml.individu[0]);
				
				
			}else _utilisateurExiste = false; // sinon l'individu n'existe pas
			//prevenir que la fonction est réalisé
			dispatchEvent(new Event (RockEvent.RECHERCHE_UTILISATEUR_OVER));
			
		}
		public function creerIndividu():void{
			this.connectFacebook();
			this.addEventListener(RockEvent.FB_INFO_READY,_finishIndividu);
		}
		
		protected function _finishIndividu(event:Event):void
		{
			_utilisateur = new IndividuBase();
			_utilisateur.id = _infoFB.id;
			_utilisateur.sexe = _infoFB.gender;
			_utilisateur.prenom = _infoFB.first_name;
			_utilisateur.nom = _infoFB.last_name;
			_utilisateur.pays = _infoFB.locale;
			_utilisateur.adresseMail = _infoFB.email;
			_utilisateur.dateNaissance = _infoFB.birthday;
			dispatchEvent(new Event(RockEvent.CREATION_INDIVIDU_FB));
		}
		//------------------------------------------------//
		//     				Accesseur					  //
		//------------------------------------------------//
		public function get utilisateurExiste():Boolean{
			return this._utilisateurExiste;
		}
		public function get individu():IndividuBase{
			return this._utilisateur;
		}
		public function get infoFB():Object
		{
			return _infoFB;
		}
	}
}
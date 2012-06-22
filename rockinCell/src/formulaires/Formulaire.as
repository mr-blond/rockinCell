//------------------------------------------------//
//     	Classe mére de tous les formulaires		  //
//------------------------------------------------//
package formulaires
{
	
	
	//import fl.core.UIComponent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	
	
	public class Formulaire  extends MovieClip
	{
		//------------------------------------------------//
		//     				Proprieté					  //
		//------------------------------------------------//
		protected var caractereLeft:uint;//caractére restant dans un champ texte
		protected var _infoRequest:XML;//contient les infomation recupéré sur le serveur
		//protected var _btnQuitter:Quitter;
		//------------------------------------------------//
		//     				Constructeur				  //
		//------------------------------------------------//
		public function Formulaire()
		{
			
			
		}
		//------------------------------------------------//
		//     			Fonctions protected				  //
		//------------------------------------------------//
		
		//---Quand l'utilisateur ecrit dans un textField
		//affichage du nombre de caractére restant
		// si il depasse ce nombre afficher le text en rouge
		protected function onInput(event:KeyboardEvent):uint{
			//recupéré le textField cible
			var currentTextField:TextField = event.target as TextField;
			//si le nombre de caractere restant est egale à zero, afficher le texte en rouge
			if(this.caractereLeft <=0 ) currentTextField.textColor = 0x000000;	
			//sinon couleur normal
			else currentTextField.textColor =0xff0000; 
			//la fonction retoune le nombre de caractere restant
			return currentTextField.maxChars - currentTextField.length;
			
		}
		//--------------verification    

		
		//---verification de la chaine de caractére
		protected function validerString(string:String):Boolean{
			var bool:Boolean;
			var pattern:RegExp = /<\/?\w+((\s+(\w|\w[\w-]*\w)(\s*=\s*(?:\".*?\"|'.*?'|[^'\">\s]+))?)+\s*|\s*)\/?>/gi;
			string = string.replace(pattern, "");
			var pattern2:RegExp = /[a-zA-Z0-9]/g;
			if(string.search(pattern2) == -1)	bool = false;
			else bool = true;
			return bool;
		}
		//---Verifier qu'il s'agit d'un mail
		protected function validateEmail(string:String):Boolean{
			var pattern:RegExp = /[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/g;
			if(pattern.exec(string) != null) return true;
			else return false;

		}
		//---quand on clique su le textField, enlever le texte par defaut
		protected function supprimerIndication(e:MouseEvent):void{
			e.currentTarget.removeEventListener(MouseEvent.CLICK,supprimerIndication);
			e.currentTarget.text = '';
		}
	
		
		//---fonction qui permet d'envoyer des informations au serveur dans le but de recevoir un xml
		// destination : adresse du serveur
		// info 	   : object urlvariable qui contient les infos à envoyer
		protected function PHPrequest(info:URLVariables,destination:String):void{
			//------Création de l'objet URLRequest
			var requete:URLRequest = new URLRequest(destination);
			
			//lui demandé de l'envois via la methode POST (ne pas utiliser l'URL)
			requete.method = URLRequestMethod.POST;
			requete.data = info;
			
			var url:URLLoader = new URLLoader();
			//listener
			url.addEventListener(Event.COMPLETE,onPHPComplete ,false, 0, true);
			url.addEventListener(IOErrorEvent.IO_ERROR,_onError,false, 0, true);
			url.load(requete); 
			
			
		}
		//-----Prevenir que le formulaire est terminé et recuperer les information
		protected function onPHPComplete(e:Event = null):void{
			//les informations sont recuperées
			_infoRequest = XML(e.target.data);
			//prevenir que la requéte est terminé
			this.dispatchEvent(new Event(FormulaireEvent.FIN_REQUETE));
			
		}
		//-----envois formulaire 
		
		//---fonction qui permet d'envoyer des informations au serveur 
		// dans le but de les mettre dans une base de données
		// destination : adresse du serveur
		// info 	   : object urlvariable qui contient les infos à envoyer
		protected function exportBDD(info:URLVariables,destination:String):void{
			
			//Création de l'objet URLRequest
			var requete:URLRequest = new URLRequest(destination);
			//lui demander de l'envoyer via la methode POST (et non pas GET)
			requete.method = URLRequestMethod.POST;
			requete.data = info;
			
			//créer un url loader qui va permetre de passer l'objet au serveur
			var url:URLLoader = new URLLoader();
			
			//--listener
			//quand il est terminé
			url.addEventListener(Event.COMPLETE,_onComplete, false, 0, true);
			//en cas d'erreur
			url.addEventListener(IOErrorEvent.IO_ERROR,_onError, false, 0, true);
			
			url.load(requete); // envois des données
			
		}
		//---Prevenir que le formulaire est envoyé
		private function _onComplete(e:Event = null):void{
			
			this.dispatchEvent(new Event(FormulaireEvent.FIN_REQUETE));
	
		}
		//---Gestion erreurs 
		private function _onError(event:IOErrorEvent):void{
			
			//afficher un message d'erreur et envoyer un mail
			//à l'administrateur pour prévenir l'existence d'une erreur
			
		}
		

		//------------------------------------------------//
		//     			Fonctions privées				  //
		//------------------------------------------------//
		
		
		
		public function get infoRequest():XML{
			return _infoRequest;
		}
		
		
	}
}
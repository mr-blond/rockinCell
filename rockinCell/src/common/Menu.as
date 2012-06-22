package common
{
	import InfoStructure.OutilUtilisateur;
	
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Menu extends Sprite
	{
		
		
		//savoir si l'individu est connecté
		private var _isConnect:Boolean = false;
		
		//instances présentes sur le sprite
		//public var btnMenu:Sprite;
		//public var btnConnect:Sprite;
		/*public var btnCreerCell:Sprite;
		public var btnSeDeco:Sprite;
		public var btnModifCell:Sprite;
		public var fullScreen:Sprite;
		public var btnFacebook:Sprite;
		public var btnTwitter:Sprite;
		public var btnEurock:Sprite;*/
		public var logo :Sprite;
		public var fond :Sprite;
		public var btnFullscreen:Sprite;

		private var _outil:OutilUtilisateur;
		
		public function Menu()
		{
			super();
			if(stage)_init();
			else addEventListener(Event.ADDED_TO_STAGE,_init);
			
		}
		
		private function _init(e:Event = null):void{
			this.onResize();
		}
		
		public function onResize():void{
			this.y  = this.stage.stageHeight;
			this.fond.width = this.stage.stageWidth;
			this.btnFullscreen.x = stage.stageWidth;
		}
		private function _seConnecter(e:MouseEvent):void
		{
			trace('demande de connection');
			_outil = OutilUtilisateur.getInstance();
			_outil.addEventListener(RockEvent.FB_INFO_READY,_utilisateurExiste);
			_outil.connectFacebook();
		}
		
		private function _utilisateurExiste(event:Event):void
		{
			_outil.removeEventListener(RockEvent.FB_INFO_READY,_utilisateurExiste);
			trace('---------------------fans utilisateur Existe');
			var infoUtilisateur:Object = _outil.infoFB;
			_outil.addEventListener(RockEvent.RECHERCHE_UTILISATEUR_OVER,_resultatUtilisateurExiste);
			_outil.existe(infoUtilisateur.id);
			
		}
		
		private function _resultatUtilisateurExiste(event:Event):void
		{
			if(_outil.utilisateurExiste){
				
			}else{
				//afficher un panneau qui propose l'inscription 
			}
		}
		
		
	}
}
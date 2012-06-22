package images
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public class AfficherImage extends Sprite
	{
		protected var _chargeur  : Loader    ;
		protected var _largeurVignette : uint;
		protected var _hauteurVignette : uint;
		public function AfficherImage()
		{
		}
		public function affiche(url:String):void
		{	
			//permetre de telecharger un fichier d'un autre serveur
			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
			_chargeur = new Loader()  ;//creation de l'objet Loader
			_chargeur.load(new URLRequest(url),context);
			//listeners
			_chargeur.contentLoaderInfo.addEventListener(Event.COMPLETE,afficherImage);
			_chargeur.contentLoaderInfo.addEventListener(Event.INIT,recupInfos);
			_chargeur.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progresser);
		}
		//--connaitre les propriété de l'image telechargé
		private function recupInfos(e:Event):void{
			_largeurVignette = e.target.width;
			_hauteurVignette = e.target.height;
		}
		//--fonction à lancer lors du telechargement de l'image
		private function progresser(e:ProgressEvent):void{
			
		}
		//--affichage de l'image
		protected function afficherImage(evt:Event):void{
			//transtyper le contenu du chargeur en bitmap
			var monBitmap:Bitmap=_chargeur.content as Bitmap;
			//afficher l'image
			this.addChild(monBitmap);
			
		}
	}
}
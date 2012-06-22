package download
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	public class ChargeurSWF extends Sprite
	{
		
		private var _loader:Loader = new Loader();
		private var _requeteURL:URLRequest;
		
		public var preloader : MovieClip;
		
		public function ChargeurSWF(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function chargerSWF(urlSWF:String):void{
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _chargeComplete);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _onProgress);
			trace('dans preloader');
			//Entrez ici l'url du fichier swf à charger
			_requeteURL = new URLRequest(urlSWF);
		}
		private function _chargeComplete(loadEvent:Event):void {
			
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _chargeComplete);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, _onProgress);
			preloader.visible = false;
			dispatchEvent(new Event(RockEvent.SWF_COMPLETE));
		}
		
		private function _onProgress(mProgress:ProgressEvent):void
		{
			//On peut choisir dans cette fonction de mettre à jour un clip posé sur la scène en se servant de la variable pourcentage (nombre compris entre 0 et 1)
			var pourcentage:Number = mProgress.bytesLoaded / mProgress.bytesTotal;
			trace('pourcentage chargé '  + pourcentage);
			preloader.tf.text = Math.floor(pourcentage)+ '%';
		}
	}
}
package
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.TweenLite;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.SWFLoader;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import pages.moduleTri.ModuleTri;
	import flash.display.DisplayObject;
	
	public class Main extends Sprite
	{
		private var _loader:Loader = new Loader();
		private var _requeteURL:URLRequest;
		
		private var _moduleTri:ModuleTri;
		public var preloader : MovieClip;
		private var _SWFloader:SWFLoader;
		
		public function Main():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _chargeComplete);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _onProgress);
			trace('dans preloader');
			//Entrez ici l'url du fichier swf à charger
			_requeteURL = new URLRequest("swf/rockinCell.swf");
			_loader.load(_requeteURL);
			MonsterDebugger.initialize(this);
		}
		
		private function _chargeComplete(loadEvent:Event):void {
			
			//Lorsque le chargement est terminé, le contenu est ajouté à la scène, on enlève les écouteurs au passage
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _chargeComplete);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, _onProgress);
			addChild(loadEvent.currentTarget.content);
			preloader.visible = false;
//			
			//demander a charger le module de tri
			_SWFloader = new SWFLoader("swf/moduleTri.swf", {name:"moduleTri", container:this , onInit:_initHandler});
			_SWFloader.load();
			
		}
		
		private function _initHandler(event:LoaderEvent):void{
			//TweenLite.from(event.target.content, 1, {alpha:0});
			var mc:DisplayObject = _SWFloader.getSWFChild("moduleTri");
			MonsterDebugger.inspect(mc);
			_moduleTri = mc as ModuleTri;
			addChild(_moduleTri);
			_moduleTri.x = stage.stageWidth - (_moduleTri.width + 50) ;
			_moduleTri.y = _moduleTri.height + 50;
		}
		
		private function _onProgress(mProgress:ProgressEvent):void
		{
			//On peut choisir dans cette fonction de mettre à jour un clip posé sur la scène en se servant de la variable pourcentage (nombre compris entre 0 et 1)
			var pourcentage:Number = mProgress.bytesLoaded / mProgress.bytesTotal;
			trace('non arrondi' + Math.floor(pourcentage));
			trace('pourcentage chargé '  +  Math.floor(pourcentage*100));
			preloader.tf.text = Math.floor(pourcentage*100)+ '%';
		}
	}
}

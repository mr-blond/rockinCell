package common
{
	import InfoStructure.IndividuBase;
	
	import cellules.Cell;
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class FicheIndividu extends Sprite
	{
		public var fond:MovieClip;
		public var pseudo:TextField;
		public var description:TextField;
		public var genre:TextField;
		public var age:TextField;
		public var nationalite:TextField;
		public var musique:Sprite;
		public var btnFB:Sprite;
		public var btnQuitter:Sprite;
		public var photo:Sprite;
		private var _cell : Bitmap;
		
		
		private var _individu:IndividuBase;
		public function FicheIndividu()
		{
			super();
			if(stage)_init();
			else addEventListener(Event.ADDED_TO_STAGE,_init);
			
		}
		private function _init(e:Event = null):void{
			fond.width = stage.stageWidth;
			this.y = stage.stageHeight - 60;
			btnQuitter.addEventListener(MouseEvent.CLICK,_quitterFiche);
		}
		
		private function _quitterFiche(event:MouseEvent):void
		{
			TweenLite.to(this,0.5,{y:stage.stageHeight - 60});
		}
		public function chargerInfo(individu:IndividuBase,image:Bitmap):void{
			_individu = individu;
			_cell = new Bitmap(image.bitmapData);
			//MonsterDebugger.inspect(_cell);
			TweenLite.to(this,0.5,{y:stage.stageHeight - 60,onComplete:_changerValeur});
			
		}
		private function _changerValeur():void{
			photo.addChild(_cell);
			pseudo.text = _individu.pseudo;
			description.text = _individu.description;
			genre.text = _individu.genrePref;
			age.text = String(_individu.age);
			nationalite.text = _individu.pays;
			TweenLite.to(this,0.5,{y:stage.stageHeight-(this.height + 60)});
		}
	}
}
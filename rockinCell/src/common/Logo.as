package common
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class Logo extends Sprite
	{
		public function Logo()
		{
			super();
			if(stage)_init();
			else addEventListener(Event.ADDED_TO_STAGE,_init);
			
		}
		private function _init(e:Event = null):void{
			//demander a aligné en haut a gauche et ne pas toucher aux proportions
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			this.x = 0;
			//savoir quand on change la taille du navigateur
			stage.addEventListener(Event.RESIZE, resize);
			resize();
		}
		//---Mettre en pein ecran même quand le navigateur change de taille
		private function resize(e:Event = null):void{
			this.y = stage.stageHeight; 
		}
	}
}
package common
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Masque extends Sprite
	{
		public function Masque()
		{
			super();
			if(stage)_init();
			else addEventListener(Event.ADDED_TO_STAGE,_init);
		}
		private function _init(e:Event = null):void{
			this.height = 1200;
			this.width = stage.stageWidth;
			this.y =  - 60 ;
		}
	}
}
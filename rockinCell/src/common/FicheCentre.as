package common
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	public class FicheCentre extends Sprite
	{
		public function FicheCentre()
		{
			if(stage)init();
			else addEventListener(Event.ADDED_TO_STAGE,init);
		
		}
		private function init(e:Event = null):void{
			
			_listeners();
			this.y = -this.height;
			this.x = (stage.stageWidth - this.width) / 2;
		}
		private function _listeners():void
		{
			this.addEventListener(Event.REMOVED_FROM_STAGE,flush);			
		}
		//supprimer l'instance
		protected function flush(event:Event):void
		{
						
		}
		//afficher l'instance au centre de l'ecran
		public function shown():void{
			
			//MonsterDebugger.inspect(parent);
			//parent.addChild(this);
			TweenLite.to(this,1,{y:(stage.stageHeight - this.height )/ 2});
		}
		//enlever l'instance de la liste d'affiche + transition
		public function hide():void{
			
			TweenLite.to(this,1,{y:-this.height,onComplete:_finHide});
		}
		private function _finHide():void{
			parent.removeChild(this);
		}
	}
}
package formulaires.part
{
	import com.greensock.TweenLite;
	
	import fl.controls.Button;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	
	public class BoiteVignette extends Sprite
	{
		public var previous:MovieClip;
		public var next:MovieClip;
		public var photoEmplacement:MovieClip;
		
		public function BoiteVignette()
		{
			super();
			previous.addEventListener(MouseEvent.MOUSE_DOWN,clickPrevious);
			next.addEventListener(MouseEvent.MOUSE_DOWN,clickNext);
		}
		
		private function clickPrevious(e:MouseEvent):void{
			trace("dans click previous");
			TweenLite.to(photoEmplacement, 1, {x:photoEmplacement.x + 65});
			
		}
		private function clickNext(e:MouseEvent):void{
			TweenLite.to(photoEmplacement, 1, {x: photoEmplacement.x - 65});
			
		}
	}
}
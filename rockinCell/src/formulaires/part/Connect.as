package formulaires.part
{
	import com.facebook.graph.Facebook;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import formulaires.FormEvent;

	public class Connect extends Sprite
	{
		public var btnFBConnect : MovieClip;
		
		public function Connect()
		{
			btnFBConnect.addEventListener(MouseEvent.CLICK,_onFBClick);
			trace('dddddd');
		}
		
		private function _onFBClick(event:MouseEvent):void
		{
			trace('eeee')
			dispatchEvent(new Event(FormEvent.FB_LOGIN_CLICK));
			
		}
		
	}
}
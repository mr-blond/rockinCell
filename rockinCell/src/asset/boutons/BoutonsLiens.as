package asset.boutons
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class BoutonsLiens extends Sprite
	{
		//------------------------------------------------//
		//       		     CONSTRUCTEUR				  //
		//------------------------------------------------//
		public function BoutonsLiens()
		{
			this.addEventListener(MouseEvent.CLICK,onMouseClick);
			/*this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);*/
		}
		//------------------------------------------------//
		//       	     Fonctions privées				  //
		//------------------------------------------------//
		private function onMouseClick(e:Event):void{
			
		}
	}
}
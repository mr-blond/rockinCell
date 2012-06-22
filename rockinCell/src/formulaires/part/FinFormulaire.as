package formulaires.part
{
	import common.FicheCentre;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import formulaires.FormulaireEvent;
	
	public class FinFormulaire extends FicheCentre
	{
		
		public var btnReturn:Sprite;
		
		public function FinFormulaire()
		{
			super();
			if(stage)init();
			else addEventListener(Event.ADDED_TO_STAGE,init);
			
		}
		private function init(e:Event = null ):void{
			btnReturn.addEventListener(MouseEvent.CLICK,_onReturnClick);
		}
		private function _onReturnClick(e:MouseEvent):void{
			dispatchEvent(new Event(FormulaireEvent.ETAPE_COMFIRMATION_FIN));
		}
	}
}
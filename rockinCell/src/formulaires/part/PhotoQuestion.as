package formulaires.part
{
	import common.FicheCentre;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import formulaires.FormulaireEvent;
	
	import images.PhotoBig;
	
	public class PhotoQuestion extends FicheCentre
	{
		private var _photoBig:PhotoBig;
		public var btnPasChanger:Sprite;
		public var btnChangerPhoto:Sprite;
		public var photo:Sprite;
		public function PhotoQuestion()
		{
			super();
			
			//---listeners
			btnPasChanger.addEventListener(MouseEvent.CLICK,_notChange);
			btnChangerPhoto.addEventListener(MouseEvent.CLICK,_changePhoto);
		}
		public function activer(url:String,masqueX:Number = 0 ,masqueY:Number =  0):void{
			
			_photoBig = new PhotoBig(masqueX,masqueY);
			_photoBig.affiche(url)
			photo.addChild(_photoBig);
		}
		private function _notChange(e:MouseEvent):void{
			dispatchEvent(new Event(FormulaireEvent.NO_CHANGE_PHOTO));
		}
		
		private function _changePhoto(e:MouseEvent):void{
			dispatchEvent(new Event(FormulaireEvent.CHANGE_PHOTO));
		}
		
	}
}
//------------------------------------------------//
//     	affichage d'une grande photo 			  //
//		et selection du masque 					  //
//------------------------------------------------//
package images
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.Security;
	
	public class PhotoBig extends AfficherImage
	{
		//------------------------------------------------//
		//     				Proprieté					  //
		//------------------------------------------------//
		//private var _chargeur:Loader;
		private var _urlBig  :String;//adresse vers la version aggrandi de la vignette
		//private var _largeurVignette:int;
		//private var _hauteurVignette:int;
		private var _masque:Sprite;		//cercle qui va definir le masque
		private var _masqueX:uint;		//position vertical du masque
		private var _masqueY:uint;		//position horizontal du masque
		//permet de donner une position par defaut au masque (modification d'une cellule)
		private var _initX:uint;		
		private var _initY:uint;
		//------------------------------------------------//
		//     				CONSTRUCTEUR				  //
		//------------------------------------------------//
		public function PhotoBig (x:uint=0,y:uint=0):void
		{
			//position par defaut de la cellule
			_initX = x;
			_initY = y;
			//création du cercle qui permet la definition du masque
			_masque = new Sprite();// Instance de l'objet d'affichage
			_masque.graphics.beginFill(0x000, 0.3);//Le cercle sera rempli de noir, transparent à 30%
			_masque.graphics.drawCircle(0,0,70);//dessin du cercle avec la méthode drawCircle(x, y, rayon)
			//listeners liés au masque
			_masque.addEventListener(MouseEvent.MOUSE_DOWN,dessinerMasque);
			_masque.addEventListener(MouseEvent.MOUSE_UP,validerMasque);
			
			
			
		}
		//------------------------------------------------//
		//     			Fonctions publiques				  //
		//------------------------------------------------//
		//---------affichage de l'image
		override public function affiche(url:String):void
		{	
			super.affiche(url);
			_urlBig = url;//recuperer l'addresse de l'image
		}
		//------------------------------------------------//
		//     			Fonctions privées				  //
		//------------------------------------------------//
		
		//-----------Fonction liées à la sourie      
		//--deplace le masque et le lier a des fonction
		private function dessinerMasque(e:MouseEvent):void{
			this.removeEventListener(MouseEvent.MOUSE_DOWN,dessinerMasque);
			this.addEventListener(MouseEvent.MOUSE_MOVE,verifMasque);
			_masque.startDrag();
			
		}
		//--verifier que le masque est à la bonne position
		private function verifMasque(e:MouseEvent):void{
			e.updateAfterEvent();//accelerer le nombre de frame par seconde
			if(_masque.x - _masque.width /2< 0){
				
				_masque.x = _masque.width / 2 ;
			}
			if(_masque.y - _masque.height / 2 < 0 ){
		
				_masque.y = _masque.height / 2 ; 
			}
			
			if(_masque.x > _largeurVignette - _masque.width / 2){
				
				_masque.x = _largeurVignette - _masque.width / 2 ;
			}
			if(_masque.y > _hauteurVignette - _masque.height / 2){
				
				_masque.y = _hauteurVignette - _masque.height / 2;     
			}

		}
		//--recuperer les coordonnées du masque
		private function validerMasque(e:MouseEvent = null):void{

			_masque.addEventListener(MouseEvent.MOUSE_DOWN,dessinerMasque);
			_masque.stopDrag();  
			
			_masqueX = _masque.x - _masque.width / 2 ;
			
			_masqueY = _masque.y - _masque.height / 2;
			if(_masqueY > _hauteurVignette) _masqueY = _hauteurVignette - _masque.width;
			if(_masqueX > _largeurVignette) _masqueX = _largeurVignette - _masque.width;
			if(_masqueY > 5000) _masqueY = 0;
			
		}
		
		
		//--affichage de l'image
		override protected function afficherImage(evt:Event):void{
			super.afficherImage(evt);
			_masque.x = _masque.width / 2 + _initX ;
			_masque.y = _masque.height / 2 + _initY;
			//afficher le masque
			addChild(_masque);
			
			
			
		}
		//************ACCESSEURS****************//
		public function get url():String{
			return this._urlBig;
		}
		public function get masqueX():uint{
			
			return this._masqueX;
		}
		public function get masqueY():uint{
			
			return this._masqueY ;
			
		}
		public function set masqueX(x:uint):void{
			_masque.x = x;
		}
		public function set masqueY(y:uint):void{
			_masque.y = y;
		}
	}
}
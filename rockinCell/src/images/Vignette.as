//------------------------------------------------//
//     		Affichage miniature de photo		  //
//------------------------------------------------//

package images
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.Security;
	
	public class Vignette extends AfficherImage
	{
		//------------------------------------------------//
		//     				Propriété 					  //
		//------------------------------------------------//
		//déclaration d'un objet Loader
		//private var _chargeur:Loader;
		private var _urlBig  :String;
		//taille de l'image
		
		//------------------------------------------------//
		//     				CONSTRUCTEUR				  //
		//------------------------------------------------//
		public function Vignette(urlBig:String):void
		{
			this._urlBig = urlBig;
		}
		//------------------------------------------------//
		//     			Fonctions publiques				  //
		//------------------------------------------------//
		//--- demande de chargement de l'image
		override public function affiche(url:String):void
		{	
			super.affiche(url);
			
		}
		//------------------------------------------------//
		//     			Fonctions privées				  //
		//------------------------------------------------//
	
		//--affichage de l'image
		override protected function afficherImage(evt:Event):void{
			//on recupére les informations du chargeur
			var monBitmap:Bitmap= _chargeur.content as Bitmap;
			//on crée un bitmap data de la même taille que le bitmap
			var monBitmpData:BitmapData = new BitmapData(monBitmap.width,monBitmap.width);
			//on le remplie des information de monBitmap
			monBitmpData = monBitmap.bitmapData;
			//création d'un point avec origine 0,0
			var point:Point = new Point();
			//création d'un rectangle de la largeur de l'image et de taille 50 (pour tenir dans le conteneur
			var rectangle:Rectangle = new Rectangle(0,0,monBitmap.width,50);
			//création d'un bitmap data de la taille du rectangle precedament crée
			var miniatureData:BitmapData = new BitmapData(rectangle.width,rectangle.height);
			//on met à l'interieur du bitmap data des information du plus grand bitmapdata
			miniatureData.copyPixels(monBitmpData,rectangle,point);
			//on crée un bitmap qui a pour bitmap data l'objet precedament crée
			var miniature:Bitmap = new Bitmap(miniatureData);
			//on l'affiche sur la scene
			addChild(miniature);
			//supprimer le chargeur
			
		}
		//************ACCESSEURS****************//
		public function get url():String{
			return this._urlBig;
		}
	}
}
//------------------------------------------------//
//     			Affichage de la cellule			  // 
//------------------------------------------------//
package cellules
{
	import InfoStructure.IndividuRockinCell;
	import InfoStructure.OutilUtilisateur;
	
	import com.facebook.graph.Facebook;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import common.Background;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import pages.rockinCell;

	public class Cell extends Sprite
	{
		//------------------------------------------------//
		//     				Propriétés					  //
		//------------------------------------------------//
		private var _masque    : Shape     ;
		private var _chargeur  : Loader    ;
		private var _url       : String    ;//contient le lien vers la photo;
		private var _radius    : uint      ;
		private var _rectangle : Rectangle ;//utilisé pour retailler l'image
		//variable destiné à contenir l'image directement recupéré via facebook
		private var _image     : Bitmap    ;
		private var _imageData : BitmapData;
		//variable destiné à l'image une fois retaillé
		private var _cellData  : BitmapData;
		private var _cellImage : Bitmap    ;
		
		private var _id        : uint      ;
		//contient les information sur le possesseurs de la cellule
		private var _individu  : IndividuRockinCell  ;
		//taille du masque
		private const tailleMasque:uint = 140;
		
		
		//------------------------------------------------//
		//     				Constructeur				  //
		//------------------------------------------------//
		public function Cell(individu:IndividuRockinCell,radius:uint=60)
		{
			
			//donner à la cellule le lien vers sa photo
			_url = individu.urlPhoto;
			//definir son radius
			_radius = radius;
			//donner ses coordonnées spacial
			this.x = individu.x;
			this.y = individu.y;
			//donner le masque utilisé pour retailler l'image
			this._rectangle = individu.masque;
			this._individu = individu;
			//verifier que la cellule est sur le stage
			if(this.stage){
				init()
			}else{
				addEventListener(Event.ADDED_TO_STAGE,init);
			}
			
		}
		//------------------------------------------------//
		//     			Fonctions publiques				  //
		//------------------------------------------------//
		
		
		//--------animation Cell
		public function apparaitre():void{
			
			TweenLite.to(this, 1, {scaleX:1, scaleY:1, ease:Back.easeInOut, onComplete:afficherCell});
		}
		public function disparaitre():void{
			TweenLite.to(this, 1, {scaleX:0, scaleY:0, ease:Back.easeInOut, onComplete:supprimerCell});
		}

		
		
		
		//--------centrer la celulle sur la scene
		public function centrerCell():void{
			//realiser les calculs pour savoir de combien il faut deplacer rockinCell.conteneurCell pour que la cellule selectionné soit au centre
			var point:Point = new Point(0,0);//definir l'origine (le coin en haut a gauche de l'ecran);
			var resultat:Point;//variable qui va contenir le resultat
			resultat = this.localToGlobal(point);//trouver l'emplacement de la celulle par rapport à l'origine
			//---calcul des deplacement 
			var deplacementX:int = (Background.BGWIDTH/2)-resultat.x;
			var deplacementY:int = (Background.BGHEIGHT/2)-resultat.y;
			//---utilisation d'un tween pour centré le conteneur
			var tween:TweenLite = new TweenLite(rockinCell.conteneurCell,2,{x:rockinCell.conteneurCell.x + deplacementX,y :rockinCell.conteneurCell.y + deplacementY});
			tween.play();

		}
		//--------Suprimmer le contenu d'une cellule
		//utilisé des que la celulle sort de l'ecran
		public function vider():void{
			
			this._cellImage = null;
			this._masque = null;
			this._individu = null;
		}
		//------------------------------------------------//
		//     			Fonctions privées				  //
		//------------------------------------------------//
		//--------une fois la celulle sur le stage
		private function init(e:Event = null):void{
			//Supprimer le listener
			removeEventListener(Event.ADDED_TO_STAGE,init);
			//creation de la cellule
			_masque = new Shape();
			_masque.graphics.beginFill(0x888888, 1);
			//séparation entre les bulles
			_masque.graphics.lineStyle(7,0,0);
			_masque.graphics.drawCircle(0,0,_radius);
			_masque.graphics.endFill();
			//affiche la cellule sans photo
			addChild(_masque);
			//savoir quand le masque est sur la scene
			_masque.addEventListener(Event.ADDED_TO_STAGE,chargementPhoto,false,0,true);
		}
		//-------une fois le masque sur la scene 
		private function chargementPhoto(e:Event):void{
			//Supprimer le listener
			_masque.removeEventListener(Event.ADDED_TO_STAGE,chargementPhoto);
			//instaciation du Loader
			_chargeur = new Loader();
			//permettre le telechargement d'info sur un serveur externe
			var loaderContext:LoaderContext = new LoaderContext ();
			loaderContext.checkPolicyFile = true;
			//Chargemet de la photo
			_chargeur.load(new URLRequest(_url),loaderContext);
			//listeners
			_chargeur.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);//lorsque la photo charge
			_chargeur.contentLoaderInfo.addEventListener(Event.COMPLETE,creerImage);//quand elle a finit de chargé
			_chargeur.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onError);//en cas d'erreur
		}
		//-------animation de chargement
		private function onProgress(e:ProgressEvent):void{
			TweenLite.to(this, 1, {alpha:0.2});
		}
		//--------------affichage de la photo--------------
		private function creerImage(e:Event):void{
			//supprimer les ecouteurs
			_chargeur.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onProgress);
			_chargeur.contentLoaderInfo.removeEventListener(Event.COMPLETE,creerImage);
			_chargeur.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onError);
			//une fois la photo chargé enever la transparence
			TweenLite.to(this, 1, {alpha:1});
			//recuperer l'image complete
			_image = new Bitmap();
			_image = _chargeur.content as Bitmap;
			//recuperer le bitmapData
			_imageData = _image.bitmapData;
			//supprimer le chargeur
			//image est desormait inutil 
			_image = null;
			_chargeur = null;
			//lancer etape suivante
			afficherImage();
			
			
		}
		//-----------appliquer le masque, ajuster l'image, et l'afficher
		private function afficherImage():void{
			//refaire une image avec le masque
			_cellData = new BitmapData(_rectangle.width,_rectangle.height);
			var point:Point = new Point();
			_cellData.copyPixels(_imageData,_rectangle,point);
			_cellImage = new Bitmap(_cellData);
			//supprimerImage data
			_imageData = null;
			_cellData = null;
			//afficher l'image
			addChild(_cellImage);
			//centrer l'image
			_cellImage.x = - tailleMasque/2;
			_cellImage.y = - tailleMasque/2;
			//Masquer l'image
			_cellImage.mask = _masque;
			TweenMax.to(_cellImage, 0, {colorMatrixFilter:{colorize:0xffffff, amount:1}});
			addChild(_cellImage);
		}
		//gestion des erreurs
		private function onError(e:IOErrorEvent):void{
			trace('/----------------------------------------------------------------/');
			//permettre le telechargement d'info sur un serveur externe
			var loaderContext:LoaderContext = new LoaderContext ();
			loaderContext.checkPolicyFile = true;
			//ajouter une image par defaut
			//penser a l'avatar
			//retrouver l'url de l'avatar
			//var url : String  = Facebook.getImageUrl(String(_individu.u),"square");
			//trace('// url = ' +url); 
			//_chargeur.load(new URLRequest(url),loaderContext);
		}
		
		
		//--------Affichage de la cellule
		public function supprimerCell():void{
			rockinCell.conteneurCell.removeChild(this);
		}
		private function afficherCell():void{
			rockinCell.conteneurCell.addChild(this)
		}
		//------------------------------------------------//
		//     				ACCESSEURS					  //
		//------------------------------------------------//
		public function set id(id:uint):void{
			this._id = id;
		}
		public function get id():uint{
			return this._id;
		}
		public function get masque():Shape{
			return this._masque;
		}
		public function get image():Bitmap{
			return this._cellImage;
		}
		public function get individu():IndividuRockinCell{
			return this._individu;
		}

	}
}
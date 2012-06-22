//------------------------------------------------//
//       Definition des cercles qui permettent	  //
//		 le tri des individu					  //
//------------------------------------------------//
/**
 * @author psid
 */
package pages.moduleTri {

	import com.greensock.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Critere extends Sprite {
		//------------------------------------------------//
		//     				Propriétés					  //
		//------------------------------------------------//
		private var _fond:CritereAffichage;
		private var _nomCritere:String;
		private var _valeurSelection : String;
		private var _dataSelection : Array;
		private var _label:Array;
		private var _data:Array;
		private var _liste:listeCritere;
		private var _Xinitial:Number;
		private var _Yinitial:Number;
		private var _Xinitialmini:Number;
		private var _Yinitialmini:Number;
		//------------------------------------------------//
		//     				CONSTRUCTEUR				  //
		//------------------------------------------------//
		/**
		 * parametre critére crée par Module tri et contient
		 * toute les informations sur le critére
		 */
		public function Critere(critere:Object) {
			
			//recupération des informations en paramétre
			_nomCritere = critere.name;
			_label = critere.label;
			
			_data = critere.data;
			
			//création du cercle
			_fond = new CritereAffichage();
			_fond.txtCritere.text = _nomCritere;
			this.buttonMode = true;
			//placement du cercle
			addChild(_fond);
			
			//listener
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseClick);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			//création de la liste
			if(this._liste == null) this._liste = new listeCritere();
			_liste.btnUp.addEventListener(MouseEvent.CLICK, defilementHaut);
			_liste.btnBottom.addEventListener(MouseEvent.CLICK, defilementBas);
			//mettre toute les valeurs possibles dans la liste
			for(var i:uint = 0; i<_label.length ; i++){
				var element:Element = new Element();
				element.buttonMode = true;
				element.label.text = _label[i];
				element.name = String(i);
				element.y = i*element.height;
				element.addEventListener(MouseEvent.CLICK, selectionValeur);
				_liste.display.addChild(element);
			}
			
		}
		//------------------------------------------------//
		//     			Fonctions publiques				  //
		//------------------------------------------------//
		//Disposition des cellules
		public function retourInitial():void{
			this.x = this._Xinitial;
			this.y = this._Yinitial;
			this._fond.txtCritere.text = this._nomCritere;
			
		}
		public function retourInitMini():void{
			this.x = this._Xinitialmini;
			this.y = this._Yinitialmini;
		}
		//affichage de toute les valeurs possibles
		public function afficherListe():void{
			_liste.x = _fond.x;
			_liste.y = _fond.y;
			this.addChild(_liste);
		}
		//enlever a liste
		public function cacherList():void{
			if(_liste.stage)		removeChild(_liste);
		}
		
		//------------------------------------------------//
		//     			Fonctions privées				  //
		//------------------------------------------------//
		//une fois selectionné la valeur apparait dans la cellule
		private function selectionValeur(e:MouseEvent) : void {
			var currentElement:Element = e.currentTarget as Element;
			//fermer la liste et montrer la valeur selectionné
			this._valeurSelection = currentElement.label.text;
			this._fond.txtCritere.text = _valeurSelection;
			
			if(_data[currentElement.name] is String){
				this._dataSelection = new Array (_data[currentElement.name])
				
			}else this._dataSelection  = _data[currentElement.name] ;
			
			this.cacherList();
			this.retourInitMini();
			//ajouter à l'objet la valeur 
			dispatchEvent(new Event('selectionDone'));
		}
		//--------------Fonction qui permet le defilement des valeurs
		private function defilementBas(e:MouseEvent) : void {
			TweenLite.to(_liste.display, 1, {y: _liste.display.y - 65});
		}

		private function defilementHaut(e:MouseEvent) : void {
			TweenLite.to(_liste.display, 1, {y: _liste.display.y + 65});
		}
		//--------------Deplacement des criteres
		private function onMouseUp(e:MouseEvent) : void {
			
			this.stopDrag();
		}
		
		private function onMouseClick(e:MouseEvent) : void {
			trace('click critére');
			this.startDrag();
			// rafraichir le plus possible l'element pour un visuel plus attractif
			e.updateAfterEvent();
			//mettre en haut de la liste d'affichage le critere
			//parent.swapChildren(this,parent.getChildAt(parent.numChildren-1));
			
		}
		
		//------------------------------------------------//
		//     				ACCESSEURS 					  //
		//------------------------------------------------//
		//--Getter
		public function get nom():String{
			return this._nomCritere;
		}
		public function get selection():String{
			return this._valeurSelection;
		}
		public function get data():Array{
			return this._dataSelection;
		}
		public function get xInit():Number{
			return this._Xinitial
		}
		public function get yInit():Number{
			return this._Yinitial
		}
		//--Setter
		public function set xInit(x:Number):void{
			_Xinitial = x;
			this.x = _Xinitial;
		}
		public function set yInit(y:Number):void{
			_Yinitial = y;
			this.y = _Yinitial;
		}
		public function set xInitMini(x:Number):void{
			_Xinitialmini = x;
		}
		public function set yInitMini(y:Number):void{
			_Yinitialmini = y;
		}
	}
}

package pages
{
	import InfoStructure.DataStructure;
	import InfoStructure.IndividuBase;
	
	import cellules.Cell;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	import com.greensock.loading.SWFLoader;
	
	import common.Background;
	import common.FicheIndividu;
	import common.Menu;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import formulaires.FormulaireRockinCell;
	
	import gravite.GestAttraction;
	
	import mouvement.Inertia;
	
	
	
	
	public class rockinCell extends Sprite{

		
		public var background:Background;
		public var menu:Menu;
		public var logo:Sprite;
		public var conteneurC: Sprite;
		public var ficheIndividu:FicheIndividu;
		public static var conteneurCell : Sprite ;
		
		//Instance qui contient toute les informations ayant un rapport avec les utilisateurs de l'apps
		private var _dataStructure :DataStructure;
		private var _gestAttraction:GestAttraction;
		
		
		private var _loader:SWFLoader;
		private var _formulaire:FormulaireRockinCell;
		
		public function rockinCell():void{
			
			// Start the MonsterDebugger
//			MonsterDebugger.initialize(this);
			
			if (stage) _init();
			else addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		
		private function _init(e:Event = null):void{
			
			this.removeEventListener(Event.ADDED_TO_STAGE, _init);
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.addEventListener(Event.RESIZE, _onResizeEvent);
			
			
			
			
			_menuListener();
			
			_onResizeEvent();
			
			
			_chargerIndividu();
			conteneurCell = conteneurC;
//			var inertia:Inertia = new Inertia(conteneurCell);
//			addChild(inertia);
			_conteneurListener();
		}
		
		private function _conteneurListener():void
		{
			conteneurCell.addEventListener(MouseEvent.MOUSE_OVER,_onMouseOver);
			conteneurCell.addEventListener(MouseEvent.MOUSE_OUT,_onMouseOut);
			conteneurCell.addEventListener(MouseEvent.CLICK,_onMouseClick);				
		}
		
		private function _onMouseClick(event:MouseEvent):void
		{
			trace('---------------cellClick');
			// on verifie qu'il s'agit d'une cellule
			
			if(event.target is Cell){
				var cell:Cell = event.target as Cell; 
				var individu:IndividuBase = cell.individu;
				//centrer l'individu
				cell.centrerCell();
				//faire de l'individu le centre de gravité
				GestAttraction.getInstance().gPoint = cell.individu.attraction;
				//affichage de la fiche utilisateur
				ficheIndividu.chargerInfo(individu,cell.image);
				
				
			} 
		}
		// -- lors du survol de la sourie
		private function _onMouseOver(e:MouseEvent):void{
			if(e.target is Cell){
				
				var currentCell:Cell = e.target as Cell;
				var monTween:TweenLite;
				monTween = TweenLite.to(currentCell.masque, 0.5, {width:140,height:140,ease:Circ.easeOut});
			}  
		}
		// -- lorsque la sourie sort de la cellule
		private function _onMouseOut(e:MouseEvent):void{
			if(e.target is Cell){
				var currentCell:Cell = e.target as Cell;
				var monTween:TweenLite;
				monTween = TweenLite.to(currentCell.masque, 1, {scaleX:1, scaleY:1});
				
			}
		}
		
		
		private function _menuListener():void
		{
			menu.btnFullscreen.addEventListener(MouseEvent.CLICK,_fullscreen);
		/*	menu.btnModifCell.addEventListener(MouseEvent.CLICK,_modifCell);
			menu.btnFacebook.addEventListener(MouseEvent.CLICK,_flushConteneur);
			menu.btnCreerCell.addEventListener(MouseEvent.CLICK,_onInscriptionClick);
			menu.btnTwitter.addEventListener(MouseEvent.CLICK,_onIndividuCree);*/
		}
		
		private function _fullscreen(event:MouseEvent):void
		{
			this.background.fullScreen();			
		}
		
		private function _relaunchGravite(event:MouseEvent):void
		{
			
		}
		
		private function _onInscriptionClick(event:MouseEvent):void
		{
			_creerFormulaire();
			_formulaire.inscription()
		}
		private function _modifCell(event:MouseEvent):void
		{
			trace('_modifCell');
			_creerFormulaire();
			_formulaire.modification();
		}
		private function _creerFormulaire():void
		{
			_formulaire = new FormulaireRockinCell();
			addChild(_formulaire);
			_onResizeEvent();	
		}
		

		private function _chargerIndividu(url:String =  'leave/tri.php'):void
		{
			//--Telechargement des individus
			_dataStructure = DataStructure.getInstance();
			_dataStructure.addEventListener(RockEvent.INDIVIDU_CREE,_onIndividuCree);	// une fois les individus crées,ils doivent étre animé		
			_dataStructure.chargerFichier(RockInfo.SERVEUR_URL + url);
			//_dataStructure.chargerFichier('test.xml');
		}		
		
		private function _onIndividuCree(event:Event):void
		{
			stage.addEventListener(Event.ENTER_FRAME,_onEnterFrame);
		}		
		// -- demandé à chaque enterFrame de deplacer les celulles
		private function _onEnterFrame(e:Event):void{
			_dataStructure.gravite();
		}
		private function _onResizeEvent(event:Event = null) : void
		{
			
			menu.onResize();
	
		}
		private function _flushConteneur(e:MouseEvent):void{

			_dataStructure.enleverCellules();
			
			
			
		}
	}	 
}

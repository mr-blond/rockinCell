package formulaires.part
{
	
	import InfoStructure.IndividuBase;
	import InfoStructure.OutilUtilisateur;
	
	import asset.boutons.BoutonsCercle;
	
	import common.FicheCentre;
	
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;
	import fl.controls.TextArea;
	import fl.controls.TextInput;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import formulaires.FormulaireEvent;
	
	public class FicheInfo extends FicheCentre
	{
		public var lePseudo:TextInput;
		public var musiquePref:TextInput;
		public var nomArtiste:TextInput;
		public var leDescription:TextArea;
		//public var leFB:CheckBox;
		public var stylePref:ComboBox;
		public var caractereRestant:TextField;
		
		public var btnSupprimer:Sprite;
		public var photobtn:Sprite;
		
		private var _outilUtilisateur:OutilUtilisateur;
		private var _currentUtilisateur:IndividuBase;
	
		
		
		public function FicheInfo()
		{
			super();
			_outilUtilisateur = OutilUtilisateur.getInstance();
			photobtn.addEventListener(MouseEvent.CLICK,_nextPhase);
			
			if(_outilUtilisateur.individu.pseudo){
				_currentUtilisateur = _outilUtilisateur.individu;
				preremplissagerInscription()
			}
		}
		
		public function preremplissagerInscription():void{
			lePseudo.text = _currentUtilisateur.pseudo;
//			
//			if(_currentUtilisateur.placeCamping == 0){// si l'indidu ne va pas au camping, flouter la selection
//				lePlace.value = 0;
//				lePlace.alpha = 0.4;
//				leCamping.selected = true;//  mettre a true la check box
//			}else lePlace.value = _currentUtilisateur.placeCamping;
//			
			//if(_currentUtilisateur.lienFb =='') leFB.selected = false;
			leDescription.text = _currentUtilisateur.description;
//			//necessite la separation de la chanson et de l'artiste(separé par un '-')
			var musique:Array = _currentUtilisateur.musiquePref.split('-');
			
			if(musique[0])musiquePref.text = musique[0];
			if(musique[1])nomArtiste.text =  musique[1];
			//stylePref.text = _currentUtilisateur.genrePref;
			//afficher le bouton qui permet de supprimer la cellule
			btnSupprimer.visible = true;
		}
		private function  _nextPhase(e:MouseEvent):void{
			dispatchEvent(new Event(FormulaireEvent.FIN_INFO));
		}
		public function get pseudo():String{
			return this.lePseudo.text;
		}
		public function get musique():String{
			return this.musiquePref.text;
		}
		public function get artiste():String{
			return this.nomArtiste.text;
		}
		public function get description():String{
			return this.leDescription.text;
		}
		public function get genrePref():String{
			//if(this.stylePref.selectedItem.data)return this.stylePref.selectedItem.data;
			//else return '';
			return 'rock';
		}
		public function get isOkForFB():Boolean{
			//return leFB.selected;
			return true;
		}
		
	}
}
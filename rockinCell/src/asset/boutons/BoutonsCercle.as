﻿//------------------------------------------------////       	  Definition des animations 		  ////			liées au boutons circulaires		  ////------------------------------------------------//package asset.boutons{	import com.greensock.TweenLite;	import com.greensock.easing.Expo;		import flash.display.Sprite;	import flash.events.MouseEvent;
	public class BoutonsCercle extends Sprite	{		//------------------------------------------------//		//       		     CONSTRUCTEUR				  //		//------------------------------------------------//		public function BoutonsCercle()		{			this.buttonMode = true;//changer le curseur lors du survol						//-------Listener			this.addEventListener(MouseEvent.CLICK,onMouseClick);			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);		}		//------------------------------------------------//		//       	    Fonctions privées				  //		//------------------------------------------------//		private function onMouseClick(e:MouseEvent):void{			//trace("click");		}		private function onMouseOver(e:MouseEvent):void{			TweenLite.to(this, 1, {alpha:0.6});		}		private function onMouseOut(e:MouseEvent):void{			TweenLite.to(this, 1, {alpha:1, ease:Expo.easeOut});		}	}}
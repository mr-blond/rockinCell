﻿//--------------------------------------------------////		deplacement d'un sprite avec inertie		////--------------------------------------------------//package mouvement {		import flash.display.Sprite;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.geom.Point;	/**	 * @author psid	 */	public class Inertia extends Sprite {		//------------------------------------------------//		//     				Propriété 					  //		//------------------------------------------------//		private var _mouseIsDown : Boolean = false;		private var _targetObject : Sprite;		private var _previousPos : Point; // savoir la position de la cible lors de la frame precedente		private var _speed : Point;		private var _posOnClickX:int;		private var _posOnClickY:int;		private var _stageSize : Number;		//--------------------------------------------------//		//					Constructeur					//		//--------------------------------------------------//		public function Inertia(target:Sprite) {			//recuperer l'objet concerné par l'inertie			_targetObject = target;			//instanciation des Points			_previousPos = new Point();			_speed = new Point();			//verifier que l'instance est sur le stage			if(stage)init();			else addEventListener(Event.ADDED_TO_STAGE, init);					}		//--------------------------------------------------//		//					fonctions privées				//		//--------------------------------------------------//		private function init(event : Event = null) : void {//			_stageSize = stage.stageHeight;			_targetObject.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);//			_targetObject.addEventListener(MouseEvent.MOUSE_OUT, mouseUp);			_targetObject.addEventListener(MouseEvent.ROLL_OUT, mouseUp);			_targetObject.addEventListener(MouseEvent.MOUSE_UP, mouseUp);//			stage.addEventListener(Event.ENTER_FRAME,enterFrame);					}		private function mouseDown(event : MouseEvent) : void {			_posOnClickX = mouseX;			_posOnClickY = mouseY;						_mouseIsDown = true;			//permet le deplacement de la cible			event.currentTarget.startDrag();			stage.addEventListener(Event.ENTER_FRAME,enterFrame);		}		private function mouseUp(event : MouseEvent = null) : void {			_mouseIsDown = false;			//arreter le deplaement de la cible			_targetObject.stopDrag();		}		private function enterFrame(e : Event) : void			{			trace("ef");			var tX	:Number = _targetObject.x;			var tY	:Number = _targetObject.y;						  if (_mouseIsDown) {				 //definit la vitesse, mais il ne faut pas utiliser cette valeur si MouseDown			    _speed.x = stage.mouseX - _previousPos.x;			    _speed.y = stage.mouseY - _previousPos.y;									 tX = stage.mouseX -  _posOnClickX;				 tY = stage.mouseY -  _posOnClickY;							  }			  else {				// si la sourie n'est pas en mouseDown				//on veux un effet d'inertie, deplacer l'objet, et en reduire sa vitesse petit a petit			    tX += _speed.x;			    tY += _speed.y;							    _speed.x *= 0.8;			    _speed.y *= 0.8;						    //Si vitesse negligeable, arreter le deplacement et arreter d'ecouter l'enterFrame			    if (_speed.length < 1) {			     	stage.removeEventListener(Event.ENTER_FRAME, enterFrame);			    }								  }					 			if(tY < stage.stageHeight - _targetObject.height){				tY = stage.stageHeight - _targetObject.height;			}			if(tX < stage.stageWidth - _targetObject.width){				tX = stage.stageWidth - _targetObject.width;			}			if(tX > 0 ){				tX = 0;			}			if(tY > 0 ){				tY = 0;			}						if (_targetObject.width > stage.stageWidth) {				_targetObject.x = Math.round(tX);			}			else {				_targetObject.x = Math.round((stage.stageWidth - _targetObject.width)/2);			}			_targetObject.y = Math.round(tY);					  		_previousPos.x = stage.mouseX;			_previousPos.y = stage.mouseY;		}			}}
//------------------------------------------------//
//     	Gere le fond utilisé par l'application	  //
//------------------------------------------------//
package common
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class Background extends Sprite
	{
		//------------------------------------------------//
		//     				Propriété 					  //
		//------------------------------------------------//
	
		//Connaitre la taille de la fenetre
		public static var BGWIDTH:uint;
		public static var BGHEIGHT:uint;
		
		//------------------------------------------------//
		//     				Constructeur				  //
		//------------------------------------------------//
		public function Background():void{
			if(stage)_init();
			else addEventListener(Event.ADDED_TO_STAGE,_init);
			
		}
		
		private function _init(e:Event = null):void{
			//demander a aligné en haut a gauche et ne pas toucher aux proportions
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			//savoir quand on change la taille du navigateur
			stage.addEventListener(Event.RESIZE, resize);
			resize();
		}
		
		//------------------------------------------------//
		//     			Fonctions publiques				  //
		//------------------------------------------------//
		
		
		//mettre l'application en plein ecran
		public function fullScreen():void{
			if (stage.displayState=="normal") {
				stage.displayState = "fullScreen";
			}else{
				stage.displayState = "normal";
			}
		}
		//------------------------------------------------//
		//     			Fonctions privées				  //
		//------------------------------------------------//

		
		

		//---Mettre en pein ecran même quand le navigateur change de taille
		private function resize(e:Event = null):void{
		
			adaptToStage();
		}
		//---faire en sorte que l'image prenne tout l'ecran
		private function adaptToStage():void{
			
				//initialisation des valeurs
				var scale:Number = 1;
				var tx:Number = 0;
				var ty:Number = 0;
				//calculer le rapport de l'image et du stage
				//pour savoir si on doit se rapporter à la largeur ou la hauteur de l'image
				//pour l'etirer
				var rapportStage:Number = stage.stageWidth/stage.stageHeight;
				var rapportImage:Number = this.width/this.height;
				if(rapportStage < rapportImage) {
					// on calque la hauteur
					scale = stage.stageHeight/this.height;
				} else {
					// on calque la largeur
					scale = stage.stageWidth/this.width;
				}
				
				this.width  = this.width * scale;
				this.height = this.height * scale;
				this.x = tx;
				this.y = ty;	
				
				//mettre dans les variables statique la taille de l'instance
				BGWIDTH = this.stage.stageWidth;
				BGHEIGHT = this.stage.stageHeight;
				
			
			//prevenir que le navigateur à changer de taille
			this.dispatchEvent(new Event("bgResize"));
		}
		
	
		
		
	}
}
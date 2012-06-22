//------------------------------------------------//
//     		Outils utilisé dans l'application	  //
//------------------------------------------------//
package  math
{
	
	public class Math2 
	{
		//------------------------------------------------//
		//       	     Constructeur					  //
		//------------------------------------------------//
		public function Math2() 
		{
			
		}
		//--creer un chiffre en min et max
		public static function randomiseBetween(range_min:int, range_max:int):int{
			var range:int = range_max - range_min;
			var randomised:int = Math.random() * range + range_min;
			return randomised;
		}
		//--recuperer un uint aleatoirement entre la valeur minimum d'un tableau et sa valeur maximum
		public static function shufflin(max:uint, min:uint = 0):Number{
			var range:int = max-min;
			var resultat:int = Math.floor(Math.random()*range+min);
			return resultat;
		}
	}	

}
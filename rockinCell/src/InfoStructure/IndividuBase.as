//------------------------------------------------//
//     		defini un Individu 					  //
//------------------------------------------------//
package InfoStructure
{
	public class IndividuBase
	{
		//------------------------------------------------//
		//     				 Propriété  		 		  //
		//------------------------------------------------//
		protected  var _id         : uint     ;
		private var _sexe          : String   ;
		private var _pseudo        : String   ;
		private var _nom           : String   ;
		private var _prenom        : String   ;
		private var _dateNaissance : String   ;
		private var _age           : uint     ;
		private var _masqueX       : uint     ;
		private var _masqueY       : uint     ;
		private var _adresseMail   : String   ;
		private var _placeCamping  : uint     ;
		private var _musiquePref   : String   ;
		private var _genresPref    : String   ;
		private var _urlPhoto      : String   ;
		private var _description   : String   ;
		private var _pays          : String   ;
		
		private var _lienFB        : String   ;
		public function IndividuBase(individu:XML = null)
		{
			if(individu !=null){
				// donner à l'individu ses caractéristiques presente au depart dans le XML
				this._id            = individu.id;
				this._sexe          = individu.sexe;
				this._pseudo        = individu.pseudo;
				this._nom           = individu.nom;
				this._prenom        = individu.prenom;
				this._dateNaissance = individu.dateNaissance;
				
				this._masqueX       = individu.masqueX;
				this._masqueY       = individu.masqueY;
				
				this._adresseMail   = individu.mail;
				this._placeCamping  = individu.placeCamping;
				this._musiquePref   = individu.musiquePref;
				this._description   = individu.description;
				this._pays          = individu.pays;
				this._genresPref    = individu.genrePref;
				
				this._age           = this.calculerAge(_dateNaissance);
				this._urlPhoto      = individu.photoUrl;
				//this._anneeFestival = individu.anneesFestival;
				this._lienFB        = individu.lienFB;
			}
			
		}
		//------------------------------------------------//
		//      		Functions privées	 			  //
		//------------------------------------------------//
		//--Calcul-------------------

		

		private function calculerAge(dateNaissance:String):uint{
			//recuperer la date d'aujourd'hui
			var temps:Date = new Date();
			var jour:uint = temps.date;
			var mois:uint = temps.month;
			var annee:uint = temps.fullYear;
			
			var dateSplit:Array = dateNaissance.split('/');
			if (jour >= dateSplit[1] && mois == dateSplit[0] || mois > dateSplit[0]) return annee - dateSplit[2]; 
			else return annee - dateSplit[2] - 1; 
			
		}
		//------------------------------------------------//
		//     				Accesseur					  //
		//------------------------------------------------//
		public function get pseudo():String{
			return this._pseudo;
		}
		public function get sexe():String{
			return this._sexe;
		}
		public function get nom():String{
			return this._nom;	
		}
		public function get age():uint{
			return this._age;
		}
		public function get prenom():String{
			return this._prenom;
		}
		public function get placeCamping():uint{
			return this._placeCamping;
		}
		public function get musiquePref():String{
			return this._musiquePref;
		}
		public function get anniv():String{
			return this._dateNaissance;
		}
		public function get mail():String{
			return this._adresseMail;
		}
		public function get lienFb():String{
			return this._lienFB;
		}
		public function get description():String{
			return this._description;
		}
		
		public function get genrePref():String{
			return this ._genresPref;
		}
		public function get pays():String{
			return this ._pays;
		}
		public function get masqueX():uint{
			return this._masqueX;
		}
		public function get masqueY():uint{
			return this._masqueY;
		}
		// Setter necessaire lors de la modification du profil d'un individu
		public function set description(description:String):void{
			this._description = description
		}
		public function set pseudo(pseudo:String):void{
			this._pseudo = pseudo;
		}
		public function get urlPhoto():String{
			return this ._urlPhoto;
		}

		public function set lienFB(value:String):void
		{
			_lienFB = value;
		}
		
		public function get lienFB():String{
			return this._lienFB;
		}
		public function set musique(value:String):void
		{
			_lienFB = value;
		}
		public function set pays(value:String):void
		{
			_pays = value;
		}

		public function set urlPhoto(value:String):void
		{
			_urlPhoto = value;
		}

		public function set genrePref(value:String):void
		{
			_genresPref = value;
		}

		public function set musiquePref(value:String):void
		{
			_musiquePref = value;
		}

		public function set placeCamping(value:uint):void
		{
			_placeCamping = value;
		}

		public function set adresseMail(value:String):void
		{
			_adresseMail = value;
		}

		public function set masqueY(value:uint):void
		{
			_masqueY = value;
		}

		public function set masqueX(value:uint):void
		{
			_masqueX = value;
		}

		public function set dateNaissance(value:String):void
		{
			_dateNaissance = value;
		}

		public function set prenom(value:String):void
		{
			_prenom = value;
		}

		public function set nom(value:String):void
		{
			_nom = value;
		}

		public function set sexe(value:String):void
		{
			_sexe = value;
		}

		public function set id(value:uint):void
		{
			_id = value;
		}
		public function get id():uint{
			return this._id;
		}
		

	}
}
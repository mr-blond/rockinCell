<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of individuSignale
 *
 * @author psid
 */
class individuSignale{
    //put your code here
    //------------------Propriété
    public $id_signalement;
    public $id_accuse;
    public $id_signaleur;
    public $raison;
    public $description;
    public $date;
    
    //------------------Constructeur
    public function __construct()
	{
		$this->id_signalement = 0 ;
		$this->id_accuse      = 0 ;
		$this->id_signaleur   = 0 ;
		$this->raison         = "";
                $this->description    = "";
		$this->date           = date("c") ;	
	}
}

?>

<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of backOffice
 *
 * @author psid
 */
//--------------------IMPORT
require_once 'IndividuSignale.php';

class backOffice {

	protected $host = "localhost";
	protected $username = "root";
	protected $password = "";
	protected $db = "rockincell";
	protected function connect()
	{
		mysql_connect($this->host,$this->username,$this->password)
		or die ("Unable to connect to database.");
		
		mysql_select_db($this->db)
		or die ("Unable to select database.");
	}
        /**
	 * 
	 * Recuperer toute les personnes signalées
	 * @return IndividuSignale[]
	 */
	public function getAllsignalement()
	{
		$this->connect();
		$rs = mysql_query("select * from signalement")
		or die ("Unable to complete query.");
		
		$backOffice = array();
		
		while( $row = mysql_fetch_assoc($rs) )
		{
			$individuSignale = new individuSignale();
			$individuSignale->id_signalement = $row['ID_SIGNALEMENT'];
			$individuSignale->id_signaleur   = $row['ID_signaleur '] ;
                        $individuSignale->id_accuse      = $row['ID_accuse']     ;
                        $individuSignale->raison         = $row['raison']        ;
                        $individuSignale->description    = $row['description']   ;
			
			array_push($backOffice,$individuSignale);
		}
		
		return $backOffice;
	}
        /**
	 * 
	 * Recuperer un signalement grâce à son ID
	 * 
	 * @param int $id
	 * @return IndividuSignale
	 */
	public function getSignalementByID($id)
	{
		$this->connect();
		$query = sprintf("select * from national_forests where id = '%s'",mysql_real_escape_string($id));
		$rs = mysql_query($query)
		or die ("Unable to complete query.");
		
		$row = mysql_fetch_assoc($rs);
		
		$forest = new NationalForest();
		$forest->id = $row['id'];
		$forest->state = $row['state'];
		$forest->area = $row['area'];
		$forest->established = $row['established'];
		$forest->closest_city = $row['closest_city'];
		$forest->name = $row['name'];

		return $forest;
	}
        /**
	 * 
	 * Modifier un individu
	 * 
	 * @param IndividuSignale $individu
	 * @return IndividuSignale
	 */
	public function updateForest($individu)
	{
		$this->connect();
		$query = sprintf("update national_forests set 
				state = '%s', area = '%s', established = '%s', closest_city = '%s', name = '%s'
				where id = '%s' ",
				mysql_real_escape_string($forest->state),
				mysql_real_escape_string($forest->area),
				mysql_real_escape_string($forest->established),
				mysql_real_escape_string($forest->closest_city),
				mysql_real_escape_string($forest->name),
				mysql_real_escape_string($forest->id));
		$rs = mysql_query($query)
		or die ("Unable to complete query.");
		
		return $this->getForestByID($forest->id);
	}
        public function getAllForests()
	{
		$this->connect();
		$rs = mysql_query("select * from national_forests")
		or die ("Unable to complete query.");
		
		$national_forests = array();
		
		while( $row = mysql_fetch_assoc($rs) )
		{
			$forest = new NationalForest();
			$forest->id = $row['id']+0;
			$forest->state = $row['state'];
			$forest->area = $row['area']+0.0;
			$forest->established = new DateTime($row['established']);
			$forest->closest_city = $row['closest_city'];
			$forest->name = $row['name'];
			
			array_push($national_forests,$forest);
		}
		
		return $national_forests;
	}
        /**
	 * 
	 * Supprimer un signalement
	 * 
	 * @param int $id
	 * @return bool
	 */
	public function deleteSignalement($id)
	{
		$this->connect();
		$query = sprintf("delete from national_forests where id = '%s'",
					mysql_real_escape_string($id));
		$rs = mysql_query($query)
		or die ("Unable to complete query.");
		
		return $rs;
	}
        /**
	 * 
	 * Supprimer un Individu
	 * 
	 * @param int $id
	 * @return bool
	 */
	/*public function deleteSignalement($id)
	{
		$this->connect();
		$query = sprintf("delete from national_forests where id = '%s'",
					mysql_real_escape_string($id));
		$rs = mysql_query($query)
		or die ("Unable to complete query.");
		
		return $rs;
	}
        /**
	 * 
	 * Recuperer le nombre total d'individu signalé
	 * 
	 * @return int
	 */
	/*public function count()
	{
		$this->connect();
		$rs = mysql_query("select * from national_forests")
		or die ("Unable to complete query.");
		
		$count = mysql_num_rows($rs);
		return $count;
	}
        /**
	 *
	 * Recuperer un nombre precis d'individu 
         * 
	 * @param int $startIndex
	 * @param int $numItems
	 * 
	 * 
	 */
	public function getIndividuPaged($startIndex, $numItems)
	{
		$this->connect();
		$query = sprintf("select * from national_forests limit %s, %s",
					mysql_real_escape_string($startIndex),
					mysql_real_escape_string($numItems));
		$rs = mysql_query($query)
		or die ("Unable to complete query.");
		
		$national_forests = array();

		while( $row = mysql_fetch_assoc($rs) )
		{
			$forest = new NationalForest();
			$forest->id = $row['id']+0;
			$forest->state = $row['state'];
			$forest->area = $row['area']+0.0;
			$forest->established = new DateTime($row['established']);
			$forest->closest_city = $row['closest_city'];
			$forest->name = $row['name'];
			
			array_push($national_forests,$forest);
		}
		
		return $national_forests;
	}
}

?>

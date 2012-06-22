<?php

error_reporting(E_ALL);

if (0 > version_compare(PHP_VERSION, '5')) {
    die('This file was generated for PHP 5');
}


 
class Utilisateur
{
   

    // --- ATTRIBUTES ---

    private $id = null;

    private $prenom = null;

  
    private $nom = null;

 
    private $anniv = null;

   
    private $mail = null;

    
    private $pays = null;

    
    private $lienFb = null;

    
    private $pseudo = null;

    
    private $description = null;

    
    private $placeCamping = null;

    
    private $musiquePref = null;

    
    private $photoUrl = null;

    
    private $masqueX = null;

    
    private $masqueY = null;

    // --- Connexion BDD ---
    
             
             
    
    
    // --- OPERATIONS ---

    
    public function Utilisateur($id)
    {
        
        
        $this->id  = $id;
        try{
             $connexion = new PDO("mysql:host=".HOST_NAME.";dbname=".BD_NAME."",USER_NAME,PASSWD );
             $query = "SELECT * FROM `utilisateur` WHERE id_utilisateur = $id";
             $resultat = $connexion->query($query);
             $resultat->setFetchMode(PDO::FETCH_OBJ); // on dit qu'on veut que le résultat soit récupérable sous forme d'objet
             while($ligne = $resultat->fetch()){
                 
                 $this->pseudo       = $ligne->pseudo;
                 $this->nom          = $ligne->nom;
                 $this->prenom       = $ligne->prenom;
                 $this->description  = $ligne->description;
                 $this->mail         = $ligne->mail;
                 $this->lienFb       = $ligne->lienFB;
                 $this->pays         = $ligne->pays;
                 $this->anniv        = $ligne->anniv;
                 $this->photoUrl     = $ligne->photoUrl;
                 $this->musiquePref  = $ligne->musiquePref;
                 $this->placeCamping = $ligne->placeCamping;
                 $this->masqueX      = $ligne->masqueX;
                 $this->masqueY      = $ligne->masqueY;
                 
             }
        }
       
        
        
    catch (Exeption $error_string){
        echo 'erreur : '.$error_string->getMessage().'</br>';
        echo 'N° : '.$error_string->getCode();
        die();
        }
    }


    public function modifierIndividu()
    {
        
    }

   
    public function avertirProbleme($accuse,$raison,$description)
    {
        $connexion = new PDO("mysql:host=".HOST_NAME.";dbname=".BD_NAME."",USER_NAME,PASSWD );
        $query = "INSERT INTO signalement (
                ID_signaleur,
                ID_accuse,
                raison,
                description,
                date 
                ) 
          VALUES ($this->id,$accuse,'$raison','$description', CURRENT_DATE ())";
        
            $connexion->exec($query);
            echo $query;
            //@TODO envoyer un mail pour prevenir
    }

    
   
    public function envoyerMessage()
    {
    }
    public function feedBack($message){
        $connexion = new PDO("mysql:host=".HOST_NAME.";dbname=".BD_NAME."",USER_NAME,PASSWD );
        $query = "INSERT INTO feedBack (
                ID_utilisateur,
                message,
                date
                ) 
          VALUES ($this->id,'$message', CURRENT_DATE ())";
        
            $connexion->exec($query);
            echo $query;
            //@TODO envoyer un mail pour prevenir
    }
    public function supprimerUtilisateur($id){
        $connexion = new PDO("mysql:host=".HOST_NAME.";dbname=".BD_NAME."",USER_NAME,PASSWD );
        $query = "DELETE FROM utilisateur
                  WHERE id_utilisateur = $id";
        $connexion->exec($query);
    }
    
    //***************ACCESSEUR
    public function id(){
        return $this->id;
    }
    public function pseudo(){
        return $this->pseudo;
    }
    public function nom(){
        return $this->nom;
    }
    public function prenom(){
        return $this->prenom;
    }
    public function description(){
        return $this->description;
    }
    public function mail(){
        return $this->mail;
    }
    public function lienFB(){
        return $this->lienFb;
    }
    public function pays(){
        return $this->pays;
    }
    public function anniv(){
        return $this->anniv;
    }
    public function photoUrl(){
        return $this->photoUrl;
    }
    public function musiquePref(){
        return $this->musiquePref;
    }
    public function placeCamping(){
        return $this->placeCamping;
    }
    public function masqueX(){
        return $this->masqueX;
    }
    public function masqueY(){
        return $this->masqueY;
    }
     

} /* end of class Utilisateur */


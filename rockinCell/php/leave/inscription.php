<?php
require_once './../database.php';
require_once './../class.Utilisateur.php';
require './../class.Application';

//**-------------Récupération du formulaire flash-----------*/

if(!empty ($_POST['submit'])){
     $id          = $_POST['id']          ;
    $prenom       = $_POST["prenom"]      ;
    $nom          = $_POST['nom']         ; 
    $anniv        = $_POST['anniv']        ;
    $mail         = $_POST['mail']        ;
    $sexe         = $_POST['sexe']        ;
   
    $lienFB       = $_POST['lienFB']      ;
    
    $pseudo       = $_POST['pseudo']      ;
    $description  = $_POST['description'] ;
    $placeCamping = $_POST['placeCamping'];
    $musiquePref  = $_POST['musiquePref'] ;
    $genrePref    = $_POST['genrePref']   ;
    
    $photoUrl     = $_POST['photoUrl']    ;
    $masqueX      = $_POST['masqueX']     ;
    $masqueY      = $_POST['masqueY']     ;

    
    
    
//----------------------------------------------------------
//
//--enlever le underscore du pays
  $pays         = str_replace('_',' ', $_POST['pays'] )       ;
  //instanciation de Application
  $application = new Application();
  //application crée l'utilisateur 
  $application->creerUtilisateur($id,$pseudo,$nom,$prenom,$description,$mail,$lienFB,$pays,$anniv,$photoUrl,$musiquePref,$placeCamping,$masqueX,$masqueY,$sexe,$genrePref);
  //instenciation de l'utilisateur recament crée
 /* $utilisateur = new Utilisateur($id);
  $utilisateur->nom();*/
    

//--------------------------------------------------------------------------
    /*--------------ajout direct d'un noeud individu dans le xml dans le xml ----------*/
/*$utilisateur = new Utilisateur(1176521635);
echo $utilisateur->description();*/

}
<?php

require_once './../database.php';
require_once './../class.Utilisateur.php';


//**-------------Récupération du formulaire flash-----------*/
if(!empty ($_POST['submit'])){
     $id          = $_POST['signaleur']          ;
     $accuse      = $_POST["accuse"]             ;
     $raison      = $_POST['raison']             ;
     $description = $_POST['description']        ;
     
     //----------------------------------------------------------
     $utilisateur = new Utilisateur($id);
     $utilisateur->avertirProbleme($accuse,$raison,$description);
}
    
?>

<?php
require_once './../database.php';
require_once './../class.Utilisateur.php';

if(isset ($_POST['id'])){
   
   
  $id           = $_POST['id'];
  
  

 
  //instanciation de Application
  $utilisateur = new Utilisateur($id);
  $utilisateur->supprimerUtilisateur($id);
}  else {
     echo('echec');
}  
?>

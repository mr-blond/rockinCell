<?php
require_once './../database.php';
require_once './../class.Application';
if(isset ($_POST['id'])){
   
   
   $id           = $_POST['id'];
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
  
  //instanciation de Application
  $application = new Application();
  $application->modifierUtilisateur($id, $pseudo, $description, $placeCamping, $musiquePref, $photoUrl, $masqueX, $masqueY, $genrePref);
}else{
    echo('echec');
}
?>

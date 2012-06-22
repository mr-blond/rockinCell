<?php
require_once './../database.php';
require_once './../class.Application';

//if(empty ($_POST['id'])){
    $application = new Application();
    //$application->utilisateurExiste($_POST['id']);
    $application->utilisateurExiste(1307238891);
   
//}
?>

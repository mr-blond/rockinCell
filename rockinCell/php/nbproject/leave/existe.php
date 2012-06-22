<?php
require_once './../database.php';
require_once './../class.Application';

if(!empty ($_POST['id'])){
    $application = new Application();
    echo $application->utilisateurExiste($_POST['id']);
}
?>

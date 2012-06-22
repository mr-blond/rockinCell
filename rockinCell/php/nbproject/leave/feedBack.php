<?php
require_once '../database.php';
require_once '../class.Utilisateur.php';

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */if(!empty ($_POST['submit'])){
     $id          = $_POST['id']           ;
     $message     = $_POST["message"]      ;
 }
 
 
 //instanciation de Application
  $utilisateur = new Utilisateur($id);
  $utilisateur->feedBack($message);
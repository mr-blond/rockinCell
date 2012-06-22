<?php
/***************Création d'un documentXML à partir d'une base de donné****************************/

require_once 'database.php';//infos necessaire pour se connecter à la base de donné
//Chercher les informations dans la base de donnée
try{
    $connexion = new PDO("mysql:host=".HOST_NAME.";dbname=".BD_NAME."", USER_NAME, PASSWD);
    $query = "SELECT * FROM `utilisateur`";
    $resultat = $connexion->query($query);// chercher toute les informations sur tout les utilisateurs de l'application
    $resultat->setFetchMode(PDO::FETCH_OBJ);// je veux un objet
    //entete du document XML
    $dom = new DOMDocument('1.0','utf8');
    $racine = $dom->createElement('utilisateurs');//noeud racine
    $dom->appendChild($racine);
    while($ligne = $resultat->fetch()){
        //for($i=0;i<10;$i++){
            $individu = $dom->createElement('individu');

            $racine->appendChild($individu);  

            //création des éléments
            //$id            = $dom->createElement('id',$ligne->id_utilisateur);
            $id            = $dom->createElement('id',$ligne->id_utilisateur);
            $pseudo        = $dom->createElement('pseudo',$ligne->pseudo);
            $nom           = $dom->createElement('nom',$ligne->nom);
            $prenom        = $dom->createElement('prenom',$ligne->prenom);
            $description   = $dom->createElement('description',$ligne->description);
            $mail          = $dom->createElement('mail',$ligne->mail);
            $lienFB        = $dom->createElement('lienFB',$ligne->lienFB);
            $pays          = $dom->createElement('pays',$ligne->pays);
            $photoUrl      = $dom->createElement('photoUrl',$ligne->photoUrl);
            $musiquePref   = $dom->createElement('musiquePref',  htmlentities($ligne->musiquePref));
            $placeCamping  = $dom->createElement('placeCamping',$ligne->placeCamping);
            $masqueX       = $dom->createElement('masqueX',$ligne->masqueX);
            $masqueY       = $dom->createElement('masqueY',$ligne->masqueY);
            $sexe          = $dom->createElement('sexe', $ligne->sexe);
            $genrePref     = $dom->createElement('genrePref', $ligne->genrePref);
            $dateNaissance = $dom->createElement('dateNaissance', $ligne->anniv);


            $individu->appendChild($id);
            $individu->appendChild($pseudo);
            $individu->appendChild($nom);
            $individu->appendChild($prenom);
            $individu->appendChild($description);
            $individu->appendChild($mail);
            $individu->appendChild($lienFB);
            $individu->appendChild($pays);
            $individu->appendChild($photoUrl);
            $individu->appendChild($musiquePref);
            $individu->appendChild($placeCamping);
            $individu->appendChild($masqueX);
            $individu->appendChild($masqueY);
            $individu->appendChild($sexe);
            $individu->appendChild($genrePref);
            $individu->appendChild($dateNaissance);

        
        //remplir le noeur $anneeFestival
      /*  $queryAnnees   = "SELECT annee FROM anneeFestival WHERE ID_utilisateur = $ligne->id_utilisateur";
        $resultatAnnee = $connexion->query($queryAnnees);
        $resultatAnnee->setFetchMode(PDO::FETCH_OBJ);
        while($ligne2  = $resultatAnnee->fetch()){
            $currentAnnee = $dom->createElement('annee', $ligne2->annee);
            $anneeFestival->appendChild($currentAnnee);
        }
        $resultatAnnee->closeCursor();*/
        }
   // }
    $resultat->closeCursor();
   
    $monFichier = fopen('utilisateur.xml', 'w+');
    fputs($monFichier,$dom->saveXML() );
    fclose($monFichier);
    echo $dom->saveXML();

}  catch (Exeption $error_string){
    echo 'erreur : '.$error_string->getMessage().'</br>';
    echo 'N° : '.$error_string->getCode();
    die();
    
}


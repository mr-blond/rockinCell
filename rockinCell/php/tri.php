<?php
require_once './../database.php';


  
   
  
    
        
    $connexion = new PDO("mysql:host=".HOST_NAME.";dbname=".BD_NAME."", USER_NAME, PASSWD);
    $isFirst = true;
    $query = "SELECT * FROM utilisateur";
    if(isset ($_POST['sexe'])){
        $genre = $_POST['sexe'];
        if($isFirst == true){
            $query .=  ' WHERE ' ;
             $isFirst = false;
        }
        else $query.= ' AND ';
        $query .="sexe = '$genre' ";
    }
    if(isset ($_POST['musique'])){
        $data = $_POST['musique'];
        if($isFirst == true){
            $query .=  ' WHERE ' ;
             $isFirst = false;
        }
        else $query.= ' AND ';
        $query .="genrePref = '$data' ";
    }
    if(isset ($_POST['place'])){
         $genre = $_POST['place'];
        if($isFirst == true){
            $query .=  ' WHERE ' ;
             $isFirst = false;
        }
        else $query.= ' AND ';
        $query .="placeCamping = $genre ";
    }
     if(isset ($_POST['age'])){
        $array = split( '-' , $_POST['age']);
        //recueperer l'anné
        $anneeMin = intval(date('Y')- intval($array[1]));
        $anneeMax = intval(date('Y')- intval($array[0])) ;
      
        
        }
       
    $resultat = $connexion->query($query);// chercher toute les informations sur tout les utilisateurs de l'application
    $resultat->setFetchMode(PDO::FETCH_OBJ);// je veux un objet
    //entete du document XML
    $dom = new DOMDocument('1.0','utf8');
    $racine = $dom->createElement('utilisateurs');//noeud racine
    $dom->appendChild($racine);
    while($ligne = $resultat->fetch()){
        if(isset ($_POST['age'])){
            $annee = intval( substr($ligne->anniv, -4));
            if($annee>$anneeMin && $annee< $anneeMax) creerIndividu($ligne,$dom,$racine);
            
        }else{
            creerIndividu($ligne,$dom,$racine);
        }
        
        
          
        
    }
    $resultat->closeCursor();
   
    $monFichier = fopen('utilisateur.xml', 'w+');
    fputs($monFichier,$dom->saveXML() );
    fclose($monFichier);
    echo $dom->saveXML();



function creerIndividu($ligne,$dom,$racine){
            $individu = $dom->createElement('individu');
          
            
                  
        
        $racine->appendChild($individu);  

        //création des éléments
        $id            = $dom->createElement('id',$ligne->id_utilisateur);
        $pseudo        = $dom->createElement('pseudo',$ligne->pseudo);
        $nom           = $dom->createElement('nom',$ligne->nom);
        $prenom        = $dom->createElement('prenom',$ligne->prenom);
        $description   = $dom->createElement('description',$ligne->description);
        $mail          = $dom->createElement('mail',$ligne->mail);
        $lienFB        = $dom->createElement('lienFB',$ligne->lienFB);
             ;
        $pays          = $dom->createElement('pays',  str_replace('_',' ', $ligne->pays ));
        $photoUrl      = $dom->createElement('photoUrl',$ligne->photoUrl);
        $musiquePref   = $dom->createElement('musiquePref',  htmlentities($ligne->musiquePref));
        $placeCamping  = $dom->createElement('placeCamping',$ligne->placeCamping);
        $masqueX       = $dom->createElement('masqueX',$ligne->masqueX);
        $masqueY       = $dom->createElement('masqueY',$ligne->masqueY);
        $sexe          = $dom->createElement('sexe', $ligne->sexe);
        $genrePref     = $dom->createElement('genrePref', $ligne->genrePref);
        $dateNaissance = $dom->createElement('dateNaissance', $ligne->anniv);
        $anneeFestival = $dom->createElement('anneesFestival');


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
        $individu->appendChild($anneeFestival);
        }
        //remplir le noeur $anneeFestival
      /*  $queryAnnees   = "SELECT annee FROM anneeFestival WHERE ID_utilisateur = $ligne->id_utilisateur";
        $resultatAnnee = $connexion->query($queryAnnees);
        $resultatAnnee->setFetchMode(PDO::FETCH_OBJ);
        while($ligne2  = $resultatAnnee->fetch()){
            $currentAnnee = $dom->createElement('annee', $ligne2->annee);
            $anneeFestival->appendChild($currentAnnee);
        }
        $resultatAnnee->closeCursor();*/
          

    
    //----------------------------------------------------------
//
 

?>

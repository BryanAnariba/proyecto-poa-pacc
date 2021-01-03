<?php
    require_once('../request-headers.php');
    require_once('../../controllers/ObjetosGastoController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case "POST": 
            //$_POST = json_decode(file_get_contents('php://input'));
            if ($_POST['idObjetoGasto'] && $_POST['ObjetoDeGasto'] && $_POST['Abreviatura'] && $_POST['CodigoObjeto'] && $_POST['Estado']) {
                $Objetos = new ObjetosController();
                
                $Objetos->ActualizarObjeto(
                    $_POST['idObjetoGasto'],
                    $_POST['ObjetoDeGasto'],
                    $_POST['Abreviatura'],
                    $_POST['CodigoObjeto'],
                    $_POST['Estado']
                );
            }else {
                $Objetos = new ObjetosController();
                $Objetos->peticionNoValida();
            }
        break;
        default: 
            $Objetos = new ObjetosController();
            $Objetos->peticionNoValida();
        break;
    }
<?php
    require_once('../request-headers.php');
    require_once('../../controllers/DepartamentosController.php');
    $_POST = json_decode(file_get_contents('php://input'), true);
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST':
            if (!isset($_POST['idObjetoGasto']) && !isset($_POST['idDepartamento'])) {
                echo json_encode(array("data" => array(
                    "items" => 'Listado items'
                )));
            } else {
                switch ($_POST) {
                    case (
                        isset($_POST['idObjetoGasto']) == true && 
                        !empty($_POST['idObjetoGasto'])  &&
                        !isset($_POST['idDepartamento'])
                    ):
                        echo json_encode(array("data" => array(
                            "idObjetoGasto" => $_POST['idObjetoGasto']
                        )));
                    break;
                    case (
                        isset($_POST['idDepartamento']) && 
                        !empty($_POST['idDepartamento']) &&
                        !isset($_POST['idObjetoGasto'])
                    ):
                        echo json_encode(array("data" => array(
                            "idDepartamento" => $_POST['idDepartamento']
                        )));
                    break;
                    case (
                        isset($_POST['idDepartamento']) && 
                        !empty($_POST['idDepartamento']) &&
                        isset($_POST['idObjetoGasto']) && 
                        !empty($_POST['idObjetoGasto']) 
    
                    ):
                        echo json_encode(array("data" => array(
                            "idDepartamento" => $_POST['idDepartamento'],
                            "idObjetoGasto" => $_POST['idObjetoGasto']
                        )));
                    break;
                }
            }
        break;
        default: 
            $departamentos = new DepartamentosController();
            $departamentos->peticionNoValida();
        break;
    }
?>
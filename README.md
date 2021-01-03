# proyecto-poa-pacc
Aplicacion para la facultad de ingenieria

## Para registrar un usuario con el modulo autenticacion completo deben de hacer
## 1 - Comentar include('verifica-session.php'); en usuarios.php, Sidebar.php, Nabvar.php, menu.php
## 2 - Comentar dichas lineas en los modulos de las carpetas de api -> lugares, usuarios, departamentos en donde haiga codigo
## Codigo antes de comentar
    ```
    require_once('../request-headers.php');
    require_once('../../middlewares/VerificarToken.php');
    require_once('../../controllers/LugaresController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            $verificarTokenAcceso = new verificarTokenAcceso();
            $tokenEsValido = $verificarTokenAcceso->verificarTokenAcceso();
            if ($tokenEsValido) {
                if (isset($_POST['idPais']) && !empty($_POST['idPais'])) {
                    $lugares = new LugaresController();
                    $lugares->listarCiudades($_POST['idPais']);
                } else {
                    $lugares = new LugaresController();
                    $lugares->peticionNoValida();
                }
            } else {
                $lugares = new LugaresController();
                $lugares->peticionNoAutorizada();
                require_once('../destruir-sesiones.php');
            }
        break;
        default: 
            $lugares = new LugaresController();
            $lugares->peticionNoValida();
        break;
    }
    ```
## Codigo Comentado solo en las lineas necesarias
    ```
    require_once('../request-headers.php');
    //require_once('../../middlewares/VerificarToken.php');
    require_once('../../controllers/LugaresController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            //$verificarTokenAcceso = new verificarTokenAcceso();
            //$tokenEsValido = $verificarTokenAcceso->verificarTokenAcceso();
            //if ($tokenEsValido) {
                if (isset($_POST['idPais']) && !empty($_POST['idPais'])) {
                    $lugares = new LugaresController();
                    $lugares->listarCiudades($_POST['idPais']);
                } else {
                    $lugares = new LugaresController();
                    $lugares->peticionNoValida();
                }
            //} else {
            //    $lugares = new LugaresController();
            //    $lugares->peticionNoAutorizada();
            //    require_once('../destruir-sesiones.php');
            //}
        break;
        default: 
            $lugares = new LugaresController();
            $lugares->peticionNoValida();
        break;
    }
    ```
## 3 - Despues de comentar esto ya podras registrar un usuario, una vez registrado descomentar el codigo para evitar los huecos de seguridad y hacer login como se debe

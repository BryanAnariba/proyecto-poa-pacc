# proyecto-poa-pacc
Aplicacion para la facultad de ingenieria

## Para registrar un usuario con el modulo autenticacion completo deben de hacer
## 1 - Comentar include('verifica-session.php'); en usuarios.php, Sidebar.php, Nabvar.php, menu.php
## 2 - Comentar dichas lineas en los modulos de las carpetas de api -> lugares, usuarios, departamentos en donde haiga codigo
## Codigo antes de comentar en el BACKEND
    ```
    <?php
    require_once('../request-headers.php');
    require_once('../../middlewares/VerificarToken.php');
    require_once('../../controllers/UsuariosController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            $verificarTokenAcceso = new verificarTokenAcceso();
            $tokenEsValido = $verificarTokenAcceso->verificarTokenAcceso();
            if ($tokenEsValido) {
                if (
                    isset($_POST['nombrePersona']) && 
                    isset($_POST['apellidoPersona']) && 
                    isset($_POST['codigoEmpleado']) && 
                    isset($_POST['fechaNacimiento']) && 
                    isset($_POST['idDepartamento']) && 
                    isset($_POST['idTipoUsuario']) && 
                    isset($_POST['correoInstitucional']) && 
                    isset($_POST['nombreUsuario']) && 
                    isset($_POST['idPais']) && 
                    isset($_POST['idDepartamentoPais']) && 
                    isset($_POST['idMunicipioCiudad']) && 
                    isset($_POST['nombreLugar'])) {
                    $usuario = new UsuariosController();
                    $usuario->registrarUsuario($_POST['nombrePersona'],$_POST['apellidoPersona'],$_POST['codigoEmpleado'],$_POST['fechaNacimiento'],$_POST['idDepartamento'],$_POST['idTipoUsuario'],$_POST['correoInstitucional'],$_POST['nombreUsuario'],$_POST['idPais'],$_POST['idDepartamentoPais'],$_POST['idMunicipioCiudad'],$_POST['nombreLugar']);
                } else {
                    $usuario = new UsuariosController();
                    $usuario->peticionNoValida();
                }
            } else {
                $usuario = new UsuariosController();
                $usuario->peticionNoAutorizada();
                require_once('../destruir-sesiones.php');
            }
        break;
        default: 
            $usuario = new UsuariosController();
            $usuario->peticionNoValida();
        break;
    }
?>
    ```
## Codigo Comentado solo en las lineas necesarias 
    ```
    <?php
    require_once('../request-headers.php');
    //require_once('../../middlewares/VerificarToken.php');
    require_once('../../controllers/UsuariosController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            //$verificarTokenAcceso = new verificarTokenAcceso();
            //$tokenEsValido = $verificarTokenAcceso->verificarTokenAcceso();
            //if ($tokenEsValido) {
                if (
                    isset($_POST['nombrePersona']) && 
                    isset($_POST['apellidoPersona']) && 
                    isset($_POST['codigoEmpleado']) && 
                    isset($_POST['fechaNacimiento']) && 
                    isset($_POST['idDepartamento']) && 
                    isset($_POST['idTipoUsuario']) && 
                    isset($_POST['correoInstitucional']) && 
                    isset($_POST['nombreUsuario']) && 
                    isset($_POST['idPais']) && 
                    isset($_POST['idDepartamentoPais']) && 
                    isset($_POST['idMunicipioCiudad']) && 
                    isset($_POST['nombreLugar'])) {
                    $usuario = new UsuariosController();
                    $usuario->registrarUsuario($_POST['nombrePersona'],$_POST['apellidoPersona'],$_POST['codigoEmpleado'],$_POST['fechaNacimiento'],$_POST['idDepartamento'],$_POST['idTipoUsuario'],$_POST['correoInstitucional'],$_POST['nombreUsuario'],$_POST['idPais'],$_POST['idDepartamentoPais'],$_POST['idMunicipioCiudad'],$_POST['nombreLugar']);
                } else {
                    $usuario = new UsuariosController();
                    $usuario->peticionNoValida();
                }
            //} else {
            //    $usuario = new UsuariosController();
            //    $usuario->peticionNoAutorizada();
            //    require_once('../destruir-sesiones.php');
            //}
        break;
        default: 
            $usuario = new UsuariosController();
            $usuario->peticionNoValida();
        break;
    }
    ?>
    ```

## Codigo antes de comentar en el FRONTEND
    ```
        <?php
            session_start();
            if (!isset($_SESSION['correoInstitucional'])) {
                header('Location: 401.php');
            }
            $superAdmin = 'SU_AD';
            if ($_SESSION['abrevTipoUsuario'] != $superAdmin) {
                header('Location: 401.php');
            }
            include('../partials/doctype.php');
            include('verifica-session.php');
        ?>
    ```

## Codigo antes de comentar en el FRONTEND
    ```
        <?php
            //session_start();
            //if (!isset($_SESSION['correoInstitucional'])) {
            //    header('Location: 401.php');
            //}
            //$superAdmin = 'SU_AD';
            //if ($_SESSION['abrevTipoUsuario'] != $superAdmin) {
            //    header('Location: 401.php');
            //}
            include('../partials/doctype.php');
            include('verifica-session.php');
        ?>
    ```
## 3 - Despues de comentar esto ya podras registrar un usuario, una vez registrado descomentar el codigo para evitar los huecos de seguridad y hacer login como se debe
## 4 - Tip util -> deben comentaro todo lo relacionado con sesiones en php

# Anexar campo unidadMedida a tabla descripcionAdministrativa

-> Visualizacion Actividades Agrupadas por departamento -> 

my user -> bsancheza@unah.hn , YTsisOwvTcVx
        -> mfsancheza@unah.hn , vgytLqOEUU4B

        IS -> Coordinador
        -> usernameOne@unah.hn, ygXAqc55uJ8B

        IS -> Jefe Depto
        -> usernameTwo@unah.hn , yxsNQ$uxC1Dn 

        IE -> Coordinador
        -> usernameThree@unah.hn, vV6Z0R60ibrl

        IE -> Jefe Depto
        -> usernameFour@unah.hn, S1nZ$87$p@sO

        II -> Coordinador   
        -> usernameFive@unah.hn, Ja9BfFqBMvp$

        II -> Jefe Depto
        -> usernameSix@unah.hn, T3XfM48@Uhow

        IQ -> Coordinador Carera
        -> usernameSeven@unah.hn, u4@Waro4@9MT

        IQ -> Jefe depto
        -> usernameEight@unah.hn, ozDtBYfhhpvN 

        IM -> Coordinador Carera
        -> usernameNine@unah.hn, bDJqEEQZWBAz
        IM -> Jefe depto
        -> usernameTen@unah.hn, Le03FcoUTCBh

        IC -> Coordinador Carrera
        -> usernameElevens@unah.hn, v4TOJPaeVYW1

        IC -> Jefe Carrera
        -> usernameTwelve@unah.hn, bDJqEEQZWBAz

        Secretaria Academica
        academiS@unah.hn, YIL3SNRykUP2



        PhpSpreadsheet

Datos: 1.Informe de Viaje 2. Reuniones con la DAFT 3. Listas de Asistencia
 4. Informes trimestales 5. Reuniones de avance del proyecto.
 

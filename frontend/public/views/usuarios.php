<?php
include('../partials/doctype.php');;
?>
<title>Control de Usuarios</title>
<!--En esta zona podran poner estilos propios de la vista-->
<link rel="stylesheet" href="../css/sweet-alert-two/sweetalert2.min.css">
</head>

<body id="body-pd">
    <?php include('../layouts/Nabvar.php'); ?>
    <?php include('../layouts/Sidebar.php'); ?>

    <div id="profile-card" class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header indigo darken-4 text-white">
                        <h5 class="font-weight-bolder"> Maneja el control de usuarios desde este panel</h5>
                    </div>
                    <div class="card-body  blue lighten-5">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 mb-3">
                                    <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                        <div class="card-header amber accent-4">
                                            <div class="row">
                                                <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                    <h6 class="text-white font-weight-bold">
                                                        Visualizar Usuarios
                                                    </h6>
                                                </div>
                                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                    <img src="../img/partial-sidebar/usuarios-icon.svg" alt="Control de Usuarios">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="view overlay">
                                                <img class="card-img-top" src="../img/usuarios/visualizar-usuarios.svg" alt="registrar usuario">
                                            </div>
                                            <hr>
                                            <button type="button" class="btn btn-indigo btn-block" data-toggle="modal" data-target="#modalVisualizarUsuarios">
                                                Visualizar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 mb-3">
                                    <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                        <div class="card-header amber accent-4">
                                            <div class="row">
                                                <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                    <h6 class="text-white font-weight-bold">
                                                        Registrar Usuario
                                                    </h6>
                                                </div>
                                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                    <img src="../img/partial-sidebar/usuarios-icon.svg" alt="Control de Usuarios">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <br />
                                            <div class="view overlay">
                                                <img class="card-img-top" src="../img/usuarios/registrar-usuario.svg" alt="registrar usuario">
                                            </div>
                                            <hr>
                                            <button type="button" class="btn btn-indigo btn-block" data-toggle="modal" data-target="#modalRegistrarUsuarios">
                                                Registrar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 mb-3">
                                    <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                        <div class="card-header amber accent-4">
                                            <div class="row">
                                                <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                    <h6 class="text-white font-weight-bold">
                                                        Modificar Usuario
                                                    </h6>
                                                </div>
                                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                    <img src="../img/partial-sidebar/usuarios-icon.svg" alt="Control de Usuarios">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <br>
                                            <div class="view overlay">
                                                <img class="card-img-top" src="../img/usuarios/modificar-usuario.svg" alt="registrar usuario">
                                            </div>
                                            <hr>
                                            <button type="button" class="btn btn-indigo btn-block" data-toggle="modal" data-target="#modalModificarUsuarios">
                                                Modificar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer amber accent-4">

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--modales-->
    <!--Visualizar usuarios-->
    <div class="modal fade" id="modalVisualizarUsuarios" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Listado de usuarios registrados</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    ...
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!--Registrar usuarios-->
    <div class="modal fade" id="modalRegistrarUsuarios" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Formulario para registro de usuarios</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="formulario-registro-personas" class="text-center" style="color: #757575;">
                        <div class="form-row">
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                <div class="md-form">
                                    <input 
                                        type="text" 
                                        id="R-nombrePersona" 
                                        class="form-control nombrePersona" 
                                        required>
                                    <span id="errorsR-nombrePersona" class="text-danger text-small d-none">

                                    </span>
                                    <label 
                                        for="R-nombrePersona" 
                                        id="labelR-nombrePersona"
                                    >Escriba los Nombres de la persona
                                    </label>
                                    
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                <div class="md-form">
                                    <input 
                                        type="text" 
                                        id="R-apellidoPersona" 
                                        class="form-control" 
                                        required>
                                    <span id="errorsR-apellidoPersona" class="text-danger text-small d-none">
                                    </span>
                                    <label 
                                        for="R-apellidoPersona"
                                        id="labelR-apellidoPersona"
                                    >
                                        Escriba los apellidos de la persona
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                <div class="md-form">
                                    <input type="number" id="R-codigoEmpleado" class="form-control" required>
                                    <span id="errorsR-codigoEmpleado" class="text-danger text-small d-none"></span>
                                    <label for="R-codigoEmpleado" id="labelR-codigoEmpleado">Escriba el codigo empleado: XXXXX</label>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                <div class="md-form">
                                    <div  
                                        class="md-form md-outline input-with-post-icon datepicker" 
                                        inline="true">
                                        <input 
                                            placeholder="Select date" 
                                            type="date"
                                            class="form-control"
                                            id="R-fechaNacimiento"
                                            >
                                        <span id="errorsR-fechaNacimiento" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="R-fechaNacimiento"
                                            id="labelR-fechaNacimiento"
                                            >Fecha nacimiento persona
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                <div class="md-form">
                                    <select class="browser-default custom-select" id="R-idDepartamento" required>
                                        <option value='' selected>Seleccione departamento</option>
                                        <option value="1">Ingeneria Sistemas</option>
                                        <option value="2">Ingenieria Civil</option>
                                        <option value="3">Ingenieria Industrial</option>
                                        <option value="4">Ingenieria Quimica</option>
                                    </select>
                                    <span id="errorsR-idDepartamento" class="text-danger text-small d-none">
                                    </span>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                <div class="md-form">
                                    <select class="browser-default custom-select" id="R-idTipoUsuario" required>
                                        <option value='' selected>Seleccione tipo usuario</option>
                                        <option value="1">Super Administrador</option>
                                        <option value="2">Secretaria General</option>
                                        <option value="3">Decano Facultad</option>
                                        <option value="4">Secretaria Administrativa</option>
                                        <option value="5">Jefe Departamento</option>
                                        <option value="6">Coordinador Carrera</option>
                                    </select>
                                    <span id="errorsR-idTipoUsuario" class="text-danger text-small d-none">
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                <div class="md-form">
                                    <select class="browser-default custom-select" id="R-idPais" required>
                                        <option value='' selected>Seleccione Direcion Pais</option>
                                        <option value="1">Honduras</option>
                                        <option value="2">United States</option>
                                        <option value="3">Dubail</option>
                                        <option value="4">Secretaria Administrativa</option>
                                        <option value="5">Jefe Departamento</option>
                                        <option value="6">Coordinador Carrera</option>
                                    </select>
                                    <span id="errorsR-idPais" class="text-danger text-small d-none">
                                    </span>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                <div class="md-form">
                                    <select class="browser-default custom-select" id="R-idDepartamentoPais" required>
                                        <option value='' selected>Seleccione Ciudad/Provincia Pais</option>
                                        <option value="1">Comayagua</option>
                                        <option value="2">Francisco Morazan</option>
                                    </select>
                                    <span id="errorsR-idDepartamentoPais" class="text-danger text-small d-none">
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                <div class="md-form">
                                    <textarea 
                                        id="nombreLugar" 
                                        class="md-textarea form-control" 
                                        rows="2">
                                    </textarea>
                                    <label 
                                    for="nombreLugar">
                                    Direccion residencia persona/ Campo Opcional
                                    </label>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                <div class="md-form">
                                    <input 
                                        type="email" 
                                        id="R-correoInstitucional"
                                        class="form-control" 
                                        required>
                                    <span 
                                        id="errorsR-correoInstitucional" 
                                        class="text-danger text-small d-none"
                                    >
                                    </span>
                                    <label 
                                        for="R-correoInstitucional" 
                                        id="labelR-correoInstitucional">
                                        Escriba correo institucional persona
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-row d-none">
                            <div class="col">
                                <div class="md-form">
                                    <input 
                                        type="file" 
                                        class="custom-file-input" 
                                        id="avatar" 
                                        lang="es"
                                        onchange="verificarImagen(this)">
                                    <label 
                                        class="custom-file-label text-center" 
                                        for="avatar">
                                        Seleccionar Fotografia / Campo Opcional
                                    </label>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <div class="text-center mt-4">
                        <button 
                            type="button" 
                            class="btn btn-light-green btn-rounded" 
                            onclick="verificarCamposRegistro()">
                            Registrar Usuario
                        </button>
                    </div>
                    <div class="text-center mt-4">
                        <button 
                            type="button" 
                            class="btn btn-danger btn-rounded" 
                            data-dismiss="modal" 
                            aria-label="Close">
                            Cancelar
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--Modificar usuarios-->
    <div class="modal fade" id="modalModificarUsuarios" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Formulario para modificar usuarios</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    ...
                </div>
                <div class="modal-footer">
                    <div class="text-center mt-4">
                        <button type="button" class="btn btn-light-green btn-rounded">Guardar Cambios</button>
                    </div>
                    <div class="text-center mt-4">
                        <button type="button" class="btn btn-danger btn-rounded" data-dismiss="modal" aria-label="Close">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--En esta zona podran poner javascripts propios de la vista-->

    <script src="../js/sweet-alert-two/sweetalert2.min.js"></script>
    <script src="../js/libreria-bootstrap-mdb/jquery.min.js"></script>
    <script src="../js/config/config.js"></script>
    <script src="../js/validators/form-validator.js"></script>
    <script src="../js/usuarios/usuarios.controller.js"></script>
    <?php
    include('../partials/endDoctype.php');
    ?>
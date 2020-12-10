<?php
    include('../partials/doctype.php');;
?>
<title>Control de Usuarios</title>
<!--En esta zona podran poner estilos propios de la vista-->
<link rel="stylesheet" href="../css/animaciones/animate.min.css" />
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
                                                <img 
                                                    class="card-img-top" 
                                                    src="../img/usuarios/visualizar-usuarios.svg" 
                                                    alt="registrar usuario">
                                            </div>
                                            <hr>
                                            <button 
                                                type="button"
                                                class="btn btn-indigo btn-block"  
                                                data-toggle="modal" 
                                                data-target="#modalVisualizarUsuarios">
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
                                                <img 
                                                    class="card-img-top" 
                                                    src="../img/usuarios/registrar-usuario.svg" 
                                                    alt="registrar usuario">
                                            </div>
                                            <hr>
                                            <button 
                                                type="button"
                                                class="btn btn-indigo btn-block"  
                                                data-toggle="modal" 
                                                data-target="#modalRegistrarUsuarios">
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
                                            <button 
                                                type="button"
                                                class="btn btn-indigo btn-block"  
                                                data-toggle="modal" 
                                                data-target="#modalModificarUsuarios">
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
    <div 
        class="modal fade" 
        id="modalVisualizarUsuarios" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
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
    <div 
        class="modal fade" 
        id="modalRegistrarUsuarios" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Formulario para registro de usuarios</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    ...
                </div>
                <div class="modal-footer">
                    <div class="text-center mt-4">
                        <button 
                            type="button" 
                            class="btn btn-light-green btn-rounded"
                            onclick="registroUsuarioExitoso()">
                                Registrar Usuario
                        </button>
                    </div>
                    <div class="text-center mt-4">
                        <button type="button" class="btn btn-danger btn-rounded" data-dismiss="modal" aria-label="Close">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--Modificar usuarios-->
    <div 
        class="modal fade" 
        id="modalModificarUsuarios" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
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
    <script src="../js/usuarios/usuarios.controller.js"></script>
<?php
    include('../partials/endDoctype.php');
?>

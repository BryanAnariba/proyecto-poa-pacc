<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    $coordinador = 'C_C';
    $jefe = 'J_D';
    if ($_SESSION['abrevTipoUsuario'] != $coordinador and $_SESSION['abrevTipoUsuario'] != $jefe) {
        header('Location: 401.php');
    }
    if (!isset($_SESSION['correoInstitucional'])) {
        header('Location: 401.php');
    }
    include('../partials/doctype.php');;
    include('verifica-session.php');
?>
<title>Control de Carreras</title>
<!--En esta zona podran poner estilos propios de la vista-->
<link rel="stylesheet" href="../css/animaciones/animate.min.css">
<!-- <link rel="stylesheet" href="../css/control-estudiantes-docentes/control-estudiantes-docentes.css"> -->
<link href='../css/calendario-actividades/calendario.css' rel='stylesheet'>
<link rel="stylesheet" href="../css/sweet-alert-two/sweetalert2.min.css">
<script src="../js/libreria-bootstrap-mdb/jquery.min.js" type="text/javascript"></script>   

<link rel="stylesheet" href="../js/data-tables/datatables.min.css">
<link rel="stylesheet" href="../js/data-tables/DataTables/css/dataTables.bootstrap4.min.css">


</head>

<body id="body-pd">
    <?php include('../layouts/Nabvar.php'); ?>
    <?php include('../layouts/Sidebar.php'); ?>
    
    <div id="profile-card" class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header indigo darken-4 text-white">
                        <h5 class="font-weight-bolder">Control de Docentes y Estudiantes</h5>
                    </div>
                    <div class="card-body  blue lighten-5">
                        <div class="container-fluid">
                            <div class="row text-center mx-auto">
                                <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 mb-3 ml-auto">
                                    <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                        <div class="card-header amber accent-4">
                                            <div class="row">
                                                <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                    <h6 class="text-white font-weight-bold">
                                                        Visualizar Docentes y Estudiantes
                                                    </h6>
                                                </div>
                                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                    <img src="../img/control-estudiantes-docentes/control-estudiantes-docentes-icon.svg" alt="Control de Departamentos">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <br>
                                            <div class="view overlay">
                                                <img 
                                                    class="card-img-top" 
                                                    src="../img/control-estudiantes-docentes/control-estudiantes-docentes-visualizacion.svg" 
                                                    alt="visualizar DocentesEstudiantes">
                                            </div>
                                            <hr>
                                            <button 
                                                type="button"
                                                class="btn btn-indigo btn-block"  
                                                data-toggle="modal" 
                                                data-target="#modalVisualizarDocentesEstudiantes"
                                                onclick="obtenerDocentesEstudiantes()">
                                                Visualizar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 mb-3 mr-auto">
                                    <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                        <div class="card-header amber accent-4">
                                            <div class="row">
                                                <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                    <h6 class="text-white font-weight-bold">
                                                        Registrar Docentes y Estudiantes
                                                    </h6>
                                                </div>
                                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                    <img src="../img/control-estudiantes-docentes/control-estudiantes-docentes-icon.svg" alt="Control de Departamentos">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="view overlay">
                                                <img 
                                                    class="card-img-top" 
                                                    src="../img/control-estudiantes-docentes/control-estudiantes-docentes-registrar.svg" 
                                                    alt="registrar DocentesEstudiantes">
                                            </div>
                                            <hr>
                                            <button 
                                                type="button"
                                                class="btn btn-indigo btn-block"  
                                                data-toggle="modal" 
                                                data-target="#modalRegistrarDocentesEstudiantes"
                                            >
                                                Registrar
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
    <!--Visualizar poblacion Docentes y Estudiantes-->
    <div 
        class="modal fade" 
        id="modalVisualizarDocentesEstudiantes" 
        tabindex="-1" role="dialog" 
        aria-labelledby="VisualizarDocentesEstudiantesLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="VisualizarDocentesEstudiantesLabel">Listado de Docentes y Estudiantes</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body table-responsive">
                    <table id="DocentesEstudiantes" class="table" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th scope="col"style="text-align:center">#</th>
                                <th scope="col"style="text-align:center">Departamento</th>
                                <th scope="col"style="text-align:center">Trimestre</th>
                                <th scope="col"style="text-align:center">Año</th>
                                <th scope="col"style="text-align:center">Población</th>
                                <th scope="col"style="text-align:center">Cantidad</th>
                                <th scope="col"style="text-align:center">Usuario Registro</th>
                                <th scope="col"style="text-align:center">Usuario Modificación</th>
                                <th scope="col"style="text-align:center">Descargar Documento</th>
                                <th scope="col"style="text-align:center">Resubir Documento</th>
                                <th scope="col"style="text-align:center">Editar</th>
                            </tr>
                        </thead>
                    </table>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!--Registrar poblacion Docentes y Estudiantes-->
    <div 
        class="modal fade" 
        id="modalRegistrarDocentesEstudiantes" 
        tabindex="-1" role="dialog" 
        aria-labelledby="RegistrarDocentesEstudiantesLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="RegistrarDocentesEstudiantesLabel">Formulario para ingresar poblacion Docentes y Estudiantes</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body text-center mb-1">
                        <form class="text-center tabla" style="color: #757575;" action="#!">
                            <div class="container">
                                <div class="form-row container">
                                    <div class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12 col-xs-12 m-auto" align="center">
                                        <h4 class="modal-title w-100">Población a registrar:</h4>
                                        <select id="Poblacion" class="browser-default custom-select mb-4" size="1" onchange="cambiarFormulario()">

                                        </select>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <div id="tabla" class="tabla" style="display:none">
                            <h4 style="color: #757575;border-bottom:solid 1px  rgba(0, 0, 0, 0.089)" align="center" id="tituloRegistro">Estudiantes matriculados:</h4>
                            <form class="text-center" style="color: #757575;" action="#!">
                                <div class="form-row">
                                    <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-xs-12 mx-auto">
                                        <!-- Trimestre -->
                                        <div class="md-form">
                                            <select name="Trimestre" id="Trimestre" class="browser-default custom-select mb-4">
                        
                                            </select>
                                            <span id="errorsTrimestre" class="text-danger text-small d-none">
                                            </span>
                                        </div>
                                    </div>
                                    <div id="campoNum" class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-xs-12 mx-auto">
                                        
                                    </div><br>
                                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 mx-auto">
                                        <div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 col-xs-12 m-auto">
                                            <label for="respaldo" id="labelrespaldo" style="display:none"></label>
                                            <!-- <input type="file" id="respaldo" name="respaldo"> -->
                                            <input type="file" id="documentoSubido" name="documentoSubido" style="display:none" onchange="mostrarValorASubir()"> 
                                            <button type="button" class="btn btn-light-blue m-auto"
                                                onclick="$('#documentoSubido').trigger('click')"
                                            ><img src="../img/control-estudiantes-docentes/upload.svg" alt="Subir">Adjuntar documento de respaldo
                                            </button>
                                            <span id="errorsrespaldo" class="text-danger text-small d-none">
                                                
                                            </span>
                                        </div><br>
                                        <div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 col-xs-12 m-auto">
                                            <input style="width:100%" type="text" id="respaldo" name="respaldo" class="form-control" placeholder="Documento subido" readonly>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    <div class="text-center">
                        <button 
                            type="button" 
                            class="btn btn-light-green btn-rounded btn-sm" 
                            id="registrarNumero"
                            onclick="enviar()"
                            disabled>
                            Enviar
                        </button>
                    </div>
                    <div class="text-center">
                        <button onclick="CerrarModal()" 
                                type="button" 
                                class="btn btn-danger btn-rounded btn-sm" 
                                data-dismiss="modal" 
                                aria-label="Close"
                        >Cancelar
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--Modificar poblacion Docentes y Estudiantes-->
    <div 
        class="modal fade" 
        id="modalModificarDocentesEstudiantes" 
        tabindex="-1" role="dialog" 
        aria-labelledby="ModificarDocentesEstudiantesLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="ModificarDocentesEstudiantesLabel">Formulario para modificar poblacion Docentes y Estudiantes</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body text-center mb-1">
                        <div id="tablaM" class="tabla">
                            <h4 style="color: #757575;border-bottom:solid 1px  rgba(0, 0, 0, 0.089)" align="center" id="tituloRegistroM">Estudiantes matriculados:</h4>
                            <form class="text-center" style="color: #757575;" action="#!">
                                <div class="form-row">
                                    <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-xs-12 mx-auto">
                                        <!-- Trimestre -->
                                        <div class="md-form">
                                            <select name="TrimestreM" id="TrimestreM" class="browser-default custom-select mb-4">
                        
                                            </select>
                                            <span id="errorsTrimestreM" class="text-danger text-small d-none">
                                            </span>
                                        </div>
                                    </div>
                                    <div id="campoNumM" class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-xs-12 mx-auto">
                                        
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    <div class="text-center">
                        <button 
                            type="button" 
                            class="btn btn-light-green btn-rounded btn-sm" 
                            id="modificarNumero"
                            onclick="Modificar()"
                        >
                            Modificar
                        </button>
                    </div>
                    <div class="text-center">
                        <button onclick="CerrarModalM()" 
                                type="button" 
                                class="btn btn-danger btn-rounded btn-sm" 
                                data-dismiss="modal" 
                                aria-label="Close"
                                id="cerrarM"
                        >Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--En esta zona podran poner javascripts propios de la vista-->
    
    <script src="../js/sweet-alert-two/sweetalert2.min.js"></script>

    <script src="../js/data-tables/datatables.min.js"></script>

    <script src="../js/data-tables/Buttons/js/dataTables.buttons.min.js"></script>
    
    <script src="../js/config/config.js"></script>
    <script src="../js/validators/form-validator.js"></script>

    <script type="text/javascript">
        var Usuario = <?= json_encode($_SESSION) ?>;
    </script>

    <script src="../js/control-estudiantes-docentes/control-estudiantes-docentes.js"></script>

<?php
    include('../partials/endDoctype.php');
?>

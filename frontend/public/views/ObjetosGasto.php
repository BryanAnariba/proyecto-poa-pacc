<?php
    include('../partials/doctype.php');;
?>
<title>Control de Objetos del Gasto</title>
<!--En esta zona podran poner estilos propios de la vista-->
<link rel="stylesheet" href="../css/animaciones/animate.min.css" />
<link rel="stylesheet" href="../css/Carreras/Carrera.css" />
<link rel="stylesheet" href="../css/sweet-alert-two/sweetalert2.min.css">
<script src="../js/libreria-bootstrap-mdb/jquery.min.js" type="text/javascript"></script>   

<link rel="stylesheet" href="../js/data-tables/datatables.min.css">
<link rel="stylesheet" href="../js/data-tables/DataTables/css/dataTables.bootstrap4.min.css">

</head>

<body id="body-pd">
    <?php include('../layouts/Nabvar.php'); ?>
    <?php include('../layouts/Sidebar.php'); ?>
    
    <div id="profile-card" class="container">
        <div class="row mb-4">
            <div class="col-xl-12 mx-auto">
                <div class="text-center mt-4">
                    <button type="button" class="btn btn-light-green btn-rounded" onclick="DesplegarModalRegistro()">
                        <img src="../img/partial-sidebar/agregar-icon.svg" alt="">
                        Registrar un nuevo Objeto de gasto
                    </button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header indigo darken-4 text-white">
                        <h5 class="font-weight-bolder"> Maneja los Objeto del Gasto desde este panel</h5>
                    </div>
                    <div class="card-body">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="modal-body table-responsive">
                                    <table id="CarrerasTodas" class="table" cellspacing="0" width="100%">
                                        <thead>
                                            <tr align="center">
                                                <th scope="col">#</th>
                                                <th scope="col">codigoObjetoGasto</th>
                                                <th scope="col">DescripcionCuenta</th>
                                                <th scope="col">Abreviatura</th>
                                                <th scope="col">Estado</th>
                                                <th scope="col">Modificar Objeto del Gasto</th>
                                            </tr>
                                        </thead>
                                    </table>
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

    <!--Registrar Objetos-->
    <div 
        class="modal fade" 
        id="modalRegistrarObjeto" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Formulario para registro de Objetos del Gasto</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                <div class="modal-body text-center mb-1">
                    <form class="text-center" style="color: #757575;" action="#!">
                        <div class="row">
                            <div class="col-8">
                                <!-- Objeto -->
                                <div class="md-form">
                                    <input type="text" id="ObjetoDeGastoR" class="form-control">
                                    <span id="errorsObjetoDeGastoR" class="text-danger text-small d-none">
                                    </span>
                                    <label 
                                        for="ObjetoDeGastoR"
                                        id="labelObjetoDeGastoR"
                                    >
                                    Objeto de Gasto
                                    </label>
                                </div>
                            </div>
                            <div class="col-4">
                                <!-- Abrev -->
                                <div class="md-form">
                                    <input type="text" id="Abreviatura" class="form-control">
                                    <span id="errorsAbreviatura" class="text-danger text-small d-none">
                                    </span>
                                    <label 
                                        for="Abreviatura"
                                        id="labelAbreviatura"
                                    >
                                    Abrev
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-8">
                                <!-- Abrev -->
                                <div class="md-form">
                                    <input type="number" id="CodigoObjetoR" class="form-control">
                                    <span id="errorsCodigoObjetoR" class="text-danger text-small d-none">
                                    </span>
                                    <label 
                                        for="CodigoObjetoR"
                                        id="labelCodigoObjetoR"
                                    >
                                    Codigo Objeto de Gasto
                                    </label>
                                </div>
                            </div>
                            <div class="input-field col-4" align="left">
                                <label for="Estado" id="labelEstado">Estado:</label>
                                <select name="Estado" id="Estado" class="browser-default custom-select mb-4">
            
                                </select>
                                <span id="errorsEstado" class="text-danger text-small d-none">
                                </span>
                            </div>
                        </div>    

                    </form>
                </div>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    <div class="text-center">
                        <button 
                            type="button" 
                            class="btn btn-light-green btn-rounded btn-sm" 
                            onclick="registrarObjeto()">
                            Registrar Objeto de Gasto
                        </button>
                    </div>
                    <div class="text-center">
                        <button type="button" class="btn btn-danger btn-rounded btn-sm" data-dismiss="modal" aria-label="Close">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--Modificar Objeto-->
    <div 
        class="modal fade" 
        id="modalModificarObjeto" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Formulario para modificar Objetos de Gasto</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                <form class="text-center" style="color: #757575;" action="#!">

                    <div id="modifAbajo">
                        <h4 align="center">Objeto de gastos Seleccionado:</h4>
                        <div class="row">
                            <div class="col-8">
                                <!-- Objeto -->
                                <div class="md-form">
                                    <input type="text" id="ObjetoDeGasto" class="form-control">
                                    <span id="errorsObjetoDeGasto" class="text-danger text-small d-none">
                                    </span>
                                    <label 
                                        for="ObjetoDeGasto"
                                        id="labelObjetoDeGasto"
                                    >
                                    Objeto de Gasto
                                    </label>
                                </div>
                            </div>
                            <div class="col-4">
                                <!-- Abrev -->
                                <div class="md-form">
                                    <input type="text" id="Abreviatura2" class="form-control">
                                    <span id="errorsAbreviatura2" class="text-danger text-small d-none">
                                    </span>
                                    <label 
                                        for="Abreviatura2"
                                        id="labelAbreviatura2"
                                    >
                                    Abrev
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-8">
                                <!-- Abrev -->
                                <div class="md-form">
                                    <input type="number" id="CodigoObjeto" class="form-control">
                                    <span id="errorsCodigoObjeto" class="text-danger text-small d-none">
                                    </span>
                                    <label 
                                        for="CodigoObjeto"
                                        id="labelCodigoObjeto"
                                    >
                                    Codigo Objeto de Gasto
                                    </label>
                                </div>
                            </div>
                            <div class="input-field col-4" align="left">
                                <label for="EstadoModif" id="labelEstadoModif">Estado:</label>
                                <select name="EstadoModif" id="EstadoModif" class="browser-default custom-select mb-4">
            
                                </select>
                                <span id="errorsEstadoModif" class="text-danger text-small d-none">
                                </span>
                            </div>
                        </div>
                    </div>
                </form>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    <div class="text-center">
                        <button id="botonModif" type="button" class="btn btn-light-green btn-rounded btn-sm" onclick="actualizarObjeto()">Guardar Cambios</button>
                    </div>
                    <div class="text-center">
                        <button type="button" class="btn btn-danger btn-rounded btn-sm" data-dismiss="modal" aria-label="Close">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--En esta zona podran poner javascripts propios de la vista-->
    
    <script src="../js/sweet-alert-two/sweetalert2.min.js"></script>

    <script src="../js/data-tables/datatables.min.js"></script>

    <script src="../js/data-tables/Buttons/js/dataTables.buttons.min.js"></script>
    <script src="../js/data-tables/JSZip/jszip.min.js"></script>
    <script src="../js/data-tables/pdfmake/pdfmake.min.js"></script>
    <script src="../js/data-tables/pdfmake/vfs_fonts.js"></script>
    <script src="../js/data-tables/Buttons/js/buttons.html5.min.js"></script>
    
    <script src="../js/config/config.js"></script>
    <script src="../js/validators/form-validator.js"></script>

    <script src="../js/Objetos-Gasto/Objetos-Gasto.js"></script>

<?php
    include('../partials/endDoctype.php');
?>

<?php
    include('../partials/doctype.php');;
?>
<title>Control de Objetos del Gasto</title>
<!--En esta zona podran poner estilos propios de la vista-->
<link rel="stylesheet" href="../css/animaciones/animate.min.css" />
<link rel="stylesheet" href="../css/Jefe-Coordinador/visualizacion.css" />
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
                        <h5 class="font-weight-bolder">Actividades planificadas</h5>
                    </div>
                    <div class="card-body">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="modal-body table-responsive">
                                    <table id="ObjetosTodas" class="table" cellspacing="0" width="100%">
                                        <thead>
                                            <tr align="center">
                                                <th scope="col">#</th>
                                                <th scope="col">Correlativo</th>
                                                <th scope="col">Dimension Estrategica</th>
                                                <th scope="col">Objetivo Institucional</th>
                                                <th scope="col">Area Estrategica</th>
                                                <th scope="col">Tema Actividad</th>
                                                <th scope="col">Numero de Actividades definidas</th>
                                                <th scope="col">Resultados</th>
                                                <th scope="col">Justificacion</th>
                                                <th scope="col">Presupuesto por trimestre</th>
                                                <th scope="col">ver actidades</th>
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

    <!--Registos-->
    <div 
        class="modal fade" 
        id="modalRegistros" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body table-responsive">
                        <table id="RegistrosTodos" class="table" cellspacing="0" width="100%">
                            <thead>
                                <tr align="center">
                                    <th></th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    
                </div>
            </div>
        </div>
    </div>

    <!--RegistosNoT-->
    <div 
        class="modal fade" 
        id="modalRegistosNoT" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container espacioLL tabla">
                        
                    </div>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    
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

    <script src="../js/Jefe-Coordinador/listado-actividades.js"></script>

<?php
    include('../partials/endDoctype.php');
?>